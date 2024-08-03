#!/usr/bin/env bash

# This script should help facilitate setting up a new worktree, including:

# - creating a new worktree
# - installing dependencies
# - creating a new branch

set -Eeuo pipefail
trap cleanup SIGINT SIGTERM ERR EXIT

# shellcheck disable=SC2034
script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)

usage() {
  cat <<EOF
Usage: $(basename "${BASH_SOURCE[0]}") [-h] [-v] [-f] [-b branch_name] [-B base_branch_name] [-p prefix] [-N] <path>

This script facilitates setting up a new worktree, including creating a new worktree, installing dependencies, and creating a new branch.

Order of arguments:
1. -h, --help: This should be the first argument if you want to display the help message and exit.
2. -v, --verbose: This should be the second argument if you want to enable verbose mode.
3. -b, --branch: This should be the third argument if you want to specify the branch to create. It should be followed by the branch name.
4. -B, --base: This should be the fourth argument if you want to specify the base branch for the new worktree. It should be followed by the base branch name.
5. -p, --prefix: This should be the fifth argument if you want to specify the prefix to apply to the branch name. It should be followed by the prefix.
6. -N, --no-create-upstream: This should be the sixth argument if you do not want to create an upstream branch.
7. <path>: This should be the last argument. It specifies the path where the new worktree will be created.

Available options:

-h, --help                    Print this help and exit
-v, --verbose                 Print script debug info
-b, --branch                  The branch to create
-B, --base                    The branch to use as the base for the new worktree (default: main)
-p, --prefix                  The prefix to apply to the branch name (default: $(git config github.user)/)
-N, --no-create-upstream      Do not create an upstream branch

This script performs the following steps:

1. Create a new worktree, based off the base branch (default: main)
2. Create a new upstream branch to track the work
3. Install dependencies
4. Run a build

Examples:

1. Create a new worktree with a new branch:
   ./create-wt.sh -b new-feature -B main -p feature/ ~/worktrees/new-feature
   or: 
    gwt -b feat/shah_peds -B main shah-peds
    gwt -b (prefix/branch_name) -B (branch_to_base_from) (location_to_put_repo)
2. Create a new worktree from an existing branch:
   ./create-wt.sh ~/worktrees/existing-feature
EOF
  exit
}

cleanup() {
  trap - SIGINT SIGTERM ERR EXIT
  tput cnorm # enable cursor
  # script cleanup here
}

setup_colors() {
  if [[ -t 2 ]] && [[ -z "${NO_COLOR-}" ]] && [[ "${TERM-}" != "dumb" ]]; then
    # shellcheck disable=SC2034
    NOFORMAT='\033[0m' GRAY='\033[0;90m' RED='\033[0;31m' GREEN='\033[0;32m' ORANGE='\033[0;33m' BLUE='\033[0;34m' PURPLE='\033[0;35m' CYAN='\033[0;36m' YELLOW='\033[1;33m'
  else
    # shellcheck disable=SC2034
    NOFORMAT='' GRAY='' RED='' GREEN='' ORANGE='' BLUE='' PURPLE='' CYAN='' YELLOW=''
  fi
}

msg() {
  echo >&2 -e "${1-}"
}

# log() {
#   echo >&2 -ne "${1-}"
# }

info() {
  msg "${GRAY}[INFO]${NOFORMAT} ${1-}"
}

die() {
  local msg=$1
  local code=${2-1} # default exit status 1
  msg "$msg"
  exit "$code"
}

function spinner() {
  # make sure we use non-unicode character type locale
  # (that way it works for any locale as long as the font supports the characters)
  local LC_CTYPE=C
  local pid=$1 # Process Id of the previous running command
  local spin='⣾⣽⣻⢿⡿⣟⣯⣷'
  local charwidth=3

  local i=0
  tput civis # cursor invisible
  while kill -0 "$pid" 2>/dev/null; do
    local i=$(((i + charwidth) % ${#spin}))
    printf >&2 "%s" "${spin:$i:$charwidth}"

    printf >&2 "\b"
    sleep .1
  done
  tput cnorm
  wait "$pid" # capture exit code
  return $?
}

run_command() {
  local message=$1
  shift
  echo >&2 -ne "$message "
  "$@" &>/dev/null &
  spinner $!
  # shellcheck disable=SC2181
  if [ $? -eq 0 ]; then
    echo >&2 -e " ${GREEN}Done.${NOFORMAT}"
  else
    echo >&2 -e " ${RED}FAILED.${NOFORMAT}"
    exit 1
  fi
}

parse_params() {
  # default values of variables set from params
  create_upstream=1
  prefix="$(git config github.user)/"
  base='origin/main'
  branch=''

  while :; do
    case "${1-}" in
    -h | --help) usage ;;
    -v | --verbose) set -x ;;
    --no-color) NO_COLOR=1 ;;
    -N | --no-create-upstream) create_upstream=0 ;;
    -b | --branch)
      branch="$2"
      shift
      ;;
    -B | --base)
      base="${2-}"
      shift
      ;;
    -?*) die "Unknown option: $1" ;;
    *) break ;;
    esac
    shift
  done

  args=("$@")

  # check required params and arguments
  # [[ -z "${param-}" ]] && die "Missing required parameter: param"
  [[ ${#args[@]} -eq 0 ]] && die "Missing script arguments"

  # if a branch was not specified, generate one based on the prefix and folder name
  if [[ -z "$branch" ]]; then
    branch="${prefix}${args[0]}"
  fi

  worktree="${args[0]}"

  return 0
}

parse_params "$@"
setup_colors

update_remote() {
  local branch="$1"

  # do nothing if create_upstream is disabled
  [ $create_upstream -eq 0 ] && return 0

  if [[ -z "$(git ls-remote --heads origin "$branch")" ]]; then
    # create remote branch
    msg "${GRAY}Branch '$branch' does not exist on remote. Creating."
    run_command "Creating remote branch ${branch}..." git push -u origin "$branch"
  else
    msg "${GRAY}Branch '$branch' exists. Setting upstream."
    run_command "Setting upstream branch to 'origin/$branch'" git branch --set-upstream-to="origin/$branch"
  fi
}

# check if branch already exists
if [[ -n "$(git branch --list "$branch")" ]]; then
  run_command "Generating new worktree from existing branch: $branch" git worktree add "$worktree" "$branch"
else
  run_command "Generating new worktree: $worktree" git worktree add -b "$branch" "$worktree" "$base"
fi

msg "${GRAY}Moving into worktree: $worktree${NOFORMAT}"
cd "$worktree"
update_remote "$branch"
# run_command "Setting Node version" fnm use < .nvmrc
# run_command "Installing dependencies" npm --no-progress --silent install
# run_command "Building App" npm run --silent build
msg "${GREEN}Success.${NOFORMAT}"

#!/usr/bin/env bash

# This script should help facilitate setting up a new worktree, including:

# - creating a new worktree
# - installing dependencies
# - creating a new branch

set -Eeuo pipefail
trap cleanup SIGINT SIGTERM ERR EXIT

# shellcheck disable=SC2034
script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)

setup_colors() {
  if [[ -t 2 ]] && [[ -z "${NO_COLOR-}" ]] && [[ "${TERM-}" != "dumb" ]]; then
    NOFORMAT='\033[0m' RED='\033[0;31m' GREEN='\033[0;32m' ORANGE='\033[0;33m' BLUE='\033[0;34m' PURPLE='\033[0;35m' CYAN='\033[0;36m' YELLOW='\033[1;33m'
  else
    NOFORMAT='' RED='' GREEN='' ORANGE='' BLUE='' PURPLE='' CYAN='' YELLOW=''
  fi
}

echocolor() {
  local color="$1"
  shift
  printf "%b%s%b\n" "${!color}" "$*" "$NOFORMAT"
}

usage() {
  echocolor BLUE "Usage: $(basename "${BASH_SOURCE[0]}") [-h] [-v] [-b branch_name] [-B base_branch_name] [-p prefix] [-N] <path>"
  echo

  echocolor YELLOW "This script facilitates setting up a new worktree, including creating a new worktree, creating a new branch, setting up remote tracking, and running uv sync if pyproject.toml is present."
  echo

  echocolor PURPLE "Order of arguments:"
  echocolor GREEN "1. -h, --help:" "This should be the first argument if you want to display the help message and exit."
  echocolor GREEN "2. -v, --verbose:" "This should be the second argument if you want to enable verbose mode."
  echocolor GREEN "3. -b, --branch:" "This should be the third argument if you want to specify the branch to create. It should be followed by the branch name."
  echocolor GREEN "4. -B, --base:" "This should be the fourth argument if you want to specify the base branch for the new worktree. It should be followed by the base branch name."
  echocolor GREEN "5. -p, --prefix:" "This should be the fifth argument if you want to specify the prefix to apply to the branch name. It should be followed by the prefix."
  echocolor GREEN "6. -N, --no-create-upstream:" "This should be the sixth argument if you do not want to create an upstream branch."
  echocolor GREEN "7. <path>:" "This should be the last argument. It specifies the path where the new worktree will be created."
  echo

  echocolor PURPLE "Available options:"
  echocolor GREEN "-h, --help" "                   Print this help and exit"
  echocolor GREEN "-v, --verbose" "                Print script debug info"
  echocolor GREEN "-b, --branch" "                 The branch to create"
  echocolor GREEN "-B, --base" "                   The branch to use as the base for the new worktree (default: main)"
  echocolor GREEN "-p, --prefix" "                 The prefix to apply to the branch name (default: $(git config github.user)/)"
  echocolor GREEN "-N, --no-create-upstream" "     Do not create an upstream branch"
  echo

  echocolor PURPLE "This script performs the following steps:"
  echo "1. Create a new worktree, based off the base branch (default: main)"
  echo "2. Create a new upstream branch to track the work (unless -N is specified)"
  echo "3. Install dependencies if pyproject.toml is present (using uv sync)"
  echo

  echocolor PURPLE "Examples:"
  echocolor CYAN "1. Create a new worktree with a new branch:"
  echocolor YELLOW "   $(basename "${BASH_SOURCE[0]}") -b new-feature -B main -p feature/ ~/worktrees/new-feature"
  echocolor ORANGE "   or:"
  echocolor YELLOW "   $(basename "${BASH_SOURCE[0]}") -b feat/user_auth -B develop user-authentication"
  echo

  echocolor CYAN "2. Create a new worktree from an existing branch:"
  echocolor YELLOW "   $(basename "${BASH_SOURCE[0]}") ~/worktrees/existing-feature"
  echo

  echocolor CYAN "3. Create a new worktree without creating an upstream branch:"
  echocolor YELLOW "   $(basename "${BASH_SOURCE[0]}") -N -b local-experiment ~/worktrees/experiment"
  echo

  echocolor CYAN "4. Create a new worktree with a custom prefix:"
  echocolor YELLOW "   $(basename "${BASH_SOURCE[0]}") -p hotfix/ -b critical-fix ~/worktrees/urgent-fix"
}

# Make sure to call setup_colors before usage
setup_colors

cleanup() {
  trap - SIGINT SIGTERM ERR EXIT
  tput cnorm # enable cursor
  # script cleanup here
}

msg() {
  echo >&2 -e "${1-}"
}

info() {
  msg "${GRAY}[INFO]${NOFORMAT} ${1-}"
}

die() {
  local msg=$1
  local code=${2-1} # default exit status 1
  msg "${RED}${msg}${NOFORMAT}"
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
      branch="${2-}"
      shift
      ;;
    -B | --base)
      base="${2-}"
      shift
      ;;
    -p | --prefix)
      prefix="${2-}"
      shift
      ;;
    -?*) die "Unknown option: $1" ;;
    *) break ;;
    esac
    shift
  done

  args=("$@")

  [[ ${#args[@]} -eq 0 ]] && die "Missing script arguments"

  # if a branch was not specified, generate one based on the prefix and folder name
  if [[ -z "$branch" ]]; then
    branch="${prefix}${args[0]##*/}"
  fi

  worktree="${args[0]}"

  return 0
}

parse_params "$@"

update_remote() {
  local branch="$1"

  # do nothing if create_upstream is disabled
  [ $create_upstream -eq 0 ] && return 0

  if ! git ls-remote --exit-code --heads origin "$branch" &>/dev/null; then
    msg "${CYAN}Branch '$branch' does not exist on remote. Creating.${NOFORMAT}"
    if ! git push -u origin "$branch"; then
      die "Failed to create remote branch ${branch}"
    fi
  else
    msg "${CYAN}Branch '$branch' exists. Setting upstream.${NOFORMAT}"
    if ! git branch --set-upstream-to="origin/$branch"; then
      die "Failed to set upstream to 'origin/$branch'"
    fi
  fi
}

# check if branch already exists
if git show-ref --verify --quiet "refs/heads/$branch"; then
  if ! git worktree add "$worktree" "$branch"; then
    die "Failed to create worktree from existing branch: $branch"
  fi
else
  if ! git worktree add -b "$branch" "$worktree" "$base"; then
    die "Failed to create new worktree: $worktree"
  fi
fi

msg "${CYAN}Moving into worktree: $worktree${NOFORMAT}"
cd "$worktree" || die "Failed to change directory to $worktree"

update_remote "$branch"
# Check for pyproject.toml and run uv sync if present
if [ -f "pyproject.toml" ]; then
  msg "${CYAN}pyproject.toml found. Running uv sync...${NOFORMAT}"
  if ! run_command "Installing dependencies" uv sync; then
    die "Failed to run uv sync"
  fi
else
  msg "${YELLOW}No pyproject.toml found. Skipping dependency installation.${NOFORMAT}"
fi
# run_command "Installing dependencies" uv sync
msg "${GREEN}Worktree setup complete.${NOFORMAT}"

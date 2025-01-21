# Setup fzf
# ---------
if [[ ! "$PATH" == */home/aktheat/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/aktheat/.fzf/bin"
fi

eval "$(fzf --bash)"

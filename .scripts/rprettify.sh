#!/usr/bin/env sh
cp "$1" "$1".bak
R --quiet --no-echo -e "styler::style_file(\"$1\")" 1>/dev/null 2>&1
cat "$1"

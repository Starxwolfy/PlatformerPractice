#!/bin/sh
printf '\033c\033]0;%s\a' funnyer
base_path="$(dirname "$(realpath "$0")")"
"$base_path/funnyer.x86_64" "$@"

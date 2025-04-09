#!/bin/sh
echo -ne '\033c\033]0;mmo-test\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/mmo-test.x86_64" "$@"

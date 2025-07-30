#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

readonly mpd_socket_path="$HOME/.config/mpd/socket"

while read -r _; do
  pkill -SIGRTMIN+1 waybar
done < <(mpc -h "$mpd_socket_path" idleloop player options)

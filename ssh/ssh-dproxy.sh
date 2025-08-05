#!/bin/bash

readonly user=""
readonly host=""
readonly port=""

function get_ssh_pid() {
  pgrep -f "ssh -D $port -N -f $user@$host" || echo ""
}

function start_ssh_socks_proxy() {
  if ssh -D "$port" -N -f "$user@$host" 2>/dev/null; then
    return 0
  fi
}

function stop_ssh_socks_proxy() {
  local pid
  pid=$(get_ssh_pid)
  [[ -n $pid ]] && kill "$pid"
}

function waybar_status() {
  if [[ -n $(get_ssh_pid) ]]; then
    echo "󱠽"
  else
    echo "󱠾"
  fi
}

function waybar_toggle() {
  if [[ -n $(get_ssh_pid) ]]; then
    stop_ssh_socks_proxy
  else
    start_ssh_socks_proxy
  fi
}

case "${1:-}" in
status)
  waybar_status
  ;;
toggle)
  waybar_toggle
  pkill -SIGRTMIN+25 waybar
  waybar_status
  ;;
esac

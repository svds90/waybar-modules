#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

readonly mpd_socket_path="$HOME/.config/mpd/socket"

function mpc_current_song() {
  mpc -h "$mpd_socket_path" current
}

function mpc_toggle() {
  mpc -h "$mpd_socket_path" toggle
}

function mpc_next_song() {
  mpc -h "$mpd_socket_path" next
}

function mpc_prev_song() {
  mpc -h "$mpd_socket_path" prev
}

function mpc_single_song() {
  mpc -h "$mpd_socket_path" single
}

function mpc_full_info() {
  mpc -h "$mpd_socket_path" status
}

function waybar_output() {
  status=$(mpc_full_info)
  song="${status%%$'\n'*}"

  if [[ $status =~ \[playing\] ]]; then
    state="󰏤"
  elif [[ $status =~ \[paused\] ]]; then
    state="󰐊"
  else
    state="󰓛"
  fi

  if [[ $status =~ single:\ (on|off) ]]; then
    single="${BASH_REMATCH[1]}"
  fi

  case "$single" in
  on) single_icon="󰑘" ;;
  off) single_icon="󰑖" ;;
  *) single_icon="󰑗" ;;
  esac

  echo "$single_icon $state $song"
}

if [[ $# -gt 0 ]]; then
  case "$1" in
  next)
    mpc_next_song
    ;;
  prev)
    mpc_prev_song
    ;;
  toggle)
    mpc_toggle
    ;;
  single)
    mpc_single_song
    ;;
  esac
fi

waybar_output

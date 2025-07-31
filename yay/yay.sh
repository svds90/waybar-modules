#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

function get_yay_updates() {
  yay -Qu | awk '{print $1}'
}

function waybar_output() {
  yay_update_list=$(get_yay_updates)
  yay_updates_count=$(echo "$yay_update_list" | sed '/^$/d' | wc -l)

  if [[ $yay_updates_count -eq 0 ]]; then
    echo "  0 "
  elif [[ $yay_updates_count -gt 0 ]]; then
    tooltip=$(echo "$yay_update_list" | paste -sd ' - ' -)

    echo " $yay_updates_count"
    echo "$tooltip"
  else
    echo "󰅛"
  fi
}

waybar_output

#!/usr/bin/env bash

if [[ "$1" == "area" ]]; then
  grimblast copy area --cursor || notify-send "Hyprland" "Screenshot aborted."
elif [[ "$1" == "output" ]]; then
  grimblast copy output --cursor && notify-send "Hyprland" "Screenshot taken."
fi

hyprctl reload

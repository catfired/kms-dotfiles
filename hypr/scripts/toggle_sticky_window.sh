#!/usr/bin/env bash

if [[ $(hyprctl activewindow -j | jq -r ".workspace.id") == "-99" ]]; then
  hyprctl dispatch movetoworkspace e+0 && notify-send 'Hyprland' 'Made window not sticky.'
else
  hyprctl dispatch movetoworkspace special && notify-send 'Hyprland' 'Made window sticky.'
fi

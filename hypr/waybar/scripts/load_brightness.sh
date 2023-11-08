#!/usr/bin/env bash

brightnessctl --restore && notify-send 'Brightness Module' 'Screen brightness loaded!' || notify-send 'Brightness Module' 'Failed to load screen brightness!'

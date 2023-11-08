#!/usr/bin/env bash

brightnessctl --save && notify-send 'Brightness Module' 'Screen brightness saved!' || notify-send 'Brightness Module' 'Failed to save screen brightness!'

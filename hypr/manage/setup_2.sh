#!/usr/bin/env bash

source ~/.config/hypr/lib.sh

if [[ -f $HOME/.bashrc ]]; then
    echo "source ~/.config/hypr/aliases/bash.sh" >> $HOME/.bashrc
fi

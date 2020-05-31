#!/usr/bin/env bash

# Rsync karabiner config file
mkdir -p ~/.config/karabiner;
rsync -avh --no-perms karabiner.json ~/.config/karabiner;


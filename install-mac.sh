#!/bin/bash

source scripts/system.sh
source scripts/config.sh
source scripts/ssh.sh

# copy default gitconfig / bash_profile
sh ./bootstrap.sh

# Run Brewfile to install all dependencies
brew bundle

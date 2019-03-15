#!/usr/bin/env bash

echo
echo " # download default gitconfig / bash_profile "
curl -o .gitconfig https://gist.githubusercontent.com/ftonato/d8f16af239643893bca44f4f876133c3/raw/4cb87d6e2d365ef96727e8c958b9e0090e646460/.gitconfig
curl -o .bash_profile https://gist.githubusercontent.com/ftonato/f8e720d5a8c8dd6792824f956afd7840/raw/a543584eeb5bb4275c5b736f8bbaf32c79bee08a/.bash_profile

echo
echo " # copy default gitconfig / bash_profile "
cp .gitconfig ~/.gitconfig
cp .bash_profile ~/.bash_profile

source ~/.bash_profile

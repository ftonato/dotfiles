#!/usr/bin/env bash

function ask_install() {
  echo
  echo
  read -p"$1 (y/n) " -n 1
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    return 1
  fi
  return 0

}

# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
  echo "This script must be run as root"
  echo "Plese use sudo or su"
  exit 1
fi

# use aptitude in the next steps ...
if [ \! -f $(whereis aptitude | cut -f 2 -d ' ') ] ; then
  apt-get install aptitude snapd
fi

# update && upgrade
ask_install "upgrade your system?"
if [[ $? -eq 1 ]]; then
  aptitude update
  aptitude upgrade
fi

# remove default apps
aptitude remove \
  `# optimize battery management (old)` \
  laptop-mode-tools

# install apps
aptitude install \
  `# read-write NTFS driver for Linux` \
  safe-rm \
  `# default for many other things` \
  build-essential \
  `# command line clipboard` \
  xclip \
  `# get files from web` \
  wget \
  curl \
  `# repo-tools`\
  git \
  `# usefull tools` \
  nodejs \
  npm \
  xpdf \
  perl \
  python \
  python-pip \
  python-dev \
  `# codecs audio/video tools` \
  ubuntu-restricted-extras \
  libavcodec-extra libav-tools \
  vlc

#
# fixing nodejs for ubuntu
#
ln -s /usr/bin/nodejs /usr/bin/node

#
# for survive
#
ask_install "install extras (Spotify, f.lux, tlp)?"
if [[ $? -eq 1 ]]; then

  # Add (Spotify - survive tools) repository
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 931FF8E79F0876134EDDBDCCA87FF9DF48BF1C90
  echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list

  # Add (tlp - optimize battery management) repository
  add-apt-repository ppa:linrunner/tlp

  # Add (f.lux - better lighting management) repository
  add-apt-repository ppa:nathan-renniewaldock/flux

  # Update completed list of available packages
  apt-get update

  # Install new available packages
  apt-get install \
      `# Spotify` \
      spotify-client \
      `# optimize battery management` \
      tlp tlp-rdw \
      `# better lighting management` \
      fluxgui

  #
  # TLP will start automatically
  #
  tlp start

fi


#
# for webworker
#

ask_install "install webworker tools"
if [[ $? -eq 1 ]]; then

  echo "update/install npm-packages ..."

  #npm config set strict-ssl false
  #npm config set registry http://registry.npmjs.org

  npm install -g npm
  npm update -g

  npm install -g prettier typescript yarn

fi

# clean downloaded and already installed packages
aptitude -v clean

# copy default gitconfig / bash_profile
sh ./bootstrap.sh

# show optional softwares to install
echo
echo "install these softwares for your happiness

# communication tools

> slack
> skype

# webworker tools (optionals)

> vscode
> google chrome"
echo
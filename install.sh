#!/usr/bin/env bash

function ask_install() {
  echo
  echo
  read -p"$1 (y/n) " -n 1
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    return 1
  else
    return 0
  fi

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
  #ntfs-3g \
  safe-rm \
  `# default for many other things` \
  build-essential \
  #make \
  `# unzip, unrar etc.` \
  #zip \
  #unzip
  `# interactive I/O viewer` \
  #tree \
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
  vlc \
  `# optimize battery management` \
  tlp \
  tlp-rdw

#
# TLP will start automatically
#
tlp start

#
# fixing nodejs for ubuntu
#
ln -s /usr/bin/nodejs /usr/bin/node

#
# for communication and survive
#
ask_install "install extras (skype, slack, spotify)?"
if [[ $? -eq 1 ]]; then
  snap install \
    `# communication tools` \
    slack --classic \
    skype --classic \
    `# survive tools` \
    spotify \
    fluxgui \
    `# IDE ` \
    vscode --classic
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

  npm install -g prettier typescript yarn @vue/cli

fi

# clean downloaded and already installed packages
aptitude -v clean

# copy default gitconfig / bash_profile
sh ./bootstrap.sh

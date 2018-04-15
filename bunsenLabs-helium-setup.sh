#!/bin/bash
#############################################################################
##
## Let's start by making ourselves comfortable
##
#############################################################################

echo disable touchpad

## disable touchpad at startup + create enable script
TOUCHPADID=`xinput list | grep TouchPad | awk '{print $6}' | cut -c4,5`
echo 'xinput disable' $TOUCHPADID >> ~/.config/openbox/autostart.sh
echo 'xinput enable' $TOUCHPADID > ~/bin/enable-touchpad.sh

## disable in current session
xinput disable $TOUCHPADID

chmod +x ~/bin/enable-touchpad.sh


## Configure keyboard layout
read -p "Follow steps to configure the keyboard Y/y :p" dummy

sudo dpkg-reconfigure keyboard-configuration


#############################################################################
##
## Copy custom config files
## 
## a bit like https://github.com/BunsenLabs/bunsen-configs
##
#############################################################################

echo config

bkp_sfx="~$( date +%FT%T )~"

rsync -rlb --checksum --suffix="$bkp_sfx" --safe-links skel/ "$HOME"


#############################################################################
##
## lowercase names for directories
##
#############################################################################

mkdir ~/documents ~/downloads ~/music ~/pictures ~/public ~/templates ~/videos
xdg-user-dirs-update

## todo run this post-install?
rmdir ~/Documents ~/Downloads ~/Music ~/Pictures ~/Public ~/Templates ~/Videos


#############################################################################
##
## Configure fonts
##
#############################################################################

echo fonts

## fonts
sudo apt install fonts-liberation2

## raleway, roboto

## Set a nicer default monospace font
sed -i 's/Inconsolata/Dejavu Sans Mono/g' ~/.config/fontconfig/fonts.conf

## remove heavy unused font
sudo apt remove fonts-noto-cjk


#############################################################################
##
## Thinkpad-only stuff
##
#############################################################################

echo thinkpad stuff

## Install tlp
## tp_smapi is not supported on my machine, install acpi_call module instead
sudo apt install tlp acpi-call-dkms


#############################################################################
##
## Install extra software
##
#############################################################################

echo extra software

## xbacklight
#sudo apt install xbacklight

## graphics software
sudo apt install inkscape gimp gcolor2


## ffmpeg

## screen color manager
sudo apt install redshift

## utilities
sudo apt install awscli baobab

## skype - do I really need it? via this method https://linuxconfig.org/how-to-install-skype-on-debian-9-stretch-linux#comment-3752388010 ?


## virtual machine


#############################################################################
##
## Install development software
##
#############################################################################

echo dev software

## node.js via nvm

## mariadb: let data and tmp directories inside /home partition




#############################################################################
##
## Unattended-upgrades
##
#############################################################################

## configure exim
sudo dpkg-reconfigure exim4-config

## todo




#############################################################################
##
## Cleanup
##
#############################################################################

echo cleanup

sudo apt clean

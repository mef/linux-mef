#!/bin/bash

#############################################################################
##
## Configure fonts
##
#############################################################################

echo fonts

## fonts
sudo apt install fonts-liberation2

## Set a nicer default monospace font
set i- 's/Inconsolata/Dejavu Sans Mono/g' .config/fontconfig/fonts.conf

## remove heavy unused font
sudo apt remove fonts-noto-cjk


#############################################################################
##
## Custom configuration
## 
## a bit like https://github.com/BunsenLabs/bunsen-configs
##
#############################################################################

echo config

bkp_sfx="~$( date +%FT%T )~"

rsync -rlb --checksum --suffix="$bkp_sfx" --safe-links skel/ "$HOME"


#############################################################################
##
## Install extra software
##
#############################################################################

echo extra software

## graphics software
sudo apt install inkscape gimp gcolor

## screen color manager
sudo apt install redshift

## utilities
sudo apt install baobab


## virtual machine


#############################################################################
##
## Install development software
##
#############################################################################

echo dev software

## node.js via nvm


#############################################################################
##
## Unattended-upgrades
##
#############################################################################

## todo


#############################################################################
##
## Thinkpad-only stuff
##
#############################################################################

echo thinkpad stuff

## Install tlp
## tp_smapi is not supported on my machine, install acpi_call module instead
sudo apt install tlp acpi-call-dkms


## disable touchpad t startup + create enable script
TOUCHPADID=`xinput list | grep TouchPad | awk '{print $6}' | cut -c4,5`
echo 'xinput disable $TOUCHPADID' >> ~/.config/openbox/autostart.sh
echo 'xinput enable $TOUCHPADID' > ~/bin/enable-touchpad.sh

chmod +x ~/bin/enable-touchpad.sh

#############################################################################
##
## Cleanup
##
#############################################################################

echo cleanup

sudo apt-get clean

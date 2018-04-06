#!/bin/bash

#############################################################################
##
## Configure fonts
##
#############################################################################

## fonts
sudo apt install fonts-liberation2

## Set a nicer default monospace font
set i- 's/Inconsolata/Dejavu Sans Mono/g' .config/fontconfig/fonts.conf

## remove heavy unused font
sudo apt remove fonts-noto-cjk


#############################################################################
##
## Install extra software
##
#############################################################################

## graphics software
sudo apt install inkscape gimp gcolor


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

## Install tlp
## tp_smapi is not supported on my machine, install acpi_call module instead
sudo apt install tlp acpi-call-dkms


## disable touchpad t startup + create enable script
TOUCHPADID=`xinput list | grep TouchPad | awk '{print $6}' | cut -c4,5`
echo 'xinput disable $TOUCHPADID' >> ~/.config/openbox/autostart.sh
echo 'xinput enable $TOUCHPADID' > ~/bin/enable-touchpad.sh


#!/bin/bash
set -euo pipefail

#############################################################################
##
## Let's start by making ourselves comfortable
##
#############################################################################

echo disable touchpad

## disable touchpad at startup + create enable script
echo '## disable touchpad' >> ~/.config/openbox/autostart
echo "xinput disable" $(xinput list | grep TouchPad | awk '{print $6}' | cut -c4,5) >> ~/.config/openbox/autostart
echo "xinput enable" $(xinput list | grep TouchPad | awk '{print $6}' | cut -c4,5) > ~/bin/enable-touchpad.sh

## disable in current session
xinput disable $TOUCHPADID

chmod +x ~/bin/enable-touchpad.sh


## Configure keyboard layout
read -p "Follow steps to configure the keyboard Y/y :p" dummy

sudo dpkg-reconfigure keyboard-configuration

## tweak graphics
sudo apt purge xserver-xorg-video-intel

## activate redshift at boot
echo '' >> ~/.config/openbox/autostart
echo '(sleep 3; redshift-be.sh) &' >> ~/.config/openbox/autostart

## set urxvt as default terminal
# sudo update-alternatives --set x-terminal-emulator /usr/bin/urxvt

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

mv ~/Documents ~/documents
mv ~/Downloads ~/downloads
mv ~/Music     ~/music
mv ~/Pictures  ~/pictures
mv ~/Public    ~/public
mv ~/Templates ~/templates
mv ~/Videos    ~/videos

xdg-user-dirs-update


#############################################################################
##
## Configure fonts
##
#############################################################################

echo fonts

## fonts
sudo apt install fonts-liberation2

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

sudo mkdir /opt/c-user
sudo chown c-user:c-user /opt/c-user

## xbacklight
#sudo apt install xbacklight

## graphics software
sudo apt install inkscape gimp gcolor2 cheese

## audio software
sudo apt install audacity

## chromium
sudo apt install chromium

## office
sudo apt install libreoffice-calc libreoffice-impress

## image optimization
sudo apt install optipng libjpeg-turbo-progs


## For some reason, programmatic download retrieves windows .zip instead of the linux 64 bits version.
#cd /opt/c-user
#wget -O firefox.tar.bz2 https://download.mozilla.org/?product=firefox-latest-ssl&os=linux64&lang=en-US && tar -zxvf firefox.tar.bz2
#wget -O firefox-dev.tar.bz2 https://download.mozilla.org/?product=firefox-devedition-latest-ssl&os=linux64&lang=en-US & tar -zxvf firefox-dev.tar.bz2


## ffmpeg

## unattended-upgrades
sudo apt-get install unattended-upgrades apt-listchanges

## screen color manager
sudo apt install redshift

## utilities
sudo apt install awscli baobab pdftk

## skype - do I really need it? via this method https://linuxconfig.org/how-to-install-skype-on-debian-9-stretch-linux#comment-3752388010 ?

## virtual machine
sudo apt install qemu-kvm libvirt-clients virt-manager
sudo adduser c-user kvm
sudo rmmod kvm_intel
sudo rmmod kvm
sudo modprobe kvm
sudo modprobe kvm_intel

#############################################################################
##
## Install development software
##
#############################################################################

echo dev software

## dependencies
sudo apt install g++

## redis 4.x
sudo apt install -t stretch-backports redis


## java
sudo apt install openjdk-11-jdk openjdk-11-jre

## gephi
cd /opt/c-user/
wget https://github.com/gephi/gephi/releases/download/v0.9.2/gephi-0.9.2-linux.tar.gz
tar -zxvf gephi-0.9.2-linux.tar.gz
ln -s /opt/c-user/gephi-0.9.2/bin/gephi ~/bin/
cd

## configure git to cache credentials
git config --global credential.helper cache

#############################################################################
##
## Cleanup
##
#############################################################################

echo cleanup

## delete apt cache
sudo apt clean

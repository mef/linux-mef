#!/bin/bash
set -euo pipefail

#############################################################################
##
## Let's start by making ourselves comfortable
##
#############################################################################

echo disable touchpad

## disable touchpad at startup + create enable script
echo '' >> ~/.config/bunsen/autostart
echo '## disable touchpad' >> ~/.config/bunsen/autostart
echo "xinput disable \$(xinput list | grep Touchpad | awk '{print \$6}' | cut -c4,5) &" >> ~/.config/bunsen/autostart
echo "xinput enable \$(xinput list | grep Touchpad | awk '{print \$6}' | cut -c4,5)" > ~/bin/enable-touchpad

chmod +x ~/bin/enable-touchpad

## disable in current session
xinput disable $(xinput list | grep Touchpad | awk '{print $6}' | cut -c4,5)

## Configure keyboard layout
read -p "Follow steps to configure the keyboard Y/y" dummy

sudo dpkg-reconfigure keyboard-configuration


## activate redshift at boot
echo '' >> ~/.config/bunsen/autostart
echo '(sleep 3; redshift-es) &' >> ~/.config/bunsen/autostart

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
sed -i 's/Noto Mono/Dejavu Sans Mono/g' ~/.config/fontconfig/fonts.conf


#############################################################################
##
## Thinkpad-only stuff
##
#############################################################################

echo thinkpad stuff

sudo apt install tlp


#############################################################################
##
## Install extra software
##
#############################################################################

echo extra software

sudo mkdir /opt/c-user
sudo chown c-user:c-user /opt/c-user

## graphics software
sudo apt install inkscape gimp cheese

## audio software
sudo apt install audacity

## chromium
sudo apt install chromium

## office
sudo apt install gnumeric libreoffice-impress

## image optimization
sudo apt install optipng libjpeg-turbo-progs

## ffmpeg

## unattended-upgrades
sudo apt install unattended-upgrades apt-listchanges

## screen color manager
sudo apt install redshift

## utilities
sudo apt install baobab pdftk arandr

## virtual machine

## install kvm / qemu
# sudo apt install --no-install-recommends qemu-kvm qemu-utils libvirt-daemon bridge-utils libvirt-daemon-system virt-manager dnsmasq virt-viewer libvirt-daemon-system gir1.2-spiceclientglib-2.0 dmidecode libxml2-utils

## prevent sudo password prompt during startup of virt-manager
#sudo usermod -a -G libvirt $(whoami)

## set default location of VMs under /home
#sudo mkdir /home/kvm-vms
#sudo rmdir /var/lib/libvirt/images/
#sudo ln -s /home/kvm-vms/ /var/lib/libvirt/images


#############################################################################
##
## Install development software
##
#############################################################################

echo dev software

## dependencies
sudo apt install g++


## java
#sudo apt install openjdk-11-jdk


#############################################################################
##
## Cleanup
##
#############################################################################

echo cleanup

## delete apt cache
sudo apt clean

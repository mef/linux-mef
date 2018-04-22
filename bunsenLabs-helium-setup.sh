#!/bin/bash
#############################################################################
##
## Let's start by making ourselves comfortable
##
#############################################################################

echo disable touchpad

## disable touchpad at startup + create enable script
TOUCHPADID=`xinput list | grep TouchPad | awk '{print $6}' | cut -c4,5`
echo '## disable touchpad' >> ~/.config/openbox/autostart
echo 'xinput disable' $TOUCHPADID >> ~/.config/openbox/autostart
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
sudo apt install inkscape gimp gcolor2

## audio software
sudo apt install audacity


## chromium
sudo apt-get install chromium


## For some reason, programmatic download retrieves windows .zip instead of the linux 64 bits version.
#cd /opt/c-user
#wget -O firefox.tar.bz2 https://download.mozilla.org/?product=firefox-latest-ssl&os=linux64&lang=en-US && tar -zxvf firefox.tar.bz2
#wget -O firefox-dev.tar.bz2 https://download.mozilla.org/?product=firefox-devedition-latest-ssl&os=linux64&lang=en-US & tar -zxvf firefox-dev.tar.bz2

## gephi
cd /opt/c-user/
wget -P https://github.com/gephi/gephi/releases/download/v0.9.2/gephi-0.9.2-linux.tar.gz
tar -zxvf gephi-0.9.2-linux.tar.gz
ln -s /opt/c-user/gephi-0.9.2/bin/gephi ~/bin/
cd


## ffmpeg

## unattended-upgrades
sudo apt-get install unattended-upgrades apt-listchanges

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

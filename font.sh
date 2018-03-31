#/bin/sh
#############################################################################
##
## Configure fonts
##
#############################################################################

## Set a nicer default monospace font
set i- 's/Inconsolata/Dejavu Sans Mono/g' .config/fontconfig/fonts.conf

## remove heavy unused font
sudo apt remove fonts-noto-cjk

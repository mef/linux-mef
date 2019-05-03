#!/bin/sh

# activate trackpoint scroll for external lenovo usb keyboard
# 
# @param {number?} keyboard id - defaults to 15. Find value with `xinput list`
#
#
# usage
#     external-keyboard-hack.sh 14
#

KEYBOARDID=${1:-15}

xinput set-int-prop $KEYBOARDID "Evdev Wheel Emulation Button" 8 2
xinput set-int-prop $KEYBOARDID "Evdev Wheel Emulation" 8 1
xinput set-int-prop $KEYBOARDID "Evdev Wheel Emulation Timeout" 8 200
xinput set-int-prop $KEYBOARDID "Evdev Wheel Emulation Axes" 8 6 7 4 5

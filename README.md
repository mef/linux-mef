# bunsen-mef

My Bunsenlabs linux config

This repository gathers a set of scripts / how-to guides which I use to customize my laptops configurations.

Work in progress.

## System setup

### Disk Partitioning

## Configuration

### Disable touchpad

In debian stretch

````
$ xinput list
⎡ Virtual core pointer                    	id=2	[master pointer  (3)]
⎜   ↳ Virtual core XTEST pointer              	id=4	[slave  pointer  (2)]
⎜   ↳ SynPS/2 Synaptics TouchPad              	id=11	[slave  pointer  (2)]
⎜   ↳ TPPS/2 IBM TrackPoint                   	id=12	[slave  pointer  (2)]
⎣ Virtual core keyboard                   	id=3	[master keyboard (2)]
    ↳ Virtual core XTEST keyboard             	id=5	[slave  keyboard (3)]
    ↳ Power Button                            	id=6	[slave  keyboard (3)]
    ↳ Video Bus                               	id=7	[slave  keyboard (3)]
    ↳ Sleep Button                            	id=8	[slave  keyboard (3)]
    ↳ Integrated Camera                       	id=9	[slave  keyboard (3)]
    ↳ AT Translated Set 2 keyboard            	id=10	[slave  keyboard (3)]
    ↳ ThinkPad Extra Buttons                  	id=13	[slave  keyboard (3)]
## find the touchpad's id in the output from xinput list, and use it in following command
$ xinput disable 11
````

+ add xinput enable 11 inside `~/bin/enable-touchpad.sh`

In debian Jessie, it used to be `synclient touchpadoff=1`

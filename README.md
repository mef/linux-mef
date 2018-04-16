# linux-mef

This repository gathers a set of notes, scripts, tips gathered from my linux usage.

I wrote it for myself, but have no reason to keep it private.

Use at your own risks.

Work in progress.


## Bunsenlabs linux config

### Pre-install


* check ssh accesses, be sure not to end up locked down from some server.
* Run backup scripts
* Partition disks

| mount point | partition | size |
| -- | -- | -- |
| / | /dev/sda1 | 20GB |
| /home | /dev/sda2 | 210GB |
| /var/log | /dev/sda3 | 256MB |
| swap | /dev/sda4 | 4GB |

## Install

* language: English
* location: Belgium
* locale: Ireland



/dev/sda3 should be set as noatime and have journaling disabled





### Post-install

Once bunsen is installed, and bl-welcome has been run.


* configure git

````bash
$ git config --global user.name "John Doe"
$ git config --global user.email johndoe@example.com
````

* clone this repository, and run the setup script

Notes:
  * set keyboard layout as UK extended: select English (UK, ~international with dead keys~ extended WinKeys)

````bash
$ mkdir -p ~/development/other
$ cd ~/development/other
$ git clone https://github.com/mef/linux-mef.git
$ cd linux-mef
$ ./bunsenLabs-helium-setup.sh
````


#### manual actions

* adjust battery charge thresholds in `/etc/default/tlp`
* select theme monokai-mef them in geany "View\Change color scheme" menu
* activate line wrap in geany "Document" menu
* generate ssh keys `ssh-keygen t rsa -b 4096 -C "johndoe@example.com"`
* create `.ssh/config`
* add public key to relevant servers and test all accesses


Download firefox stable from https://www.mozilla.org/en-US/firefox/
Download firefox developer edition from https://www.mozilla.org/en-US/firefox/channel/desktop/

Unpack both tarballs inside /opt/c-user/firefox and firefox-dev, respectively

    sudo apt remove firefox-esr firefox
    sudo ln -s /opt/c-user/firefox/firefox /usr/bin/firefox
    sudo ln -s /opt/c-user/firefox-dev/firefox /usr/bin/firefox-dev
    sudo update-alternatives --install /usr/bin/x-www-browser x-www-browser /opt/c-user/firefox/firefox 200
    sudo update-alternatives --install /usr/bin/x-www-browser x-www-browser /opt/c-user/firefox-dev/firefox 100


to work around kvm permission denied error, reload of kvm kernel modules was necessary:

````bash
sudo rmmod kvm_intel
sudo rmmod kvm
sudo modprobe kvm
sudo modprobe kvm_intel
````


Lookup windows key with:

    sudo cat /sys/firmware/acpi/tables/MSDM

#### wip

* auto-login at boot
* firefox+ firefox developer edition, addons + config, userContent and userchrome
* create ssh keys, and register them to relevant servers
* setup anti-theft system - like this > http://tristan.terpelle.be/prey-anti-theft-on-debian.html ?

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

````bash
$ mkdir -p ~/development/other
$ cd ~/development/other
$ git clone https://github.com/mef/linux-mef.git
$ cd linux-mef
$ ./bunsenLabs-helium-setup.sh
````

* set keyboard layout as UK extended: select English (UK, ~international with dead keys~ extended WinKeys)


* firefox+ firefox developer edition, addons + config, userContent and userchrome
* create ssh keys, and register them to relevant servers
* setup anti-theft system - like this > http://tristan.terpelle.be/prey-anti-theft-on-debian.html ?

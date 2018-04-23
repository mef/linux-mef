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


##### configure git

````bash
$ git config --global user.name "John Doe"
$ git config --global user.email johndoe@example.com
````

##### run automated installations

N.B: when prompted, set keyboard layout as UK extended: select English (UK, ~international with dead keys~ extended WinKeys)


````bash
$ mkdir -p ~/development/other
$ cd ~/development/other
$ git clone https://github.com/mef/linux-mef.git
$ cd linux-mef
$ ./bunsenLabs-helium-setup.sh
````

#### enable autologin

uncomment `autologin-user` inside `/etc/lightdm/lightdm.conf`, using actual username:

````
[Seat:*]
autologin-user=username
````

Then add the user to the group autologin:

````bash
# groupadd -r autologin
# gpasswd -a username autologin
````

[source](https://wiki.archlinux.org/index.php/LightDM#Enabling_autologin)

#### custom shortcuts

Add or modify the following inside `~/.config/openbox/rc.xml`:

* only one desktop

    <number>1</number>

* keyboard shortcuts

````bash
    <!-- Override Ctrl-Q with dummy action -->
    <keybind key="C-Q">
      <action name="Execute">
        <command>/bin/false</command>
      </action>
    </keybind>

    <!-- Maximize current window -->
    <keybind key="W-Next">
      <action name="ToggleMaximize"/>
    </keybind>
````

#### adjust battery charge thresholds in `/etc/default/tlp`

#### configure unattended-upgrades

* edit the active origin pattern inside `/etc/apt/apt.conf.d/50unattended-upgrades`, e.g. set the following one:

````
      "o=Debian,n=stretch";
````

[source](https://wiki.debian.org/UnattendedUpgrades).

#### Geany

* select theme monokai-mef them in geany "View\Change color scheme" menu
* activate line wrap in geany `Preferences/editor`

#### ssh

* generate key

````bash
ssh-keygen t rsa -b 4096 -C "johndoe@example.com"`
````
* create and complete `.ssh/config`
* add public key to relevant servers 
* test all accesses


#### firefox setup

Download firefox stable from https://www.mozilla.org/en-US/firefox/
Download firefox developer edition from https://www.mozilla.org/en-US/firefox/channel/desktop/

Unpack both tarballs inside /opt/c-user/firefox and firefox-dev, respectively

    sudo apt remove firefox-esr firefox
    sudo ln -s /opt/c-user/firefox/firefox /usr/bin/firefox
    sudo ln -s /opt/c-user/firefox-dev/firefox /usr/bin/firefox-dev
    sudo update-alternatives --install /usr/bin/x-www-browser x-www-browser /opt/c-user/firefox/firefox 200
    sudo update-alternatives --install /usr/bin/x-www-browser x-www-browser /opt/c-user/firefox-dev/firefox 100

#### anti-theft system

1. install prey `.deb` package from https://panel.preyproject.com
2. during config, solve bug by applying [this workaround](https://github.com/prey/prey-node-client/issues/355#issuecomment-368228502). - if still relevant
3. validate that it works by setting device to missing.

#### nvm and node.js

cf. https://github.com/creationix/nvm

Then `nvm install --lts`

#### gimp config

toggle `Windows\Single-window mode`

#### gephi config

edit `gephi-0.9.2/etc/gephi.conf` and set suitable values to `-Xms` and `-Xmx` parameters

e.g. 

    Xms512m -J-Xmx4096m



#### virtual machine setup (wip)

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

* firefox+ firefox developer edition, addons + config, userContent and userchrome
* audacious or quodLibet as replacement of decibel-audio-player?
* raleway and roboto fonts

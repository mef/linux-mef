# linux-mef

This repository gathers a set of notes, scripts, tips gathered from my linux usage.

I wrote it for myself, but have no reason to keep it private.

Use at your own risks.

## How to install BunsenLabs Lithium on a thinkpad laptop

The instructions below are relative to the installation of BusenLabs Lithium experimental (pre-release - based on Debian Buster 10) on a Thinkpad X1 Carbon Gen 7.

For a setup and configuration of BunsenLabs Helium (based on Debian Stretch), have a look at version tag `v0.2.0`.

### Pre-install

* check ssh accesses, be sure not to end up locked out of some server.
* Run backup scripts
* save a copy of custom hosts `/etc/hosts`
* save a copy of specific configs, e.g. `nginx` config files

### Installation

Target hardware: Thinkpad x1 carbon Gen7

#### Debian Netinstall

* Download latest debian buster NETINST ISO. If intel `iwlwifi` non-free firmware is needed, get the unofficial ISO which includes the non-free firmware ([here](https://cdimage.debian.org/cdimage/unofficial/non-free/cd-including-firmware/current/amd64/iso-cd/)).
* Disable EFI secure boot (otherwise acpi_call kernel module won't load / tlp battery management not possible)

* language: English
* location: Belgium
* locale: Ireland

#### Disk partitioning layout

| mount point | partition | size |
| -- | -- | -- |
| / | /dev/sda1 | 20 GB |
| /home | /dev/sda2 | 450 GB |
| /var/log | /dev/sda3 | 256 MB |
| swap | /dev/sda4 | 9 GB |

/dev/sda3 should be set as noatime and have journaling disabled (c.f. https://foxutech.com/how-to-disable-enable-journaling/)

#### In case network is down after first boot:


1. setup `/etc/network/interfaces` as described [here](https://www.raspberrypi.org/forums/viewtopic.php?t=7592).
2. run `sudo ifdown wlp0s20f3 && sudo ifup wlp0s20f3` (replace by proper interface name)

Useful commands (as root):

* `ip a`
* `iwconfig`
* `iwlist scan`
* `ip link set wlp0s20f3 up`

#### Bunsen Lithium

Follow [instructions](https://forums.bunsenlabs.org/viewtopic.php?id=5546).


### Post-install

Once bunsen is installed, and bl-welcome gets executed.

Decline when prompted to install cvs or java.

#### set trackpoint sensitivity

* Lookup current sensitivity value (libinput Accel Speed), using this command: `xinput --list-props $(xinput list | grep TrackPoint | awk '{print $6}' | cut -c4,5)`
* Experiment values to find suitable sensitiviy, e.g. `-.35` here:  `xinput --set-prop $(xinput list | grep TrackPoint | awk '{print $6}' | cut -c4,5) "libinput Accel Speed" -.35`
* Add command with desired sensitivity to `~/.config/bunsen/autostart`, e.g.

````bash
xinput --set-prop $(xinput list | grep TrackPoint | awk '{print $6}' | cut -c4,5) "libinput Accel Speed" -.35 &
````

#### decrease swappiness

Add the following line to `/etc/sysctl.conf`:

    vm.swappiness = 10

[source](https://askubuntu.com/a/103916).

#### setup and configure git

````bash
$ sudo apt install git
$ git config --global user.name "John Doe"
$ git config --global user.email johndoe@example.com
````

#### run automated installations

(!) Make sure that you know what you're doing. study the script before executing it, or run selected steps manually to be safe.

N.B: when prompted, set keyboard layout as UK extended: select English (UK, ~international with dead keys~ extended WinKeys)


````bash
$ mkdir -p ~/development/other
$ cd ~/development/other
$ git clone https://github.com/mef/linux-mef.git
$ cd linux-mef
$ ./bunsenLabs-beryllium-setup.sh
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

#### Add terminator theme

N.B.: No instance of terminator should be running when the following modifications are performed.


Add the following in the `profiles` section of `.config/terminator/config`:

```
  [[Monokai dark]]
    background_color = "#272822"
    background_darkness = 0.95
    background_type = transparent
    cursor_color = "#ffffff"
    foreground_color = "#f8f8f2"
    show_titlebar = False
    scrollback_infinite = True
    palette = "#75715e:#f92672:#a6e22e:#f4bf75:#66d9ef:#ae81ff:#2aa198:#f9f8f5:#272822:#f92672:#a6e22e:#f4bf75:#66d9ef:#ae81ff:#2aa198:#f9f8f5"
  [[Monokai mef]]
    background_color = "#272822"
    background_darkness = 0.95
    background_type = transparent
    cursor_color = "#ffffff"
    foreground_color = "#f8f8f2"
    show_titlebar = False
    scrollback_infinite = True
    palette = "#75715e:#f92672:#a6e22e:#f4bf75:#66d9ef:#ae81ff:#2aa198:#f9f8f5:#838383:#f92672:#a6e22e:#f4bf75:#66d9ef:#ae81ff:#2aa198:#f9f8f5"
```

Then lower in the same file, define the default profile to use.

```
[layouts]
  [[default]]
    [[[child1]]]
      parent = window0
      type = Terminal
      profile = Monokai mef
```

#### custom keyboard shortcuts

Add or modify the following inside `~/.config/openbox/rc.xml`:

* only one desktop

````
    <number>1</number>
````

* keyboard shortcuts

````bash
    
    <!-- Keybindings for brightness control -->
    <keybind key="W-F5">
      <action name="Execute">
        <command>brightness down</command>
      </action>
    </keybind>
    <keybind key="W-F6">
      <action name="Execute">
        <command>brightness up</command>
      </action>
    </keybind>
    
    <!-- Keybindings for volume control -->
    <keybind key="W-F2">
      <action name="Execute">
        <command>vol down -i 10%</command>
      </action>
    </keybind>
    <keybind key="W-F3">
      <action name="Execute">
        <command>vol up -i 10%</command>
      </action>
    </keybind>
    
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

#### Shortcuts in thunar

Manually define shortcuts in thunar

#### adapt permissions for brightness controls

By default, only root has permissions over brightness control. The following udev rules changes brightness group to `video`, and makes it writable by the group.

Create a new file `/etc/udev/rules.d/backlight.rules` filled-up with the following contents:

```
ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", RUN+="/bin/chgrp video /sys/class/backlight/%k/brightness"
ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", RUN+="/bin/chmod g+w /sys/class/backlight/%k/brightness"
```

[more info](https://superuser.com/questions/484678/cant-write-to-file-sys-class-backlight-acpi-video0-brightness-ubuntu).

#### Configure tlp


`/etc/tlp.conf`


```
DEVICES_TO_DISABLE_ON_STARTUP="bluetooth wwan"


START_CHARGE_THRESH_BAT0=65
STOP_CHARGE_THRESH_BAT0=80

```

#### configure unattended-upgrades

* edit the active origin patterns inside `/etc/apt/apt.conf.d/50unattended-upgrades`, e.g. set the following ones:

````
    "origin=Debian,codename=${distro_codename},label=Debian-Security";
    "origin=Debian,codename=${distro_codename}-security,label=Debian-Security";
````

[source](https://wiki.debian.org/UnattendedUpgrades).

#### configure awscli

cf. https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html

Default region: eu-west-1
Default output format: json

Retrieve data sync scripts from s3, put them in bin directory

#### Geany

* select theme monokai-mef them in geany "View\Change color scheme" menu
* activate line wrap in geany `Preferences/editor`
* add `Search field` and `Goto field` to toolbar
* swap keybindings of `Find` and `Switch to search bar`

#### ssh

* generate key

````bash
ssh-keygen -o -a 100 -t ed25519
````
* create and complete `.ssh/config`
* add public key to relevant servers 
* test all accesses

#### firefox setup

Download firefox stable from https://www.mozilla.org/en-US/firefox/
Download firefox developer edition from https://www.mozilla.org/en-US/firefox/channel/desktop/

Unpack both tarballs inside /opt/c-user/firefox and firefox-dev, respectively

```
sudo apt remove firefox-esr firefox
sudo ln -s /opt/c-user/firefox/firefox /usr/bin/firefox
sudo ln -s /opt/c-user/firefox-dev/firefox /usr/bin/firefox-dev
sudo update-alternatives --install /usr/bin/x-www-browser x-www-browser /opt/c-user/firefox/firefox 200
sudo update-alternatives --install /usr/bin/x-www-browser x-www-browser /opt/c-user/firefox-dev/firefox 100
```

#### web browsers config

1. restore firefox profiles from backup, and set them up inside `~/.mozilla/firefox/profiles.ini`.
2. install ublock origin in chromium
3. download client certificate(s) and import in firefox 

#### anti-theft system

1. install prey `.deb` package from https://preyproject.com/download/
2. configure prey, it may be necessary to launch the gui manually: `sudo /usr/lib/prey/current/bin/prey config gui`
  * during config, solve bug by applying [this workaround](https://github.com/prey/prey-node-client/issues/355#issuecomment-368228502). - if still relevant
3. enable prey service `sudo -u prey /usr/lib/prey/current/bin/prey config activate`
4. validate that it works by setting device to missing

#### nvm and node.js

cf. [install using git](https://github.com/nvm-sh/nvm#manual-install).

Then `nvm install --lts`

#### gephi config

edit `gephi-0.9.2/etc/gephi.conf` and set suitable values to `-Xms` and `-Xmx` parameters

e.g. 

    Xms512m -J-Xmx4096m

#### databases

```
## mariadb: with data and tmp directories inside /home partition
sudo apt install mariadb-server mariadb-client

sudo mysql_secure_installation

sudo systemctl stop mariadb
sleep 10
sudo systemctl status mariadb
sudo mv /var/lib/mysql /home/
sudo mkdir /home/mysqlTmp
sudo chown mysql:mysql /home/mysqlTmp

## update directories in config file
sudo sed -i 's#/var/lib/mysql#/home/mysql#g' /etc/mysql/mariadb.conf.d/50-server.cnf
sudo sed -i 's#/tmp#/home/mysqlTmp#g' /etc/mysql/mariadb.conf.d/50-server.cnf

## allow mysql to access home directory in  daemon
sudo sed -i 's/ProtectHome=true/ProtectHome=false/' /etc/systemd/system/mysql.service
### avoid config being overwritten after software updates
sudo cp /lib/systemd/system/mariadb.service /etc/systemd/system/
sudo sed -i 's/ProtectHome=true/ProtectHome=false/' /etc/systemd/system/mariadb.service

sudo systemctl daemon-reload

sudo systemctl start mariadb
sleep 10
sudo systemctl status mariadb
```

Connect via sudo to use as `root` user.

If  needed to have a user with permissions similar to root, usable from `localhost`, follow [these steps](https://www.digitalocean.com/community/tutorials/how-to-install-mariadb-on-debian-10).

If relevant, restore dumps from backup.

For mariadb, in case the source OS is not usable for the creation of backups, physical backups can be used ([instructions](https://www.linode.com/docs/databases/mysql/create-physical-backups-of-your-mariadb-or-mysql-databases/)).

#### development

1. clone git repositories
2. install dependencies (`npm install`)
3. retrieve params / config files from backup
4. retrieve custom hosts and store in /etc/hosts


#### http server

Once node.js is installed, run the following

````bash
npm install http-server -g
````

#### pip

For python 3:

    sudo apt install --no-install-recommends python3-pip
    
    
Then add the path to python packages to .profile file:

    export PATH=/home/c-user/.local/bin:$PATH

Then use command `pip3`.
    
For python 2:

    sudo apt install --no-install-recommends python-pip

#### virtual machine setup (wip)

create the VM using virt-manager.

Lookup windows key with:

    sudo cat /sys/firmware/acpi/tables/MSDM

If necessary, adapt VM name inside `~/bin/windows`.

#### wip

* audacious or quodLibet as replacement of decibel-audio-player?
* raleway and roboto fonts
* ublock origin custom filters / rules


### BIOS upgrade

Dependencies: `genisoimage` package.

    sudo apt install genisoimage
    
    
1. Download the BIOS update utility as bootable CD iso file from lenovo website
2. convert the downloaded iso file to img file - (c.f. example command below)
3. use `dd` to copy the img file into a USB disk
4. Boot the laptop from USB and follow displayed instructions

    geteltorito -o x250.img downladed-iso-file-name.iso


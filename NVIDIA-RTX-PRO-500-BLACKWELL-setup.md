# How to install the drivers for NVIDIARTX PRO 500 Blackwell on debian 13

```
## optional
sudo dpkg --add-architecture i386
```


```
wget https://developer.download.nvidia.com/compute/cuda/repos/debian13/x86_64/cuda-keyring_1.1-1_all.deb
sudo dpkg -i cuda-keyring_1.1-1_all.deb
sudo apt update
sudo apt install nvidia-open nvidia-driver
```

Remarks:

* `cuda-driver` package cannot be installed with `nvidia-open`, both have conflicting dependencies.
* `nouveau` open source drivers must be blacklisted in order not to conflict / interfere with nvidia's proprietary drivers

```
## Check whether nouveau is blacklisted
grep -r nouveau /etc/modprobe.d/
cat /etc/modprobe.d/blacklist-nouveau.conf
```

```
## blacklist nouveau manually if needed
echo -e "blacklist nouveau\noptions nouveau modeset=0" | sudo tee /etc/modprobe.d/blacklist-nouveau.conf
sudo update-initramfs -u
```

Then reboot.

## What does not work

* Installing nvidia-driver v550 from non-free repositories (trixie and trixie-backports)
* Installing the drivers downloaded from nvidia website, with their `.run` utility (neither with the proprietary nor with the open kernel module options) (or perhaps some troubleshooting required with the open modules version to make X launch).

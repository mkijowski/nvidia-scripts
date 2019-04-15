#!/bin/bash

## Rough pre-installation script for nvidia drivers in ubuntu 18.04
## This script installs pre-requisites, blacklists certain graphics drivers,
## and downloads the specified version of the nvidia driver to 
## /root/nvidia-driver-***.run  where *** is the version number downloaded.

## After pre installation script completes and reboots you still need to 
## manually install the nvidia driver as root!


## Store variables for driver version and download link.
NVDRIVERLINK="http://us.download.nvidia.com/XFree86/Linux-x86_64/418.56/NVIDIA-Linux-x86_64-418.56.run"
NVDRIVERVER="418.56"

# Check for root/sudo ( need root permissions )
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root, exiting."
   exit 1
fi

#install pre-requisites 
apt update && apt install -y \
	gcc \
	make \
	build-essential \
	gcc-multilib \
	dkms \
	wget

apt auto-clean
apt autoremove -y

# Blacklist old driver
echo "blacklist nouveau
blacklist vga16fb
blacklist rivafb
blacklist nvidiafb
blacklist rivatv
blacklist amd76_edac
options nouveau modeset=0" > /etc/modprobe/blacklist-nvidia-nouveau.conf

# Download Nvidia driver
if [ -d /root/nvidia-driver$NVDRIVERVER.run ]; then
	echo "This driver version already downloaded."
	chmod a+x /root/nvidia-driver$NVDRIVERVER.run
else
	wget $NVDRIVERLINK -O /root/nvidia-driver$NVDRIVERVER.run
	chmod a+x /root/nvidia-driver$NVDRIVERVER.run
fi

# Check to see if user wants to reboot
read -p "Changes require a reboot.  Reboot now? (Y/N): " confirm \
   && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
reboot


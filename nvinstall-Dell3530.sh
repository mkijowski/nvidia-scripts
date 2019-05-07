NVDRIVERLINK="http://us.download.nvidia.com/XFree86/Linux-x86_64/418.74/NVIDIA-Linux-x86_64-418.74.run"

NVDRIVERVER="418.74"

# insert sudo check
if [[ $EUID -ne 0 ]]; then
	echo "This script must be run as root, exiting."
	exit 1
fi

apt update && apt install -y \
	gcc \
	make \
	build-essential \
	gcc-multilib \
	dkms \
	wget

apt autoclean
apt autoremove -y

# Blacklist old driver(s)
echo "blacklist nouveau
blacklist vga16fb
blacklist rivafb
blacklist nvidiafb
blacklist rivatv
blacklist amd76_edac
options nouveau modeset=0" > /etc/modprobe.d/blacklist-nvidia-nouveau.conf

# Download driver
wget $NVDRIVERLINK -O /root/nvidia-driver$NVDRIVERVER.run
chmod a+x /root/nvidia-driver$NVDRIVERVER.run

# Restart, then install as root (sudo su)
# IGNORE PRE_INSTALL ERRORS
# DO NOT INSTALL KERNEL DRIVERS WITH DKMS

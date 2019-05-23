#### Some useful scripts

* [nvidia-pre-install.sh](../blob/master/nvidia-pre-install.sh) -
  pre-installation scripts for nvidia drivers on ubuntu 18.04 servers (and other
  systems that need nouveau blacklisted)
* [nvidia-post-install.sh](../blob/master/nvidia-post-install.sh) - post
  installation scripts to download cuda-samples, build `deviceQuery` and add it
  to crontab @reboot.  This appears to fix an issue where the nvidia driver does
  not start, preventing some jobs from running
* [nvinstall-Dell3530.sh](../blob/master/nvinstall-Dell3530.sh) - installation script
  to install pre-reqs and blacklist default graphics drivers in Ubuntu 18.04
 
### NOTE: these scripts are note tested, please use at your own risk!

#Install on Dell 3530 with Quadro P600
* Run nvinstall-Dell3530.sh with sudo.  This will download the NVIDIA driver
  to your root directory
* Reboot your machine - DO NOT LOG IN
* The log in screen should be displayed - press `Ctrl+Alt+F2` 
  * sometimes you need to use `F3`
  * log in with your user credentials
* Run the following as sudo - not all of these may have output
  * `rm -r /var/lib/dkms/nvidia`
  * `apt purge 'nvidia.*'`
  * `apt purge dkms`
* Run the following to install the driver (as `sudo`)
  * `apt install dkms`
  * `init 3` - screen should flash
  * Do the following ONLY IF you want a newer driver
  * `wget http://us.download.nvidia.com/XFree86/Linux-x86_64/418.74/NVIDIA-Linux-x86_64-418.74.run -O /root/nvidia-driver430-14.run`
* Log in as root - `sudo su`
  * `cd ~` - change to root's home directory
  * NOTE: change version of next line IF USING OLD DRIVER
  * `./NVIDIA-Linux-x86_64-430.14.run --no-cc-version-check`
  * `reboot`

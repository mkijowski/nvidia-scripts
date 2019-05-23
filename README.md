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

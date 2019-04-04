#!/bin/bash

## this script should be run AFTER nvidia-pre-install.sh
## AND after you have installed the nvidia drivers.

## this script downloads the cuda-samples git repo and makes
## deviceQuery.  It then adds a crontab entry as root so that
## deviceQuery runs each reboot.

## This appears to solve an issue on some machines where the nvidia 
## driver does not start on boot (leaving slurm jobs hanging).


# Check for root/sudo ( need root permissions )
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root, exiting."
   exit 1
fi


#install pre-requisites 
apt update && apt install -y \
   git


# Get the cuda samples
if [ -d /root/cuda-samples ]; then
   cd /root/cuda-samples
   git pull
else
   git clone https://github.com/NVIDIA/cuda-samples.git /root/cuda-samples
fi

# Attempt to build deviceQueuery
cd /root/cuda-samples/Samples/deviceQuery/
make

# If deviceQueuery succesfuly makes then add it to crontab
if [-f /root/cuda-samples/Samples/deviceQuery/deviceQuery ]; then
# Test if deviceQueuery is already in crontab
#    crontab -l | grep -q deviceQ ||
# If crontab containes deviceQ then nothing else happens
# If crontab does NOT contain deviceQ then add it to crontab
   crontab -l | grep -q deviceQ || \
      (crontab -l && \
      echo "@reboot /root/cuda-samples/Samples/deviceQuery/deviceQueuery" \
      ) | crontab
fi

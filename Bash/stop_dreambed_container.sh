#!/bin/bash
# This script stops the dreambed docker container
# 
# Developed by Yoshua Nava (yoshua.nava.chocron@gmail.com), for Joshua Haustein (RPL - KTH).
# 
# 

source $DREAMBED_DOCKER_SCRIPTS_DIR/Bash/common_vars.sh

if [ "$USE_NVIDIA_DOCKER" = true ] ; then
    sudo nvidia-docker stop $CONTAINER_NAME
else
    sudo docker stop $CONTAINER_NAME
fi
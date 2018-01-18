#!/bin/bash
# This script allows a user to start the dreambed docker container
# 
# Developed by Yoshua Nava (yoshua.nava.chocron@gmail.com), for Joshua Haustein (RPL - KTH).
# 
# 

source $DREAMBED_DOCKER_SCRIPTS_DIR/Bash/common_vars.sh

xhost +

if [ "$USE_NVIDIA_DOCKER" = true ] ; then
    sudo nvidia-docker start $CONTAINER_NAME
else
    sudo docker start $CONTAINER_NAME
fi
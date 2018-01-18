#!/bin/bash
# This script allows a user to exec the dreambed docker container as root
# 
# Developed by Yoshua Nava (yoshua.nava.chocron@gmail.com), for Joshua Haustein (RPL - KTH).
# 
# 

source $DREAMBED_DOCKER_SCRIPTS_DIR/Bash/common_vars.sh

xhost +

if [ "$USE_NVIDIA_DOCKER" = true ] ; then
	sudo nvidia-docker exec $DOCKER_ROOTEXEC_ARGS
else
	sudo docker exec $DOCKER_ROOTEXEC_ARGS
fi

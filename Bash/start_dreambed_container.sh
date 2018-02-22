#!/bin/bash
# This script allows a user to start the dreambed docker container
# 
# Developed by Yoshua Nava (yoshua.nava.chocron@gmail.com), for Joshua Haustein (RPL - KTH).
# 
# 

source $DREAMBED_DOCKER_SCRIPTS_DIR/Bash/common_vars.sh

xhost +


sudo docker start $CONTAINER_NAME
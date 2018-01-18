#!/bin/bash
# This script stops the dreambed docker container
# 
# Developed by Yoshua Nava (yoshua.nava.chocron@gmail.com), for Joshua Haustein (RPL - KTH).
# 
# 

source $DREAMBED_DOCKER_SCRIPTS_DIR/Bash/common_vars.sh

sudo docker build $DREAMBED_DOCKER_SCRIPTS_DIR/ -t $IMAGE_NAME
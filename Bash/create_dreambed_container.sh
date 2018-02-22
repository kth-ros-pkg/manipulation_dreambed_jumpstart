#!/bin/bash
# This script creates a docker container from the dreambed docker image
# 
# Developed by Yoshua Nava (yoshua.nava.chocron@gmail.com), for Joshua Haustein (RPL - KTH).
# 
#

source $DREAMBED_DOCKER_SCRIPTS_DIR/Bash/common_vars.sh

xhost +

if [ ! -d "$LOCAL_FOLDER" ]; then
	printf ${YELLOW}"Directory "$LOCAL_FOLDER" does not exist. It will be created"${NO_COLOR}"\n"
    mkdir -p $LOCAL_FOLDER
    if [ -d "$LOCAL_FOLDER" ]; then
		printf ${GREEN}"Directory "$LOCAL_FOLDER" created"${NO_COLOR}"\n"
	fi
fi

if [ "$USE_NVIDIA_DOCKER" = true ] ; then
	sudo docker run --runtime=nvidia $DOCKER_CREATE_ARGS
else
	sudo docker run $DOCKER_CREATE_ARGS
fi
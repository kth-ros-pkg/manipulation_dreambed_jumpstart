#!/bin/bash
# Common variables used to set a docker container with the manipulation dreambed toolchain, ROS Indigo and Ubuntu 14.04
# 
# Developed by Yoshua Nava (yoshua.nava.chocron@gmail.com), for Joshua Haustein (RPL - KTH).
# 
# 

export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[0;33m'
export NO_COLOR='\033[0m'

export IMAGE_NAME=dreambed_img
export CONTAINER_NAME=robdream_container
export USE_NVIDIA_DOCKER=false
export CONTAINER_USER=robdream
export CONTAINER_FOLDER=/home/$CONTAINER_USER/shared_folder
export LOCAL_FOLDER=/home/$USER/robdream_docker/

export DOCKER_CREATE_ARGS="-it --privileged \
						-v $LOCAL_FOLDER:$CONTAINER_FOLDER:rw \
						-v /tmp/.X11-unix:/tmp/.X11-unix:ro \
						-e DISPLAY=:0 \
						-p 14556:14556/udp \
						--name=$CONTAINER_NAME $IMAGE_NAME:latest bash"

export DOCKER_ROOTEXEC_ARGS="-it --privileged=true \
							  -u root \
                              -e DISPLAY=:0 \
                              $CONTAINER_NAME bash"

export DOCKER_USEREXEC_ARGS="-it --privileged=true \
                              -u $CONTAINER_USER \
                              -e DISPLAY=:0 \
                              $CONTAINER_NAME bash"

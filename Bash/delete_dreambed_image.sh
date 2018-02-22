#!/bin/bash
# This script deletes the dreambed docker container and image
# 
# Developed by Yoshua Nava (yoshua.nava.chocron@gmail.com), for Joshua Haustein (RPL - KTH).
# 
# 

source $DREAMBED_DOCKER_SCRIPTS_DIR/Bash/common_vars.sh

export image_id=$(sudo docker images | grep $IMAGE_NAME | awk '{print $3}')
export container_id=$(sudo docker ps -a | grep $IMAGE_NAME | awk '{print $1}')
sudo docker stop $container_id
sudo docker rm $container_id
sudo docker rmi $image_id
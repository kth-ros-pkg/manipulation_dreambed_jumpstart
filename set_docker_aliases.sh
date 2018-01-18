#!/bin/bash
# This script sets up aliases for running the dreambed Docker helper scripts
# 
# Developed by Yoshua Nava (yoshua.nava.chocron@gmail.com), for Joshua Haustein (RPL - KTH).
# 
# 



export DOCKER_ALIASES="\n########################### Aliases for calling the Dreambed Docker helper scripts ###########################
\nalias build_dreambed_image=$(pwd)/Bash/build_dreambed_image.sh 
\nalias create_dreambed_container=$(pwd)/Bash/create_dreambed_container.sh 
\nalias delete_dreambed_image=$(pwd)/Bash/delete_dreambed_image.sh 
\nalias delete_dreambed_container=$(pwd)/Bash/delete_dreambed_container.sh
\nalias exec_dreambed_container=$(pwd)/Bash/exec_dreambed_container.sh 
\nalias rootexec_dreambed_container=$(pwd)/Bash/rootexec_dreambed_container.sh 
\nalias start_dreambed_container=$(pwd)/Bash/start_dreambed_container.sh 
\nalias stop_dreambed_container=$(pwd)/Bash/stop_dreambed_container.sh 
\n############################################################################################################"

echo -e $DOCKER_ALIASES >> /home/$USER/.bashrc
echo "export DREAMBED_DOCKER_SCRIPTS_DIR=$(pwd)" >> /home/$USER/.bashrc

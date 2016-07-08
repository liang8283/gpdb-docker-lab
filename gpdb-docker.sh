#!/bin/bash

## INSTRUCTION:
##
## 1. Download Docker Toolbox (https://www.docker.com/products/docker-toolbox) and install. Just click "Next" to complete the installation.
##
## 2. Download and run the gpdb-docker.sh (https://drive.google.com/open?id=0B0xXFikI5TCIcDRnOG02ZXlrZ0k) script on local Mac. It will take several minutes to pull the image from 10.152.9.39 and run it.
##
##    Images available at the moment: 
##     1) gpdb_4382 
##     2) gpdb_ccb
##
##    ./gpdb-docker.sh <port> <image>
##
##    For example: ./gpdb-docker.sh 4382 gpdb_4382
##
## 3. Access the gpdb env on local Mac.
##
##    ssh gpadmin@`docker-machine ip` -p <port specified in step 2>

if [ $# -ne 2 ]; then
    echo "Usage: ./gpdb_docker.sh <port> <image>"
    exit 1
fi

## Create virtualbox if it does not exist on Mac.
docker_machine=`docker-machine ls | wc -l`
if [ $docker_machine -eq 1 ]; then
    docker-machine create --driver virtualbox default
fi

## Start the virualbox if it is stopped.
docker_machine_state=`docker-machine ls | awk '{print $4}' | sed 1d`

if [ $docker_machine_state = "Stopped" ]; then
    docker-machine start default
fi

## Set the env variables to run Docker commands.
eval "$(docker-machine env default)"

## Need to update virtual box config file "/var/lib/boot2docker/profile" if it isthe first time to pull the image from registry.
container_num=`docker ps -a | awk '{print $1}' | sed 1d | wc -l`

if [ $container_num -eq 0 ]; then
    docker-machine ssh default "sudo sed -i 's/^.*label.*/--label provider=virtualbox --insecure-registry 10.152.9.39:5000/g' /var/lib/boot2docker/profile"
    docker-machine restart default
fi

## If the image does not exist on local Mac, pull it from registry and run it. Otherwise, just restart the existing container.
image_id=`docker images | grep $2 | awk '{print $3}'`

if [ -z "$image_id" ]; then
    docker run -i -d -p 5432:5432 -p $1:22 -p 28080:28080 -h mdw 10.152.9.39:5000/$2
else
    container_id=`docker ps -a | grep $image_id | awk '{print $1}'`
    docker restart $container_id
fi

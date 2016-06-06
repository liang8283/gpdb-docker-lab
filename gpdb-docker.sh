#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Usage: ./gpdb_docker.sh <port> <image>"
    exit 1
fi

docker_machine=`docker-machine ls | wc -l`
if [ $docker_machine -eq 1 ]; then
    docker-machine create --driver virtualbox default
fi

docker_machine_state=`docker-machine ls | awk '{print $4}' | sed 1d`

if [ $docker_machine_state = "Stopped" ]; then
    docker-machine start
fi

eval "$(docker-machine env default)"

container_num=`docker ps -a | awk '{print $1}' | sed 1d | wc -l`
image_id=`docker images | grep $2 | awk '{print $3}'`
container_id=`docker ps -a | grep $image_id | awk '{print $1}'`


if [ $container_num -eq 0 ]; then
    docker-machine ssh default "sudo sed -i 's/^.*label.*/--label provider=virtualbox --insecure-registry 10.152.9.39:5000/g' /var/lib/boot2docker/profile"
    docker-machine restart
    docker run -i -d -p 5432:5432 -p $1:22 -p 28080:28080 -h mdw 10.152.9.39:5000/$2
else
    docker restart $container_id
fi


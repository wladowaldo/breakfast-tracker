#!/bin/bash
DOCKER_BUILDKIT=1 docker build -t breakfast-tracker --build-arg "host_uid=$(id -u)" --build-arg "host_gid=$(id -g)" . || exit
docker run -it --rm --network host -v $PWD:/breakfast --name breakfast-tracker breakfast-tracker

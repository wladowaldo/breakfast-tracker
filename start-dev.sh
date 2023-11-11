#!/bin/bash
DOCKER_BUILDKIT=1 docker build -t breakfast-tracker-dev --build-arg "host_uid=$(id -u)" --build-arg "host_gid=$(id -g)" --build-arg "nginx_conf=image/nginx-dev.conf" -f image/Dockerfile-dev  . || exit
docker run -it --rm --network host -v $PWD:/breakfast/ --name breakfast-tracker-dev breakfast-tracker-dev

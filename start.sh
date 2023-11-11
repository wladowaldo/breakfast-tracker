#!/bin/bash
DOCKER_BUILDKIT=1 docker build -t breakfast-tracker --build-arg "host_uid=$(id -u)" --build-arg "host_gid=$(id -g)" --build-arg "nginx_conf=image/nginx.conf" -f image/Dockerfile  . || exit
docker run -it --rm --network host -v $PWD/work/:/breakfast/work --name breakfast-tracker breakfast-tracker

#!/usr/bin/bash
docker build -t musoto96/prep21:1.0 ./ 
echo "y" | docker image prune
IMG=$(docker image ls | grep prep21 | awk '{print $3}')
docker run -p 8573:8080 --rm $IMG

#! /bin/bash

CONTAINER=gaigepr/sbcl-1.4.1
docker rm -f $(docker ps -a -q); docker build -t $CONTAINER . && docker run -it $CONTAINER

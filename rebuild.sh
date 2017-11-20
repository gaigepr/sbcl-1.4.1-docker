#! /bin/bash

CONTAINER=gaigepr/sbcl-1.4.1
docker build -t $CONTAINER . && docker run -it $CONTAINER

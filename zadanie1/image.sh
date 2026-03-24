#!/bin/bash

IMAGE_NAME="zadanie1-pascal"

docker build -t $IMAGE_NAME .

docker run -it $IMAGE_NAME
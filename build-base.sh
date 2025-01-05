#!/bin/bash

BASE_IMAGE_TAG="u2410_jre23_jmeter563:0.0.1"

# Add force rebuild option
if [ "$1" == "--force" ]; then
    echo "Force rebuilding base image..."
    docker build -t $BASE_IMAGE_TAG -f Dockerfile-base .
    exit 0
fi

# Check if image exists
if ! docker image inspect $BASE_IMAGE_TAG >/dev/null 2>&1; then
    echo "Base image not found. Building..."
    docker build -t $BASE_IMAGE_TAG -f Dockerfile-base .
else
    echo "Base image already exists"
fi

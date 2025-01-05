#!/bin/bash

# Exit on error
set -e

# First ensure base image exists
. ./build-base.sh

# Build the Docker image
echo "Building JMeter image..."
docker build --no-cache -t jmeter-test .

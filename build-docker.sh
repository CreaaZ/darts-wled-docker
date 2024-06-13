#!/bin/bash

# Name of the builder
BUILDER_NAME=custom-builder
IMAGE_NAME=darts-wled
PLATFORMS=linux/amd64,linux/arm64

# Parse named arguments
while getopts v:u: flag
do
    case "${flag}" in
        v) DWLED_VERSION=${OPTARG};;
        u) DOCKER_USER=${OPTARG};;
    esac
done

# Check if version is set
if [ -z "$DWLED_VERSION" ]; then
    echo "Error: Version is required"
    exit 1
fi

# Check if version is set
if [ -z "$DOCKER_USER" ]; then
    echo "Error: Docker Hub user is required"
    exit 1
fi

#Prefix image name with user
IMAGE_NAME=$DOCKER_USER/$IMAGE_NAME

# Check if a builder with the given name exists
docker buildx inspect $BUILDER_NAME > /dev/null 2>&1
if [ $? -ne 0 ]; then
    # If the builder does not exist, create it
    docker buildx create --name $BUILDER_NAME
fi

# Use the builder
docker buildx use $BUILDER_NAME
    
# Build and push the image
docker buildx build --platform $PLATFORMS --build-arg="REF=${DWLED_VERSION}" -t $IMAGE_NAME:latest -t $IMAGE_NAME:$DWLED_VERSION --push .

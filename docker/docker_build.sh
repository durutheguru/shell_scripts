#!/bin/bash


## This bash script is designed to build a Docker image, tag it, log in 
 ## to the Docker registry, and push the image to the registry. Here's a 
 ## breakdown of what it does:
 ## 
 ## 1. Asks the user to enter the registry (default is 
 ## http://hub.docker.com), Docker platform (default is empty), and the 
 ## image tag.
 ## 2. Checks if the platform is empty. If it is, it builds the Docker 
 ## image using the specified tag.
 ## 3. If a platform is provided, it builds the Docker image with the 
 ## specified tag and platform.
 ## 4. If the registry is not provided, it sets the default registry to 
 ## http://hub.docker.com.
 ## 5. Tags the built Docker image with the specified image tag and the 
 ## registry URL.
 ## 6. Logs in to the Docker registry.
 ## 7. Pushes the tagged Docker image to the specified registry URL.
 ## 
 ## Overall, this script simplifies the process of building, tagging, 
 ## logging in, and pushing a Docker image to a registry. It allows 
 ## customization by accepting user input for the registry and platform 
 ## options.

read -p "Enter Registry (Empty for default): " registry
read -p "Enter docker platform (Empty for default): " platform
read -p "Enter Image Tag: " imageTag

if [[ -z "$platform" ]]; then
  docker build -t $imageTag .
else
  docker build --platform $platform -t $imageTag .
fi


if [[ -z "$registry" ]]; then
  registry="http://hub.docker.com"
fi
  
  
docker tag $imageTag $registry/$imageTag
docker login $registry
docker push $registry/$imageTag

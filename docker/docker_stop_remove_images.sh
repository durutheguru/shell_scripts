#!/bin/bash



# Check if an input text was provided
if [ -z "$1" ]; then
  echo "Usage: $0 <image-name-prefix>"
  exit 1
fi


IMAGE_PREFIX=$1


# Find all images starting with the input prefix
IMAGE_IDS=$(docker images --format '{{.ID}} {{.Repository}}:{{.Tag}}' | grep "$IMAGE_PREFIX.*" | awk '{print $1}')


# Stop and remove containers for the found images
for IMAGE_ID in $IMAGE_IDS; do
  CONTAINER_IDS=$(docker ps -a --filter "ancestor=$IMAGE_ID" --format '{{.ID}}')
  if [ -n "$CONTAINER_IDS" ]; then
    echo "Stopping containers for image ID $IMAGE_ID..."
    docker stop $CONTAINER_IDS
    echo "Removing containers for image ID $IMAGE_ID..."
    docker rm $CONTAINER_IDS
  fi
done


# Remove the images
if [ -n "$IMAGE_IDS" ]; then
  echo "Removing images starting with '$IMAGE_PREFIX'..."
  docker rmi -f $IMAGE_IDS
else
  echo "No images found with the prefix '$IMAGE_PREFIX'."
fi

echo "Done."


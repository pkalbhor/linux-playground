#!/bin/bash


# Manages the "ubuntu-playground" container using the "ubuntu-bash" image (assumes the image is already built).
# Starts, restarts, or creates the container if necessary, then opens an interactive Bash shell.
# Stops the container after exiting the shell to clean up resources.

# For more details: https://github.com/pkalbhor/linux-playground

# Define the image and container name
IMAGE_NAME="ubuntu-bash"
CONTAINER_NAME="ubuntu-playground"

# Check if the container exists
docker ps -a --format '{{.Names}}' | grep -w "$CONTAINER_NAME" > /dev/null

if [ $? -eq 0 ]; then
    # Container exists, now check if it's stopped
    CONTAINER_STATUS=$(docker inspect -f '{{.State.Status}}' "$CONTAINER_NAME")

    if [ "$CONTAINER_STATUS" == "exited" ]; then
        echo "Container exists but is stopped. Starting the container..."
    else
        echo "Container is already running. Restarting..."
	docker stop $CONTAINER_NAME > /dev/null
    fi
    docker start "$CONTAINER_NAME" > /dev/null
else
    # Container doesn't exist, create and start it
    echo "Container doesn't exist. Creating and starting a new container..."
    docker run -d --name "$CONTAINER_NAME" -it "$IMAGE_NAME" || { echo "Failed to create container"; exit 1; } > /dev/null
fi

# Exec into the running container
docker exec -it "$CONTAINER_NAME" /bin/bash

# Stop the container
echo "Stopping $CONTAINER_NAME container..."
docker stop "$CONTAINER_NAME" > /dev/null

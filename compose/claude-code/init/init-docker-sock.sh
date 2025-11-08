#!/bin/bash
set -eu

SOCK_PATH="/var/run/docker.sock"
DOCKER_GROUP="docker"

# Check if the socket is mounted 
if [ ! -e "$SOCK_PATH" ]; then
    echo "Docker socket not found at $SOCK_PATH"
    exit 1
fi

# Get the group name of the socket
sock_group=$(stat -c '%G' "$SOCK_PATH")

# Change group of socket if not yet applied
if [ "$sock_group" != "$DOCKER_GROUP" ]; then
    chgrp docker /var/run/docker.sock
fi
#!/bin/bash

# Development use only. Not for production.
# Copyright (C) 2022-2024 KTH.
# ----------------------
# DO NOT USE IT IN PROD!
# ----------------------

# Exit on any error except the specific ones we handle
set -euo pipefail

# Ensure Docker is installed
if ! command -v docker &>/dev/null; then
    echo "Docker could not be found. Please install Docker."
    exit 1
fi

# Variables
CONTAINER_NAME='web-ui'
URL='https://127.0.0.1/'
# Set default retry count
MAX_RETRIES=${MAX_RETRIES:-2}

# Pull the latest Docker image
# ./scripts/acr_pull_latest_tag.sh || echo "Image pull failed, but continuing..."

# Build the Docker image
echo "Building Docker images..."
# docker compose build --no-cache || echo "Build encountered an issue, but continuing..."
docker compose build || echo "Build encountered an issue, but continuing..."

# Function to run docker compose up with retry logic
run_docker_compose() {
    local retries=0

    echo "Running docker compose -f docker-compose.full.yml up -d ..."
    until docker compose -f docker-compose.full.yml up -d; do
        retries=$((retries + 1))
        if [ "$retries" -ge "$MAX_RETRIES" ]; then
            echo "docker compose up failed after $retries attempts. Exiting..."
            exit 1
        fi
        echo "docker compose up failed, retrying ($retries/$MAX_RETRIES)..."
    done
    echo "docker compose up succeeded."
}

# Start the Docker services with retry logic
run_docker_compose

# Start the application
./scripts/ignite_app.sh || echo "App start encountered an error, but continuing..."

# Get the container ID
CONTAINER_ID=$(docker ps --filter "name=${CONTAINER_NAME}" --format "{{.ID}}")

# Restart the specific container
if [ -n "${CONTAINER_ID}" ]; then
    echo "Restarting ${CONTAINER_NAME} ..."
    docker restart "${CONTAINER_ID}" || echo "Failed to restart ${CONTAINER_NAME}, but continuing..."
else
    echo "Container ${CONTAINER_NAME} not found, skipping restart."
fi

# Final message
echo "Service Setup Done, go to:"
echo "${URL}"

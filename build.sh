#!/bin/bash
set -e

# Ensure Docker credentials are set as environment variables
# if [[ -z "$DOCKER_USER_NAME" || -z "$DOCKER_ACCESS_TOKEN" ]]; then
#   echo "Error: DOCKER_USER_NAME and DOCKER_ACCESS_TOKEN must be set as environment variables."
#   exit 1
# fi

# Get the release tag from the first argument (e.g., 'v1.2.3')
# if [[ -z "$1" ]]; then
#   echo "Usage: $0 <release-tag>"
#   exit 1
# fi

INPUT_TAG="${1:-v0.3.9}"
TAG="${INPUT_TAG#v}"  # Strip 'v' prefix if present

# Login to Docker Hub
# echo "$DOCKER_ACCESS_TOKEN" | docker login -u "$DOCKER_USER_NAME" --password-stdin

# Build and push Docker images using Buildx
docker buildx build \
  --platform linux/amd64 \
  --build-arg "RELEASE_VERSION=$TAG" \
  --file ./docker/Dockerfile-Ubuntu22 \
  --tag subaligner:latest \
  ./docker

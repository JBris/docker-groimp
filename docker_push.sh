#!/usr/bin/env bash

. .env

###################################################################
# Main
###################################################################

echo $CR_PAT | sudo docker login ghcr.io -u USERNAME --password-stdin

# To find DOCKER_IMAGE_HASH: docker image ls
IFS='\n' read -r -a array <<< "$(sudo docker images --filter=reference='debian:stable*' --format '{{.ID}}')"
echo "${array[0]}"
docker tag "${array[0]}" "ghcr.io/${CONTAINER_REG_USER}/${CONTAINER_REG_NAME}:latest"
docker push "ghcr.io/${CONTAINER_REG_USER}/${CONTAINER_REG_NAME}:latest"

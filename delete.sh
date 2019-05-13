#!/bin/bash

# Stop all containers
docker stop $(docker ps -a -q)

# Delete all containers
docker rm $(docker ps -a -q)

# Delete volumes
docker volume prune -f
#docker volume rm $(docker volume list)


# Delete all images
docker rmi $(docker images -q)
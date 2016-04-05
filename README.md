# Jenkins PHP

Inspired by the Project http://jenkins-php.org . With this package you can really easy create a Jenkins instance.

## Quickstart

Just run
```bash
./quickstart.sh
```

## Installation Docker

Dependency:<br>

Docker Client:
```
curl -sSL https://get.docker.com/ | sh
sudo service docker start
```
Docker Compose: 
```
curl -L https://github.com/docker/compose/releases/download/1.4.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
```

## Installation Application
```
git clone https://github.com/approached/jenkins-php.git
```

## Usage

Start Container:
```
docker-compose up
```

Starting in Background (-d):
```
docker-compose up -d
```

Rebuild Package
```
docker-compose stop
docker-compose build
docker-compose up -d
```

## Helper

All container and images delete
```
#!/bin/bash
# Stop all containers
docker stop $(docker ps -a -q)
# Delete all containers
docker rm $(docker ps -a -q)
# Delete all images
docker rmi $(docker images -q)
```

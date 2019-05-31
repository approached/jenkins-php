# Jenkins PHP

Inspired by the Project http://jenkins-php.org . With this package you can really easy create a Jenkins instance.
*Dependency: docker and docker-compose*

## Quickstart

Start Container
```bash
docker-compose up

or starting in a background:

docker-compose up -d
```

## Misc

Install Docker: https://docs.docker.com/install/linux/docker-ce/ubuntu/

Install Docker Compose: https://docs.docker.com/compose/install/

Backup data: `./backup.sh`

Delete docker stuff: `./delete.sh`

Attach container as root: `docker exec -it --user root "jenkins-php" /bin/bash`

Attach container as jenkins: `docker exec -it --user jenkins "jenkins-php" /bin/bash`

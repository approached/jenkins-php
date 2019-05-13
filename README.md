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

Backup data: `./backup.sh`

Delete docker stuff: `./delete.sh`

Attach container: `docker exec -it "jenkins-php" /bin/bash`
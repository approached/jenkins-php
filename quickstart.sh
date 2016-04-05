# build
docker build -t jenkins_php .
docker run --name jenkins_php -d -p 8080:8080 jenkins_php
sleep 10
docker stop jenkins_php

# copy settings
docker cp jenkins_php:/var/lib/jenkins/ data

# run in background
docker-compose up -d

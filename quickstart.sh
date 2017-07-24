# build
docker-compose  -f docker-initial.yml up -d
sleep 30
docker-compose stop

# copy settings
docker cp jenkinsphp_jenkins_1:/var/lib/jenkins/ data
chmod -R 777 data/

# run in background
docker-compose up -d

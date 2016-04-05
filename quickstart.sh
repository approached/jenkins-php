# build
docker-compose  -f docker-initial.yml up -d
sleep 15
docker-compose stop

# copy settings
docker cp jenkinsphp_jenkins_1:/var/lib/jenkins/ data
chmod 755 data/ -R

# run in background
docker-compose up -d

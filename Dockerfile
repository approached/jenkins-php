FROM ubuntu:14.04

MAINTAINER Alexej Kloos "alexejkloos@gmail.com"

# dependencies
RUN apt-get -qqy install wget software-properties-common language-pack-en-base

# sources
RUN wget -q -O - https://jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
RUN sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
RUN apt-add-repository ppa:ansible/ansible
RUN LC_ALL=en_US.UTF-8 add-apt-repository ppa:ondrej/php

# software
RUN apt-get -qqy update
RUN apt-get -qqy install \
    php7.0-cli \ 
    php7.0-intl \
    php7.0-mcrypt \
    php7.0-mysql \ 
    php7.0-gd \
    php7.0-curl \
    php7.0-sqlite3 \ 
    php7.0-xsl \
    php7.0-common \
    php7.0-mbstring \
    jenkins \
    ansible \
    sqlite3

# jenkins plugins
ADD https://updates.jenkins-ci.org/download/plugins/git-client/latest/git-client.hpi /usr/share/jenkins/ref/plugins/git-client.hpi
ADD https://updates.jenkins-ci.org/download/plugins/git/latest/git.hpi /usr/share/jenkins/ref/plugins/git.hpi
ADD https://updates.jenkins-ci.org/download/plugins/github-api/latest/github-api.hpi /usr/share/jenkins/ref/plugins/github-api.hpi
ADD https://updates.jenkins-ci.org/download/plugins/github/latest/github.hpi /usr/share/jenkins/ref/plugins/github.hpi
ADD https://updates.jenkins-ci.org/download/plugins/ansicolor/latest/ansicolor.hpi /usr/share/jenkins/ref/plugins/ansicolor.hpi

# start jenkins
RUN echo "service jenkins start" >> /run_all.sh; \echo "service jenkins start" >> /run_all.sh; \
  echo "tail -f /var/log/jenkins/jenkins.log;" >> /run_all.sh

# listen
EXPOSE 8080
CMD ["sh", "/run_all.sh"]

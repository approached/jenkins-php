FROM jenkins/jenkins:lts

MAINTAINER Alexej Kloos "alexejkloos@gmail.com"

# update
USER root
RUN apt-get update
RUN apt-get upgrade

# ansible  https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#latest-releases-via-apt-debian
RUN sh -c 'echo deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main > /etc/apt/sources.list.d/ansible.list'
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
RUN apt-get update
RUN apt-get install  -qqy ansible

# php
RUN apt-get install -qqy ca-certificates apt-transport-https
RUN wget -q https://packages.sury.org/php/apt.gpg -O- |  apt-key add -
RUN echo "deb https://packages.sury.org/php/ stretch main" | tee /etc/apt/sources.list.d/php.list
RUN apt-get update
RUN apt-get -qqy install \
    php7.2-cli \
    php7.2-bcmath \
    php7.2-intl \
    php-sodium \
    php7.2-imagick \
    php7.2-mysql \
    php7.2-gd \
    php7.2-curl \
    php7.2-sqlite3 \
    php7.2-xsl \
    php7.2-common \
    php7.2-bz2 \
    php7.2-mbstring \
    php7.2-zip

# nodejs
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get install -y nodejs

# yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN sh -c 'echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list'
RUN apt-get install -y yarn

# legacy
RUN npm install -g gulp

# meta packages
RUN apt-get -qqy install \
    sqlite3 \
    git \
    ant \
    rsync \
    unzip \
    pngquant \
    jpegoptim \
    ffmpeg \
    locales \
    locales-all

# composer
RUN wget -q -O /usr/bin/composer https://getcomposer.org/composer.phar && chmod +x /usr/bin/composer

# drop back to the regular jenkins user - good practice
USER jenkins

# install jenkins-php recommended plugins https://plugins.jenkins.io/ - https://updates.jenkins.io/2.164/latest/
RUN install-plugins.sh credentials-binding github-branch-source blueocean thinBackup slack workflow-aggregator \
    checkstyle cloverphp crap4j dry htmlpublisher jdepend plot pmd violations warnings xunit

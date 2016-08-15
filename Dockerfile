FROM ubuntu:16.04

MAINTAINER Alexej Kloos "alexejkloos@gmail.com"

# update
RUN apt-get update

# Timezone
RUN echo "Europe/Berlin" > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata

# dependencies
RUN apt-get -qqy install wget software-properties-common language-pack-en-base

# sources
RUN wget -q -O - https://jenkins-ci.org/debian/jenkins-ci.org.key | apt-key add -
RUN sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
RUN apt-add-repository ppa:ansible/ansible
RUN apt-add-repository ppa:git-core/ppa
RUN LC_ALL=en_US.UTF-8 add-apt-repository ppa:ondrej/php

# software
RUN apt-get update
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
    php7.0-bz2 \
    php7.0-mbstring \
    jenkins \
    ansible \
    sqlite3 \
    git \
    ant \
    curl \
    rsync \
    language-pack-en \
    language-pack-de \
    language-pack-es \
    unzip \
    pngquant \
    jpegoptim

# jenkins plugins
ADD https://updates.jenkins-ci.org/latest/git-client.hpi /var/lib/jenkins/plugins/git-client.hpi
ADD https://updates.jenkins-ci.org/latest/git.hpi /var/lib/jenkins/plugins/git.hpi
ADD https://updates.jenkins-ci.org/latest/github-api.hpi /var/lib/jenkins/plugins/github-api.hpi
ADD https://updates.jenkins-ci.org/latest/github.hpi /var/lib/jenkins/plugins/github.hpi
ADD https://updates.jenkins-ci.org/latest/ansicolor.hpi /var/lib/jenkins/plugins/ansicolor.hpi
ADD https://updates.jenkins-ci.org/latest/checkstyle.hpi /var/lib/jenkins/plugins/checkstyle.hpi
ADD https://updates.jenkins-ci.org/latest/cloverphp.hpi /var/lib/jenkins/plugins/cloverphp.hpi
ADD https://updates.jenkins-ci.org/latest/crap4j.hpi /var/lib/jenkins/plugins/crap4j.hpi
ADD https://updates.jenkins-ci.org/latest/dry.hpi /var/lib/jenkins/plugins/dry.hpi
ADD https://updates.jenkins-ci.org/latest/htmlpublisher.hpi /var/lib/jenkins/plugins/htmlpublisher.hpi
ADD https://updates.jenkins-ci.org/latest/jdepend.hpi /var/lib/jenkins/plugins/jdepend.hpi
ADD https://updates.jenkins-ci.org/latest/plot.hpi /var/lib/jenkins/plugins/plot.hpi
ADD https://updates.jenkins-ci.org/latest/pmd.hpi /var/lib/jenkins/plugins/pmd.hpi
ADD https://updates.jenkins-ci.org/latest/violations.hpi /var/lib/jenkins/plugins/violations.hpi
ADD https://updates.jenkins-ci.org/latest/xunit.hpi /var/lib/jenkins/plugins/xunit.hpi
ADD https://updates.jenkins-ci.org/latest/warnings.hpi /var/lib/jenkins/plugins/warnings.hpi
ADD https://updates.jenkins-ci.org/latest/slack.hpi /var/lib/jenkins/plugins/slack.hpi
ADD https://updates.jenkins-ci.org/latest/postbuild-task.hpi /var/lib/jenkins/plugins/postbuild-task.hpi
ADD https://updates.jenkins-ci.org/latest/postbuildscript.hpi /var/lib/jenkins/plugins/postbuildscript.hpi
ADD https://updates.jenkins-ci.org/latest/greenballs.hpi /var/lib/jenkins/plugins/greenballs.hpi
ADD https://updates.jenkins-ci.org/latest/email-ext.hpi /var/lib/jenkins/plugins/email-ext.hpi
ADD https://updates.jenkins-ci.org/latest/token-macro.hpi /var/lib/jenkins/plugins/token-macro.hpi
ADD https://updates.jenkins-ci.org/latest/analysis-core.hpi /var/lib/jenkins/plugins/analysis-core.hpi
ADD https://updates.jenkins-ci.org/latest/ansible.hpi /var/lib/jenkins/plugins/ansible.hpi
ADD https://updates.jenkins-ci.org/latest/slack.hpi /var/lib/jenkins/plugins/slack.hpi

# jenkins templates
ADD https://raw.github.com/sebastianbergmann/php-jenkins-template/master/config.xml /var/lib/jenkins/jobs/php-template/config.xml
RUN chown -R jenkins /var/lib/jenkins

# php modules
RUN  mkdir -p /usr/bin \
  && wget -q -O /usr/bin/phpunit https://phar.phpunit.de/phpunit.phar && chmod +x /usr/bin/phpunit \
  && wget -q -O /usr/bin/composer https://getcomposer.org/composer.phar && chmod +x /usr/bin/composer \
  && wget -q -O /usr/bin/phpmd http://static.phpmd.org/php/latest/phpmd.phar && chmod +x /usr/bin/phpmd \
  && wget -q -O /usr/bin/sami http://get.sensiolabs.org/sami.phar && chmod +x /usr/bin/sami \
  && wget -q -O /usr/bin/phpcov https://phar.phpunit.de/phpcov.phar && chmod +x /usr/bin/phpcov \
  && wget -q -O /usr/bin/phpcpd https://phar.phpunit.de/phpcpd.phar && chmod +x /usr/bin/phpcpd \
  && wget -q -O /usr/bin/phploc https://phar.phpunit.de/phploc.phar && chmod +x /usr/bin/phploc \
  && wget -q -O /usr/bin/pdepend http://static.pdepend.org/php/latest/pdepend.phar && chmod +x /usr/bin/pdepend \
  && wget -q -O /usr/bin/phpcs https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar && chmod +x /usr/bin/phpcs \
&& wget -q -O /usr/bin/phpcb https://github.com/mayflower/PHP_CodeBrowser/releases/download/1.1.1/phpcb-1.1.1.phar && chmod +x /usr/bin/phpcb \
  && wget -q -O /usr/bin/phptok https://phar.phpunit.de/phptok.phar && chmod +x /usr/bin/phptok

# Nodejs
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash -
RUN apt-get install -y nodejs
RUN npm install -g gulp

# start jenkins
RUN echo "service jenkins start" >> /run_all.sh; \echo "service jenkins start" >> /run_all.sh; \
  echo "tail -f /var/log/jenkins/jenkins.log;" >> /run_all.sh

# listen
EXPOSE 8080
CMD ["sh", "/run_all.sh"]

FROM ubuntu:16.04

MAINTAINER Alexej Kloos "alexejkloos@gmail.com"

# update
RUN apt-get update

# dependencies
RUN apt-get -qqy install \
    tzdata \
    wget \
    curl \
    apt-transport-https \
    software-properties-common \
    language-pack-en-base

# Timezone
RUN echo "Europe/Berlin" > /etc/timezone
RUN dpkg-reconfigure --frontend noninteractive tzdata

# sources
RUN wget -q -O - https://jenkins-ci.org/debian/jenkins-ci.org.key | apt-key add -
RUN sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
RUN apt-add-repository ppa:ansible/ansible
RUN apt-add-repository ppa:git-core/ppa
# PHP
RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4F4EA0AAE5267A6C
# Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN sh -c 'echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list'

# software
RUN apt-get update
RUN apt-get -qqy install \
    php7.1-cli \
    php7.1-intl \
    php7.1-mcrypt \
    php7.1-mysql \
    php7.1-gd \
    php7.1-curl \
    php7.1-sqlite3 \
    php7.1-xsl \
    php7.1-common \
    php7.1-bz2 \
    php7.1-mbstring \
    php7.1-zip \
    jenkins \
    ansible \
    sqlite3 \
    git \
    ant \
    rsync \
    language-pack-en \
    language-pack-de \
    language-pack-es \
    unzip \
    pngquant \
    jpegoptim \
    yarn

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
#ADD https://updates.jenkins-ci.org/latest/postbuildscript.hpi /var/lib/jenkins/plugins/postbuildscript.hpi
ADD https://updates.jenkins-ci.org/latest/greenballs.hpi /var/lib/jenkins/plugins/greenballs.hpi
ADD http://archives.jenkins-ci.org/plugins/email-ext/latest/email-ext.hpi /var/lib/jenkins/plugins/email-ext.hpi
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
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y nodejs
RUN npm install -g gulp

# ffmpeg
RUN apt-get -qqy install \
	ffmpeg \
	libvo-aacenc0 \
	libaacs0
RUN apt-get -qqy install \
    libsdl1.2debian \
    zlib1g \
    libfaad2 \
    libgsm1 \
    libtheora0 \
    libvorbis0a \
    libspeex1 \
    libopencore-amrwb0 \
    libopencore-amrnb0 \
    libxvidcore4 \
    libmp3lame0 \
    libjpeg62

# start jenkins
RUN echo "service jenkins start" >> /run_all.sh; \echo "service jenkins start" >> /run_all.sh; \
  echo "tail -f /var/log/jenkins/jenkins.log;" >> /run_all.sh

# Timezone
RUN echo "Europe/Berlin" > /etc/timezone
RUN dpkg-reconfigure --frontend noninteractive tzdata

## listen
EXPOSE 8080
CMD ["sh", "/run_all.sh"]

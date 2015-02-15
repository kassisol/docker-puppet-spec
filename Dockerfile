FROM debian:wheezy

MAINTAINER Julien K. <docker@kassisol.com>

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt-get update
RUN apt-get install -y procps lsb-release build-essential gawk libreadline6-dev zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 autoconf libgdbm-dev libncurses5-dev automake libtool bison pkg-config libffi-dev ruby python curl git

RUN apt-get -y autoremove
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD data/puppet-spec /usr/local/bin/puppet-spec
ADD data/confparser /usr/local/bin/confparser

ADD data/profile/proxy.sh /etc/profile.d/proxy.sh
ADD data/profile/rvm.sh /etc/profile.d/rvm.sh

ENTRYPOINT [ "/usr/local/bin/puppet-spec" ]

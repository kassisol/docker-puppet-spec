FROM debian:wheezy

MAINTAINER Julien K. <docker@kassisol.com>

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends \
		autoconf \
		automake \
		bison \
		build-essential \
		lsb-release \
		pkg-config \
		sqlite3 \
		libffi-dev \
		libgdbm-dev \
		libncurses5-dev \
		libreadline6-dev \
		libsqlite3-dev \
		libssl-dev \
		libtool \
		libyaml-dev \
		zlib1g-dev \
		curl \
		gawk \
		git \
		procps \
		ruby \
		python \
	&& apt-get -y autoremove \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY data/puppet-spec /usr/local/bin/puppet-spec
COPY data/confparser /usr/local/bin/confparser

COPY data/profile/proxy.sh /etc/profile.d/proxy.sh
COPY data/profile/rvm.sh /etc/profile.d/rvm.sh

ENTRYPOINT [ "/usr/local/bin/puppet-spec" ]

#!/bin/sh
#
# install developer tools
set -e

apt-get install -y \
	make \
        cmake \
	automake \
        autoconf \
	build-essential \	
	git-core \
	libperl-dev \
	libgd3 \
	libgd-dev \
	libgeoip1 \
	libgeoip-dev \
	geoip-dev \
	libxml2 \
	libxml2-dev \
	libxslt1.1 \
	libxslt1-dev \
	apache2-utils \
	tree \
	emacs25-nox

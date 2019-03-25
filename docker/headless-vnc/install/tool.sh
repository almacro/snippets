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
	libxml2-dev \
	apache2-utils \
	tree

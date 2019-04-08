#!/bin/sh
#
# install basics
set -e

apt-get -y update
apt-get -y upgrade
apt-get install -y locales
dpkg-reconfigure --frontend=noninteractive locales
localedef -i en_US -f UTF-8 en_US.UTF-8

apt-get install -y \
	apt-transport-https \
	ca-certificates \
	vim \
	curl \
	wget \
	netcat \
	sudo \
	tmux \
	gettext \
	bzip2 \
	gawk \
	rlwrap

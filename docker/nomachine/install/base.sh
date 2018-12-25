#!/bin/sh
#
# install basic things
set -e

apt-get update
apt-get install -y \
	vim \
	xterm \
	pulseaudio \
	cups \
	curl \
	wget \
	time \
	sudo \
	screen \
	gettext \
	bzip2 \
	gawk \
	rlwrap

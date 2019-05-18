#!/bin/sh
#
# install basic things
set -e

apt-get -y update
apt-get -y upgrade
apt-get -y install locales

dpkg-reconfigure --frontend=noninteractive locales
localedef -i en_US -f UTF-8 en_US.UTF-8

apt-get install -y --install-recommends gnupg dirmngr
	

apt-get install -y --no-install-recommends \
	apt-transport-https \
	ca-certificates \
        software-properties-common \
        sudo \
        wget \
        curl \
        zip \
        openssl \
        openssh-client \
        unzip

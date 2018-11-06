#!/usr/bin/env bash
#

sudo apt-get update -y

sudo apt-get install \
     apt-transport-https \
     ca-certificates \
     curl \
     software-properties-common


sudo apt-key fingerprint 0EBFCD88 | grep 0EBFCD88
if [ $? -ne 0 ]
then
    echo "no apt key found for docker, trying to download..."
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

    sudo apt-key fingerprint 0EBFCD88 | grep 0EBFCD88
    if [ $? -ne 0 ]
    then
        echo "still no apt key found for docker, exiting"
        exit 1
    fi
else
    echo "found docker apt key"
fi

sudo apt-add-repository \
     "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) \
stable"

sudo apt-get update -y
sudo apt-get install -y docker-ce docker-compose

sudo usermod -aG docker ubuntu

base=https://github.com/docker/machine/releases/download/v0.15.0 && \
    curl -L $base/docker-machine-$(uname -s)-$(uname -m) >/tmp/docker-machine && \
    sudo install /tmp/docker-machine /usr/local/bin/docker-machine


#!/bin/sh
#
# install user account
set -e

groupadd -r nomachine -g 433
useradd -u 1000 -U -m -s /bin/bash -c "Ubuntu User" ubuntu
usermod -aG nomachine ubuntu
echo "ubuntu:$(cat $INST_SCRIPTS/ubuntu.cred)" | chpasswd

echo 'ubuntu    ALL=(ALL)        NOPASSWD: ALL' > /etc/sudoers.d/ubuntu-sudo

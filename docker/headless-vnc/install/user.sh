#!/bin/sh
#
# install user account
set -e

useradd -u 1000 -U -m -s /bin/bash -c "Ubuntu User" ubuntu

echo "ubuntu:$(cat $INST_SCRIPTS/ubuntu.cred)" | chpasswd

echo 'ubuntu    ALL=(ALL)        NOPASSWD: ALL' > /etc/sudoers.d/ubuntu-sudo

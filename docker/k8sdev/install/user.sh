#!/bin/sh
#
# install user account
set -e

groupadd -r nomachine -g 433

useradd -u 1000 -U -m -c "Software Engineer" -s /bin/bash sweng && \

usermod -aG nomachine sweng

echo "sweng:$(cat $INST_SCRIPTS/sweng.cred)" | chpasswd

echo 'sweng    ALL=(ALL)        NOPASSWD: ALL' > /etc/sudoers.d/sweng-sudo

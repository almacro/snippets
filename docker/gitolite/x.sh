#!/bin/bash

docker run \
       -it \
       -d \
       -p 22022:22 \
       --name gitolite \
       gitolite \
       /usr/sbin/sshd -D

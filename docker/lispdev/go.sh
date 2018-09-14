#!/bin/bash

docker run \
       -it \
       --rm \
       -e USER=lisper \
       -v $PWD/data:/home/lisper/share \
       --name lispdev \
       lispdev \
       bash

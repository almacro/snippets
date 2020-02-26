#!/usr/bin/env bash
#
# [ Chapter 2 ]( https://www.firstpythonnotebook.org/notebook/index.html )
#
# Assumes docker is already set up in the environment
#   https://docs.docker.com/install/linux/docker-ce/ubuntu/
#   or similar version compatible with the local environment

#-p 8888:8888 \
docker run \
       -p 8890:8888 \
       -e JUPYTER_ENABLE_LAB=yes \
       -v "$PWD/data":/home/jovyan/work \
       jupyter/datascience-notebook:latest

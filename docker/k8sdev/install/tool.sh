#!/bin/sh
#
# install developer tools
set -e

apt-get install -y --no-install-recommends \
        automake \
        autoconf \
        build-essential \
        tmux \
        vim \
        emacs25-lucid \
        git-core

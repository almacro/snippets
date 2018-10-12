FROM ubuntu:bionic

ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND noninteractive

RUN printf "LANG=C.UTF-8\n\
LC_ALL=C.UTF-8\n\
" > /etc/default/locale && \
    apt-get -y -qq update && \
    apt-get -y -qq upgrade && \
    apt-get install --no-install-recommends -y python-pip python-dev python2.7-dev make automake autoconf build-essential git-core emacs25-lucid vim-nox curl wget time sudo screen bzip2 rlwrap openssh-client && \
    rm -rf /var/lib/apt/lists/*

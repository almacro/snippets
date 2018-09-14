FROM debian:stretch

RUN echo 'deb http://deb.debian.org/debian/ stretch-backports main' > /etc/apt/sources.list.d/stretch-backports.list
RUN echo 'deb http://deb.debian.org/debian-security stretch/updates main' > /etc/apt/sources.list.d/stretch-security.list

ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND noninteractive

RUN sh -c "echo -e 'LANG=C.UTF-8\nLC_ALL=C.UTF-8' > /etc/default/locale" && \
    apt-get -y update && \
    apt-get -y upgrade && \
    apt-get install -y build-essential m4 git-core subversion emacs25-lucid vim-nox curl wget time sudo screen gettext bzip2 gawk guile rlwrap && \
    rm -rf /var/lib/apt/lists/*

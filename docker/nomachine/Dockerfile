FROM ubuntu:xenial

ENV DEBIAN_FRONTEND noninteractive

ADD ./etc/sources.list /etc/apt/sources.list

RUN apt-get update

ENV INST_SCRIPTS=/tmp/install
ADD ./install $INST_SCRIPTS
RUN find $INST_SCRIPTS -name '*.sh' -exec chmod a+x {} +

RUN $INST_SCRIPTS/base.sh
RUN $INST_SCRIPTS/desktop.sh

ENV NOMACHINE_VERSION 6.4.6
ENV NOMACHINE_MD5 6623e37e88b4f5ab7c39fa4a6533abf4

RUN curl -fSL "http://download.nomachine.com/download/6.4/Linux/nomachine_${NOMACHINE_VERSION}_1_amd64.deb" -o nomachine.deb
RUN $INST_SCRIPTS/nomach.sh

RUN $INST_SCRIPTS/user.sh

RUN rm -fr $INST_SCRIPTS && \
    apt-get clean -y && \
    unset INST_SCRIPTS

ADD ./nxserver.sh /
RUN chmod +x /nxserver.sh
ENTRYPOINT ["/nxserver.sh"]

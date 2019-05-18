FROM debian:stretch

ENV DEBIAN_FRONTEND noninteractive
ENV LANG C.UTF-8

RUN echo 'deb http://deb.debian.org/debian/ stretch-backports main' > /etc/apt/sources.list.d/stretch-backports.list && \
    echo 'deb http://deb.debian.org/debian-security stretch/updates main' > /etc/apt/sources.list.d/stretch-security.list && \
    sh -c "echo -e 'LANG=en_US.UTF-8\nLC_ALL=en_US.UTF-8' > /etc/default/locale" && \
    apt-get -y -qq update

ENV INST_SCRIPTS=/tmp/install
ADD ./install $INST_SCRIPTS
RUN find $INST_SCRIPTS -name '*.sh' -exec chmod a+x {} +

RUN $INST_SCRIPTS/base.sh
RUN $INST_SCRIPTS/desktop.sh

ENV NOMACHINE_VERSION 6.6.8_5
ENV NOMACHINE_MD5 3e814508c064b7096af51394dd5e2732

RUN curl -kfSL "https://download.nomachine.com/download/6.6/Linux/nomachine_${NOMACHINE_VERSION}_amd64.deb" -o nomachine.deb
RUN $INST_SCRIPTS/nomach.sh

RUN $INST_SCRIPTS/tool.sh
RUN $INST_SCRIPTS/python.sh
RUN $INST_SCRIPTS/cloud.sh
RUN $INST_SCRIPTS/user.sh

RUN rm -fr $INST_SCRIPTS && \
    apt-get clean -y && \
    unset INST_SCRIPTS

ADD ./nxserver.sh /
RUN chmod +x /nxserver.sh

ENTRYPOINT ["/nxserver.sh"]

FROM ubuntu:xenial

ENV DEBIAN_FRONTEND noninteractive

ADD ./etc/sources.list /etc/apt/sources.list

RUN apt-get update

ENV PKG_DIR=/tmp/pkg
ADD ./dist $PKG_DIR

ENV INST_SCRIPTS=/tmp/install
ADD ./install $INST_SCRIPTS
RUN find $INST_SCRIPTS -name '*.sh' -exec chmod a+x {} +

RUN $INST_SCRIPTS/base.sh
RUN $INST_SCRIPTS/desktop.sh

RUN $INST_SCRIPTS/tool.sh
RUN $INST_SCRIPTS/novnc.sh

#RUN $INST_SCRIPTS/python.sh
#RUN $INST_SCRIPTS/emacs.sh
#RUN $INST_SCRIPTS/jdk.sh

RUN $INST_SCRIPTS/user.sh

RUN rm -fr $INST_SCRIPTS $PKG_DIR && \
    apt-get clean -y && \
    unset INST_SCRIPTS && \
    apt-get autoclean && \
    apt-get autoremove && \
    rm -fr /var/lib/apt/lists/*

ENV PATH /opt/jdk/bin:$PATH:/opt/TurboVNC/bin:/home/sweng/bin

CMD ["bash"] 

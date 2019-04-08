FROM debian:stretch-slim

ENV NGINX_VERSION 1.15.10
ENV PCRE_VERSION  8.43
ENV ZLIB_VERSION  1.2.11
ENV LIBRESSL_VERSION 2.8.3

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update

ENV PKG_DIR=/tmp/pkg
ADD ./dist $PKG_DIR

ENV INST_SCRIPTS=/tmp/install
ADD ./install $INST_SCRIPTS
RUN find $INST_SCRIPTS -name '*.sh' -exec chmod a+x {} +

RUN $INST_SCRIPTS/base.sh
RUN $INST_SCRIPTS/tool.sh
RUN $INST_SCRIPTS/depend.sh
RUN $INST_SCRIPTS/nginx.sh

RUN rm -fr $INST_SCRIPTS $PKG_DIR && \
    apt-get clean -y && \
    unset INST_SCRIPTS

ADD ./nginx.sh /
RUN chmod +x /nginx.sh
ENTRYPOINT ["/nginx.sh"]
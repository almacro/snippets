#!/bin/sh
#
# install dependencies
set -e

mkdir -p /opt/local/src && cd /opt/local/src

# nginx
wget https://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz && \
    tar zxvf nginx-${NGINX_VERSION}.tar.gz

# PCRE
wget https://ftp.pcre.org/pub/pcre/pcre-${PCRE_VERSION}.tar.gz && \
    tar xzvf pcre-${PCRE_VERSION}.tar.gz

# zlib
wget https://www.zlib.net/zlib-${ZLIB_VERSION}.tar.gz && \
    tar xzvf zlib-${ZLIB_VERSION}.tar.gz

# LibreSSL
wget https://ftp.openbsd.org/pub/OpenBSD/LibreSSL/libressl-${LIBRESSL_VERSION}.tar.gz && \
    tar xzvf libressl-${LIBRESSL_VERSION}.tar.gz

rm \
    nginx-${NGINX_VERSION}.tar.gz \
    pcre-${PCRE_VERSION}.tar.gz \
    zlib-${ZLIB_VERSION}.tar.gz \
    libressl-${LIBRESSL_VERSION}.tar.gz

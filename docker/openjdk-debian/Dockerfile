FROM debian:stretch

ENV DEBIAN_FRONTEND noninteractive
ENV LANG C.UTF-8
ENV JAVA_VERSION 12
ENV JAVA_OPENJDK_VERSION 12.0.1
ENV OPENJDK_JAVA_ID 69cfe15208a647278a19ef0990eea691

RUN echo 'deb http://deb.debian.org/debian/ stretch-backports main' > /etc/apt/sources.list.d/stretch-backports.list && \
    echo 'deb http://deb.debian.org/debian-security stretch/updates main' > /etc/apt/sources.list.d/stretch-security.list && \
    apt-get -y update && \
    apt-get -y upgrade && \
    apt-get -y install wget curl && \
    cd /tmp && \
    wget \
      --quiet \
      --no-cookies \
      --no-check-certificate \
      "https://download.oracle.com/java/GA/jdk${JAVA_OPENJDK_VERSION}/${OPENJDK_JAVA_ID}/${JAVA_VERSION}/GPL/openjdk-${JAVA_OPENJDK_VERSION}_linux-x64_bin.tar.gz" && \
    tar -C /opt -xpf ./openjdk-${JAVA_OPENJDK_VERSION}_linux-x64_bin.tar.gz && \
    rm ./openjdk-${JAVA_OPENJDK_VERSION}_linux-x64_bin.tar.gz && \
    ln -s /opt/jdk* /opt/jdk && \
    rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME /opt/jdk
ENV PATH ${JAVA_HOME}/bin:$PATH

CMD ["bash"]

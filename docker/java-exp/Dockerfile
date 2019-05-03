FROM debian:stretch

ENV DEBIAN_FRONTEND noninteractive
ENV LANG C.UTF-8

#ADD jdk-11.0.3_linux-x64_bin.tar.gz /opt

RUN echo 'deb http://deb.debian.org/debian/ stretch-backports main' > /etc/apt/sources.list.d/stretch-backports.list && \
    echo 'deb http://deb.debian.org/debian-security stretch/updates main' > /etc/apt/sources.list.d/stretch-security.list && \
    sh -c "echo -e 'LANG=en_US.UTF-8\nLC_ALL=en_US.UTF-8' > /etc/default/locale" && \
    apt-get -y update && \
    apt-get -y install --install-recommends gnupg dirmngr && \
    apt-get -y install --no-install-recommends \
      sudo \
      build-essential \
      python-dev \
      wget \
      curl \
      ca-certificates \
      zip \
      openssh-client \
      unzip \
      git-core \
    rm -rf /var/lib/apt/lists/*
#    ln -s /opt/jdk* /opt/jdk && \

# RUN export NODEJS_VERSION="v10.15.3" && \
#     cd /tmp && \
#     curl -k -O -L https://nodejs.org/dist/${NODEJS_VERSION}/node-${NODEJS_VERSION}.tar.gz && \
#     tar xf node-${NODEJS_VERSION}.tar.gz && \
#     cd node-${NODEJS_VERSION} && \
#     ./configure && \
#     make -j4 && \
#     make install && \
#     cd /tmp && \
#     rm -fr node-${NODEJS_VERSION}*

RUN useradd -m -c "Software Engineer" -s /bin/bash sweng && \
    echo 'sweng    ALL=(ALL)        NOPASSWD: ALL' > /etc/sudoers.d/sweng-sudo

USER sweng

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash && \
    export NVM_DIR=${HOME}/.nvm && \
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && \
    nvm install 10.15.3 && \
    node --version

CMD ['/bin/bash']

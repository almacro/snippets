FROM debian:stretch

ENV DEBIAN_FRONTEND noninteractive
ENV SRV_GIT /srv/git

RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get install -y locales && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    localedef -i en_US -f UTF-8 en_US.UTF-8

COPY id_rsa.pub /tmp/id_rsa.pub

RUN apt-get install -y \
            openssh-server \
            procps \
	    netcat \
	    gzip \
	    bzip2 \
	    git-core \
	    wget \
	    curl \
	&& \
    mkdir -p /run/sshd && \
    chmod 0644 /tmp/id_rsa.pub && \
    printf "\n\
cd $SRV_GIT\n\
git clone https://github.com/sitaramc/gitolite\n\
mkdir -p $SRV_GIT/bin\n\
gitolite/install -to $SRV_GIT/bin\n\
" > /tmp/install.sh && \
chmod +x /tmp/install.sh && \
printf "\n\
cd $SRV_GIT\n\
./bin/gitolite setup -pk /tmp/id_rsa.pub\n\
" > /tmp/setup.sh && \
    chmod +x /tmp/setup.sh && \
    useradd -m -d $SRV_GIT -c "Git Hosting" git && \
    mkdir -p $SRV_GIT && \
    chown -R git $SRV_GIT && \
    su - git -c /tmp/install.sh && \
    su - git -c /tmp/setup.sh && \
    rm /tmp/id_rsa.pub



FROM debian:stretch
MAINTAINER Maurice Hebert <moheybear@gmail.com>

RUN echo 'deb http://deb.debian.org/debian/ stretch-backports main' > /etc/apt/sources.list.d/stretch-backports.list
RUN echo 'deb http://deb.debian.org/debian-security stretch/updates main' > /etc/apt/sources.list.d/stretch-security.list

ENV LANG C.UTF-8
ENV JAVA_VERSION 8u171
ENV JAVA_SUNW_VERSION 8u171-b11
ENV ORACLE_JAVA_ID 512cd62ec5174c3487ac17c61aaa89e8

RUN sh -c "echo -e 'LANG=en_US.UTF-8\nLC_ALL=en_US.UTF-8' > /etc/default/locale" && \
    apt-get update && \
    apt-get install -y --install-recommends gnupg dirmngr && \
    apt-get install -y --no-install-recommends \
      wget \
      curl \
      ca-certificates \
      zip \
      openssh-client \
      unzip \
      git-core && \
    rm -rf /var/lib/apt/lists/* && \
    wget \
      --quiet \
      --no-cookies \
      --no-check-certificate \
      --header "Cookie: oraclelicense=accept-securebackup-cookie" \
      "http://download.oracle.com/otn-pub/java/jdk/${JAVA_SUNW_VERSION}/${ORACLE_JAVA_ID}/jdk-${JAVA_VERSION}-linux-x64.tar.gz" && \
    tar -C /opt -xpf ./jdk-${JAVA_VERSION}-linux-x64.tar.gz && \
    rm ./jdk-${JAVA_VERSION}-linux-x64.tar.gz && \
    ln -s /opt/jdk* /opt/jdk

ENV TINI_VERSION v0.17.0
ENV GPG_KEYS 595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini.asc /tini.asc
RUN ( gpg --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys "$GPG_KEYS" \
   || gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$GPG_KEYS" \
   || gpg --keyserver pgp.mit.edu --recv-keys "$GPG_KEYS" \
   || gpg --keyserver keyserver.pgp.com --recv-keys "$GPG_KEYS" ) && \
    gpg --verify /tini.asc && \
    rm /tini.asc && \
    mv /tini /bin/tini && \
    chmod +x /bin/tini

ENV JAVA_HOME /opt/jdk
ENV JENKINS_HOME /var/jenkins_home
ENV JENKINS_SLAVE_AGENT_PORT 50000
ENV JENKINS_VERSION 2.107.3
ENV JENKINS_DL http://mirrors.jenkins.io/war-stable
ENV JENKINS_UC https://updates.jenkins-ci.org
ENV COPY_REFERENCE_FILE_LOG $JENKINS_HOME/copy_reference_file.log

# Jenkins is run with user `jenkins`, uid = 1000
# If you bind mount a volume from the host or a data container,
# ensure you use the same uid
RUN useradd -d "$JENKINS_HOME" -u 1000 -m -s /bin/bash jenkins
RUN mkdir $JENKINS_HOME/.ssh && \
    touch $JENKINS_HOME/.ssh/known_hosts && \
    chmod 0700 $JENKINS_HOME/.ssh && \
    chown -R jenkins $JENKINS_HOME/.ssh

# Jenkins home directory is a volume, so configuration and build history
# can be persisted and survive image upgrades
VOLUME /var/jenkins_home

# `/usr/share/jenkins/ref/` contains all reference configuration we want
# to set on a fresh new installation. Use it to bundle additional plugins
# or config file with your custom jenkins Docker image.
RUN mkdir -p /usr/share/jenkins/ref/init.groovy.d

RUN curl -L ${JENKINS_DL}/${JENKINS_VERSION}/jenkins.war \
      -o /usr/share/jenkins/jenkins.war && \
    curl -L ${JENKINS_DL}/${JENKINS_VERSION}/jenkins.war.sha256 \
      -o /tmp/jenkins.war.sha256 && \
     echo $(awk '{print $1}' /tmp/jenkins.war.sha256) /usr/share/jenkins/jenkins.war \
    | sha256sum -c -

ENV JAVA_OPTS=\
"-Xmx8192m\
 -Xloggc:/var/log/jenkins/verbosegc.log\
 -XX:+PrintGC\
 -XX:+PrintGCTimeStamps"
ENV JENKINS_OPTS=\
"--logfile=/var/log/jenkins/jenkins.log\
 --webroot=/var/cache/jenkins/war"

# Prep Jenkins directories
RUN chown -R jenkins "$JENKINS_HOME" /usr/share/jenkins/ref
RUN mkdir /var/log/jenkins
RUN mkdir /var/cache/jenkins
RUN chown -R jenkins:jenkins /var/log/jenkins
RUN chown -R jenkins:jenkins /var/cache/jenkins

# Export ports for web and slave agents
EXPOSE 8080
EXPOSE 50000

# Copy in local config files
COPY init.groovy /usr/share/jenkins/ref/init.groovy.d/tcp-slave-agent-port.groovy
COPY jenkins.sh /usr/local/bin/jenkins.sh
COPY plugins.sh /usr/local/bin/plugins.sh
RUN chmod +x /usr/local/bin/plugins.sh
RUN chmod +x /usr/local/bin/jenkins.sh

# Switch to the jenkins user
USER jenkins

# Use the SUNW java
ENV PATH $JAVA_HOME/bin:$PATH

# Tini as the entry point to manage zombie processes
ENTRYPOINT ["/bin/tini", "--"]
CMD ["/usr/local/bin/jenkins.sh"]


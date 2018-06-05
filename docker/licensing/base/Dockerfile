FROM centos:7
MAINTAINER Maurice Hebert <moheybear@gmail.com>

COPY etc/intc_lic.txt /tmp/intc_lic.txt

RUN yum -y update && \
    yum -y upgrade && \
    yum install -y redhat-lsb curl cpio

CMD /bin/bash

FROM almacro/licserver-base
MAINTAINER Maurice Hebert <moheybear@gmail.com>

RUN cd /tmp && \
    curl -k -O https://s3-us-west-2.amazonaws.com/qbio-devops/dist/intel/l_isl_server_p_2.6.0.003.tgz && \
    mkdir /tmp/inst_isl && \
    tar -C /tmp/inst_isl -xf ./l_isl_server_p_2.6.0.003.tgz && \
    rm ./l_isl_server_p_2.6.0.003.tgz

COPY silent.cfg /tmp/inst_isl/l_isl_server_p_2.6.0.003/

RUN cd /tmp/inst_isl/l_isl_server_p_2.6.0.003 && \
    ./install.sh -s silent.cfg && \
    touch /opt/intel/licenseserver/lmgrd.log && \
    chmod 1777 /opt/intel/licenseserver/lmgrd.log && \
    cd /tmp && \
    rm -fr /tmp/inst_isl/

CMD /bin/bash
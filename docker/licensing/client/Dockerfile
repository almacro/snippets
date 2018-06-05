FROM almacro/licserver-base
MAINTAINER Maurice Hebert <moheybear@gmail.com>

RUN yum -y groupinstall "Development Tools" && \
    yum -y groupinstall "Compatibility Libraries" && \
    yum -y install libstdc++-devel.i686 glibc-devel.i686 && \
    curl -k -O https://s3-us-west-2.amazonaws.com/qbio-devops/dist/intel/parallel_studio_xe_2018_update2_composer_edition_for_cpp_online.tgz && \
    mkdir /tmp/inst_ips && \
    tar -C /tmp/inst_ips -xf ./parallel_studio_xe_2018_update2_composer_edition_for_cpp_online.tgz && \
    rm ./parallel_studio_xe_2018_update2_composer_edition_for_cpp_online.tgz

COPY silent.cfg /tmp/inst_ips/parallel_studio_xe_2018_update2_composer_edition_for_cpp_online/
COPY install_composer.sh /tmp
ENTRYPOINT ["/tmp/install_composer.sh"]
CMD ["/bin/bash"]

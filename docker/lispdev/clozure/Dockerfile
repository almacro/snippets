FROM lispdev/base

ENV CCL_VERSION 1.11.5

# install the bootstrap ccl and rebuild
RUN curl -L https://github.com/Clozure/ccl/releases/download/v${CCL_VERSION}/ccl-${CCL_VERSION}-linuxx86.tar.gz -o /tmp/ccl-${CCL_VERSION}-linuxx86.tar.gz && \
    tar -C /opt -xpf /tmp/ccl-${CCL_VERSION}-linuxx86.tar.gz && \
    rm /tmp/ccl-${CCL_VERSION}-linuxx86.tar.gz && \
    printf '(rebuild-ccl :full t)\n\
(quit)'\
> /tmp/rebuild.lisp && \
    cd /opt/ccl && \
    cat /tmp/rebuild.lisp | ./lx86cl64 && \
    rm /tmp/rebuild.lisp && \
    cp /opt/ccl/scripts/ccl64 /usr/local/bin/ccl64 && \
    chmod 755 /usr/local/bin/ccl64

ENV CCL_DEFAULT_DIRECTORY /opt/ccl

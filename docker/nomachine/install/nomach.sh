#!/bin/sh
#
# install nomachine
set -e

ls -lR /tmp

NOMACHINE_PKG=nomachine.deb
echo "${NOMACHINE_MD5} ${NOMACHINE_PKG}" | md5sum -c
dpkg -i ${NOMACHINE_PKG}
rm ${NOMACHINE_PKG}

#!/usr/bin/env bash
#
FLEXLM_DIR=/opt/intel/licenseserver
LICENSES=/opt/intel/serverlicenses
su -s /bin/bash nobody -c "${FLEXLM_DIR}/lmgrd -c ${LICENSES}/intc_lic.txt -z -l ${FLEXLM_DIR}/lmgrd.log"

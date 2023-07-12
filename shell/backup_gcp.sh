#!/bin/bash
#
# stream backup dir to GCP storage bucket, encrypted & compressed

USAGE="$0: [dir] [bucket-path] [encrypt-keyfile]"
if [ $# -ne 3 ]; then
  echo "error: wrong args count"
  echo $USAGE
  exit 1
fi

BACKUP_DIR=$1
BUCKET_PATH=$2
CRYPT_KEYFILE=$3
find ${BACKUP_DIR} -print | \
cpio -ov | \
gpg --symmetric --batch --yes --passphrase-file ${CRYPT_KEYFILE} --cipher-algo AES256 | \
xz -c | \
gsutil cp - ${BUCKET_PATH}

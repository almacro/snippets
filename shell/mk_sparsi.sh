#!/usr/bin/env bash
#
# this script creates an encrypted sparse disk image on macosx

if [ $# -ne 2 ]
then
  echo "ERROR wrong number of args given"
  echo "usage: $0 <thesize>[mg] <thename>"
  exit 1
fi

SIZE=$1
NAME=$2

echo creating volume named $NAME of size $SIZE

/usr/bin/hdiutil \
  create \
  -encryption \
  -stdinpass \
  -type SPARSE -fs HFS+J \
  -size ${SIZE} \
  -volname ${NAME} \
  ${NAME}.sparseimage

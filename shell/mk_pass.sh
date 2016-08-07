#!/usr/bin/env bash
LEN=${1:-32}
UUID=$(cat /dev/urandom | env LANG=C tr -dc 'a-zA-Z!#-&*-@' | fold -w 32 | head -n 1)
echo $UUID

#!/usr/bin/env bash
#
# make a sudoer string for USERNAME that runs all commands without a
# password challenge

if [ $# -lt 1 ]; then
    echo "ERROR expected a username argument"
    echo "usage: $0 <username>"
    exit 1
fi

USERNAME=$1
echo "$USERNAME    ALL=(ALL)       NOPASSWD: ALL"

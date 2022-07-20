#!/usr/bin/env bash

trap 'rm -f "$TEMPFILE"' EXIT

TEMPFILE=$(mktemp) || exit 1

cat<<EOF | ccl -Q -b $@
(format t "~&~S~&" ccl:*unprocessed-command-line-arguments*)
EOF

rm ${TEMPFILE}

#!/usr/bin/env bash

trap 'rm -f "$TEMPFILE"' EXIT

TEMPFILE=$(mktemp) || exit 1

cat<<EOF>${TEMPFILE}
(+ 2 2)
EOF

cat  ${TEMPFILE} | ccl -Q -b
rm ${TEMPFILE}

#(format t "~&~S~&" *args*)

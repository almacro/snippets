#!/usr/bin/env bash
exec $(which ccl) --eval '(progn (format t "hello script") (ccl:quit))'

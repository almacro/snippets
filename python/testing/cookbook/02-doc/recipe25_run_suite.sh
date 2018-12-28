#!/bin/sh
#
# use recipe25 script to run doctests on specific suites
# suites runs tests over recipe16 module and recipe17 source file

python recipe25.py --doctest --suite=recipe16,recipe17.py

#!/bin/sh
#
# run recipe14 with installed plugin

nosetests --with-csv-report --csv-file=log.csv recipe14.py

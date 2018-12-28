#!/bin/sh
#
# run recipe13 with installed plugin

nosetests --with-regexpicker --re-pattern='test.*|length' recipe13 --verbosity=2

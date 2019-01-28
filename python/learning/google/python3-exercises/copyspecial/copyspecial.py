#!/usr/bin/python
# Copyright 2010 Google Inc.
# Licensed under the Apache License, Version 2.0
# http://www.apache.org/licenses/LICENSE-2.0

# Google's Python Class
# http://code.google.com/edu/languages/google-python-class/

import sys
import re
import os
import shutil
import subprocess

"""Copy Special exercise
"""

def copy_to_dir(todir, dirs):
  if not os.path.exists(todir):
    os.makedirs(todir)
  for dir in dirs:
    files = os.listdir(dir)
    for file in files:
      match = re.search(r'__\w+__', file)
      if match:
        path = os.path.abspath(os.path.join(dir, file))
        shutil.copy(path, todir)

def copy_to_zip(tozip, dirs):
  files_to_zip = []
  for dir in dirs:
    files = os.listdir(dir)
    for file in files:
      match = re.search(r'__\w+__', file)
      if match:
        path = os.path.abspath(os.path.join(dir, file))
        files_to_zip.append(path)
  cmd = ' '.join(['zip','-j',tozip,' '.join(files_to_zip)])
  print('cmd to run: {0}'.format(cmd))
  p = subprocess.Popen(cmd.split())
  stdout, stderr = p.communicate()
  if p.returncode:
    sys.stderr.write('cmd error:' + stderr +'\n')
    sys.exit(1)
  if stdout:
    print(stdout)
  
def echo_special(dirs):
  for dir in dirs:
    files = os.listdir(dir)
    for file in files:
      match = re.search(r'__\w+__', file)
      if match:
        print(os.path.abspath(os.path.join(dir, file)))

def main():
  # This basic command line argument parsing code is provided.
  # Add code to call your functions below.

  # Make a list of command line arguments, omitting the [0] element
  # which is the script itself.
  args = sys.argv[1:]
  if not args:
    print("usage: [--todir dir][--tozip zipfile] dir [dir ...]")
    sys.exit(1)

  # todir and tozip are either set from command line
  # or left as the empty string.
  # The args array is left just containing the dirs.
  todir = ''
  if args[0] == '--todir':
    todir = args[1]
    del args[0:2]

  tozip = ''
  if args[0] == '--tozip':
    tozip = args[1]
    del args[0:2]

  if len(args) == 0:
    print("error: must specify one or more dirs")
    sys.exit(1)

  for arg in args:
    if not os.path.exists(arg):
      sys.stderr.write('dir not found: ' + arg + '\n')
      sys.exit(1)
  
  if todir:
    copy_to_dir(todir, args)
  elif tozip:
    copy_to_zip(tozip, args)
  else:
    echo_special(args)

if __name__ == "__main__":
  main()

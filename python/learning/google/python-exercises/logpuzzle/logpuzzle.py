#!/usr/bin/python
# Copyright 2010 Google Inc.
# Licensed under the Apache License, Version 2.0
# http://www.apache.org/licenses/LICENSE-2.0

# Google's Python Class
# http://code.google.com/edu/languages/google-python-class/

import os
import re
import sys
import urllib

"""Logpuzzle exercise
Given an apache logfile, find the puzzle urls and download the images.

Here's what a puzzle url looks like:
10.254.254.28 - - [06/Aug/2007:00:13:48 -0700] "GET /~foo/puzzle-bar-aaab.jpg HTTP/1.0" 302 528 "-" "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070725 Firefox/2.0.0.6"
"""


def read_urls(filename):
  """Returns a list of the puzzle urls from the given log file,
  extracting the hostname from the filename itself.
  Screens out duplicate urls and returns the urls sorted into
  increasing order."""
  url_dict = {}
  prefix = 'https://code.google.com'
  f = open(filename, 'r')
  text = f.read()
  f.close()
  urls = re.findall(r'GET\s(\S+puzzle\S+)\s', text)
  for url in urls:
    match = re.search(r'(\w+-\w+).jpg', url)
    if match:
      image = match.group()
      if image not in url_dict:
        url_dict[image] = prefix + url
  return sorted(url_dict.values())

def download_images(img_urls, dest_dir):
  """Given the urls already in the correct order, downloads
  each image into the given directory.
  Gives the images local filenames img0, img1, and so on.
  Creates an index.html in the directory
  with an img tag to show each local image file.
  Creates the directory if necessary.
  """
  if not os.path.exists(dest_dir):
    os.makedirs(dest_dir)
  img_files = {}
  for img_url in img_urls:
    match = re.search(r'(\w+-\w+).jpg', img_url)
    img_key = match.group(1)
    img_file = img_key + '.jpg'
    img_files[img_key] = img_file
    out_file = os.path.join(dest_dir, img_file)
    if not os.path.exists(out_file):
      urllib.urlretrieve(img_url, out_file)
  f = open(os.path.join(dest_dir, 'index.html'), 'w')
  f.write('<html><body>')
  def get_key(it):
    key = it[0]
    if '-' in key:
      lis = key.split('-')
      key = lis[1]
    return key
    
  #items = sorted(img_files.items(), key=lambda it: it[0].split('-')[1])
  #for item in items:
  #  print item
    
  for img_item in sorted(img_files.items(), key=get_key):
    tag = '<img src="' + img_item[1] +'"/>'
    f.write(tag)
  f.write('</body></html>')
  f.close()


def main():
  args = sys.argv[1:]

  if not args:
    print 'usage: [--todir dir] logfile '
    sys.exit(1)

  todir = ''
  if args[0] == '--todir':
    todir = args[1]
    del args[0:2]

  img_urls = read_urls(args[0])

  if todir:
    download_images(img_urls, todir)
  else:
    print '\n'.join(img_urls)

if __name__ == '__main__':
  main()

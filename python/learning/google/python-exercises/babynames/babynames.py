#!/usr/bin/python
# Copyright 2010 Google Inc.
# Licensed under the Apache License, Version 2.0
# http://www.apache.org/licenses/LICENSE-2.0

# Google's Python Class
# http://code.google.com/edu/languages/google-python-class/

import sys
import re

"""Baby Names exercise

Define the extract_names() function below and change main()
to call it.

For writing regex, it's nice to include a copy of the target
text for inspiration.

Here's what the html looks like in the baby.html files:
...
<h3 align="center">Popularity in 1990</h3>
....
<tr align="right"><td>1</td><td>Michael</td><td>Jessica</td>
<tr align="right"><td>2</td><td>Christopher</td><td>Ashley</td>
<tr align="right"><td>3</td><td>Matthew</td><td>Brittany</td>
...

Suggested milestones for incremental development:
 -Extract the year and print it
 -Extract the names and rank numbers and just print them
 -Get the names data into a dict and print it
 -Build the [year, 'name rank', ... ] list and print it
 -Fix main() to use the extract_names list
"""

def extract_names(filename):
  """
  Given a file name for baby.html, returns a list starting with the year string
  followed by the name-rank strings in alphabetical order.
  ['2006', 'Aaliyah 91', Aaron 57', 'Abagail 895', ' ...]
  """
  names = []
  f = open(filename, 'r')
  text = f.read()
  f.close()

  match = re.search(r'Popularity in (\d\d\d\d)', text)
  if match:
    year = match.group(1)
    names.append(year)
  rows = re.findall(r'<tr align="right"><td>(\d+)</td><td>(\w+)</td><td>(\w+)</td>', text)

  name_dict = {}
  for row in rows:
    (rank, boy_name, girl_name) = row
    for name in [boy_name, girl_name]:
      if name not in name_dict:
        name_dict[name] = rank
        
  for name in sorted(name_dict):
    names.append(name + ' ' + name_dict[name])

  return names


def main():
  # This command-line parsing code is provided.
  # Make a list of command line arguments, omitting the [0] element
  # which is the script itself.
  args = sys.argv[1:]

  if not args:
    print 'usage: [--summaryfile] file [file ...]'
    sys.exit(1)

  # Notice the summary flag and remove it from args if it is present.
  summary = False
  if args[0] == '--summaryfile':
    summary = True
    del args[0]

  for filename in args:
    names = extract_names(filename)
    if summary:
      summary_filename = filename + '.summary'
      f = open(summary_filename, 'w')
      for name in names:
        f.write(name+'\n')
      f.close()
    else:
      for name in names:
        print(name)
        
if __name__ == '__main__':
  main()

'''

Example 21. using getFreePages

This example shows the getFreePages() method, which queries the host system
for free pages of a given size. The input is a python list of page sizes of
interest, given in kilobytes. For instance, a page size of 2 MiB is given as 2048.

The start argument refers to the first NUMA node to query, the cellcount 
argument specifies how many consecutive nodes should be queried.

An error is thrown if the host system does not support memory pages of 
the requested size.

'''


import sys
import libvirt

uri = 'qemu:///system'
conn = libvirt.open(uri)
if conn is None:
    print(f"Failed to open connection to {uri}", file=sys.stderr)
    exit(1)

pages = [2048]
start = 0
cellcount = 4

buf = conn.getFreePages(pages, start, cellcount)

i = 0
for page in buf:
    print(f'Page size {pages[i]} Available Pages: {page}')
    ++i

conn.close()
exit(0)

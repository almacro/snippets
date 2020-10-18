'''

Example 11. Using getCellsFreeMemory

This example demonstrates the getCellsFreeMemory() method.
It can be used to obtain the amount of free memory in bytes
in some or all of the NUMA nodes in the system.

'''

import sys
import libvirt

uri = 'qemu:///system'
conn = libvirt.open(uri)
if conn is None:
    print(f"Failed to open connection to {uri}", file=sys.stderr)
    exit(1)

nodeinfo = conn.getInfo()
numnodes = nodeinfo[4]

memlist = conn.getCellsFreeMemory(0, numnodes)
cell = 0
for cellfreemem in memlist:
    print(f'Node {cell}: {cellfreemem} bytes free')
    cell += 1

conn.close()
exit(0)

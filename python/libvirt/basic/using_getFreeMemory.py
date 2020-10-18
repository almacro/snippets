'''

Example 20. using getFreeMemory

This example demonstrates the getFreeMemory() method, which gets available free
memory on the node. The value returned is given in bytes.

'''

import sys
import libvirt

uri = 'qemu:///system'
conn = libvirt.open(uri)
if conn is None:
    print(f"Failed to open connection to {uri}", file=sys.stderr)
    exit(1)

mem = conn.getFreeMemory()

print(f'Free memory on the node(host) is {mem} bytes.')

conn.close()
exit(0)

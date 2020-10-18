'''

Example 26. using getCPUMap

The getCPUMap() method returns a CPU map of host node CPUs.

'''


import sys
import libvirt

uri = 'qemu:///system'
conn = libvirt.open(uri)
if conn is None:
    print(f"Failed to open connection to {uri}", file=sys.stderr)
    exit(1)

map = conn.getCPUMap()

print(f'CPUs     : {map[0]}')
print(f'Available: {map[1]}')

conn.close()
exit(0)

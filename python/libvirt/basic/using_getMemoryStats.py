'''

Example 23. using getMemoryStats

The getMemoryStats() method returns the memory statistics for a single node(host)
as a list of strings.

'''


import sys
import libvirt

uri = 'qemu:///system'
conn = libvirt.open(uri)
if conn is None:
    print(f"Failed to open connection to {uri}", file=sys.stderr)
    exit(1)

buf = conn.getMemoryStats(libvirt.VIR_NODE_MEMORY_STATS_ALL_CELLS)
print(buf.keys())

print(f"free   : {buf['free']}")
print(f"cached : {buf['cached']}")
print(f"buffers: {buf['buffers']}")
print(f"total  : {buf['total']}")

conn.close()
exit(0)

'''

Example 10. Using getInfo

This example shows getInfo() usage. This method can be used to obtain
virtualization host details.

'''

import sys
import libvirt

uri = 'qemu:///system'
conn = libvirt.open(uri)
if conn is None:
    print(f"Failed to open connection to {uri}", file=sys.stderr)
    exit(1)

nodeinfo = conn.getInfo()
print(f'Model                : {nodeinfo[0]}')
print(f'Memory size          : {nodeinfo[1]}MB')
print(f'Number of CPUs       : {nodeinfo[2]}')
print(f'MHz of CPUs          : {nodeinfo[3]}')
print(f'Number of NUMA nodes : {nodeinfo[4]}')
print(f'Number of CPU sockets: {nodeinfo[5]}')
print(f'Number of CPU cores  : {nodeinfo[6]}')
print(f'Number of CPU threads: {nodeinfo[7]}')

conn.close()
exit(0)

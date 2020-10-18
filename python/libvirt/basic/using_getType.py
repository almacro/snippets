'''

Example 12. using getType

This example shows how to use the getType() method, which
can be used to fetch the type of virtualization in use
on a connection.

'''

import sys
import libvirt

uri = 'qemu:///system'
conn = libvirt.open(uri)
if conn is None:
    print(f"Failed to open connection to {uri}", file=sys.stderr)
    exit(1)

print(f'Virtualization type: {conn.getType()}')

conn.close()
exit(0)

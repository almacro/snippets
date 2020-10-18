'''

Example 9. Using getMaxVcpuss

This example demonstrates the getMaxVcpus() method.  This can be used
to obtain the maximum number of virtual CPUs per guest that the
underlying virtualization technology supports.

'''

import sys
import libvirt

uri = 'qemu:///system'
conn = libvirt.open(uri)
if conn is None:
    print(f"Failed to open connection to {uri}", file=sys.stderr)
    exit(1)

vcpus = conn.getMaxVcpus(None)
print(f'Maximum supported virtual CPUs: {vcpus}')

conn.close()
exit(0)

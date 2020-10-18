'''

Example 1. Using open

This example opens a connection to the system QEMU hypervisor driver,
checks for success, and, if so, closes the connection

'''

import sys
import libvirt

uri = 'qemu:///system'
conn = libvirt.open(uri)

if conn is None:
    print(f"Failed to open connection to {uri}", file=sys.stderr)
    exit(1)
print('Connection successful.')
conn.close()
print('Connection closed.')
exit(0)

'''

Example 2. Using openReadOnly

This example opens a read-only connection to the system QEMU
hypervisor driver, checks for success, and, if so, closes the
connection

'''

import sys
import libvirt

uri = 'qemu:///system'
conn = libvirt.openReadOnly(uri)
if conn is None:
    print(f"Failed to open connection to {uri}", file=sys.stderr)
    exit(1)
print('Connection successful.')
conn.close()
print('Connection closed.')
exit(0)

'''

Example 5. Connect to local QEMU

This example shows how to connect to a QEMU hypervisor using a local URI

'''

import sys
import libvirt

uri = 'qemu:///system'
conn = libvirt.open(uri)
if conn is None:
    print(f"Failed to open connection to {uri}", file=sys.stderr)
    exit(1)
conn.close()
exit(0)

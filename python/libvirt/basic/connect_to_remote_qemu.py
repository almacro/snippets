'''

Example 6. Connect to remote QEMU

This example shows how to connect to a QEMU hypervisor using a remote URI

'''

import sys
import libvirt

uri = 'qemu+tls://host2/system'
conn = libvirt.open(uri)
if conn is None:
    print(f"Failed to open connection to {uri}", file=sys.stderr)
    exit(1)
conn.close()
exit(0)

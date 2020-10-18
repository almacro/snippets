'''

Example 8. Using getHostname

This example demonstrates the getHostname() method.
This can be used to obtain the hostname of the 
virtualization host as returned by gethostname().

'''

import sys
import libvirt

uri = 'qemu:///system'
conn = libvirt.open(uri)
if conn is None:
    print(f"Failed to open connection to {uri}", file=sys.stderr)
    exit(1)

host = conn.getHostname()
print(f"Hostname: {host}")

conn.close()
exit(0)

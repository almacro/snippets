'''

Example 14. using getLibVersion

This example demonstrates the getLibVersion() method. This method
provides the version of libvirt software in use on the virtualization
host. On success it returns the version as a string, otherwise None.
The version number is formed as:

1000000*version

'''

import sys
import libvirt

uri = 'qemu:///system'
conn = libvirt.open(uri)
if conn is None:
    print(f"Failed to open connection to {uri}", file=sys.stderr)
    exit(1)

print(f'Libvirt Version: {conn.getLibVersion()}')

conn.close()
exit(0)

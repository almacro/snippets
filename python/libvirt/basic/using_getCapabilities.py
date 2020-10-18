'''

Example 7. Using getCapabilities

This example demonstrates the getCapabilities() method
call. This method can be used to obtain information 
about the capabilities of the virtualization host.
On success, it returns a Python string containing the
capabilities XML. Otherwise, it returns None.

'''

import sys
import libvirt

uri = 'qemu:///system'
conn = libvirt.open(uri)
if conn is None:
    print(f"Failed to open connection to {uri}", file=sys.stderr)
    exit(1)
caps = conn.getCapabilities()  # caps is a string of XML
print(f"Capabilities:\n{caps}")

conn.close()
exit(0)

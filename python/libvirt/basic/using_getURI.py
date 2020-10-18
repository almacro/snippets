'''

Example 15. using getURI

This example shows the getURI() method, which can be used to get the
URI for the current connection.  The value returned is typically a
string identical to the parameter passed to the open() call that
produced the connection. In some instances, the driver may convert the
input parameter to canonical form.

'''

import sys
import libvirt

uri = 'qemu:///system'
conn = libvirt.open(uri)
if conn is None:
    print(f"Failed to open connection to {uri}", file=sys.stderr)
    exit(1)

print(f'Canonical URI: {conn.getURI()}')

conn.close()
exit(0)

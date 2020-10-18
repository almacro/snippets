'''

Example 4. Uaing close with additional references

This example demonstrates how connection reference counting works.
The reference count is explicitly increased by an initial call to
open(), openAuth(), and similar calls. It is also temporarily increased
by other methods that depend on the keeping the connection alive.
The open() function call should have a matching close(), and all
other references will be released when the corresponding operation
completes. Reference counts can be automatically decreased when
a class instance goes out of scope or the program ends. Reference
counts are decremented to zero when the process ends.

'''

import sys
import libvirt

uri = 'qemu:///system'
conn1 = libvirt.open(uri)
if conn1 == None:
    print(f"Failed to open connection to {uri}", file=sys.stderr)
    exit(1)
conn2 = libvirt.open(uri)
if conn2 == None:
    print(f"Failed to open connection to {uri}", file=sys.stderr)
    exit(1)
conn1.close()
conn2.close()
exit(0)

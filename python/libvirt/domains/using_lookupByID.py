'''

Example 1. using lookupByID

The lookupByID() method is used for fetching a Domain Object by ID.
An existing, active domain can be retrieved using its integer ID number.
'''


import sys
import libvirt

uri = 'qemu:///system'
conn = libvirt.open(uri)
if conn is None:
    print(f"Failed to open connection to {uri}", file=sys.stderr)
    exit(1)

try:
    domainID = 6
    dom = conn.lookupByID(domainID)
except:
    print('Failed to get the domain object', file=sys.stderr)

conn.close()
exit(0)

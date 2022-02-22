'''

Example 2. using lookupByName

The lookupByName() method retrieves a Domain Object by its name.
This can be useful for retrieving inactive domains which do not
have an associated ID.

'''


import sys
import libvirt

uri = 'qemu:///system'
conn = libvirt.open(uri)
if conn is None:
    print(f"Failed to open connection to {uri}", file=sys.stderr)
    exit(1)

try:
    domainName = 'someguest'
    dom = conn.lookupByName(domainName)
except:
    print('Failed to get the domain object', file=sys.stderr)

conn.close()
exit(0)

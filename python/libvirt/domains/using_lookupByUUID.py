'''

Example 3. using lookupByUUID

The lookupByUUID() method can be used to fetch a Domain Object by UUID.
The domain need not be active.

'''


import sys
import libvirt

uri = 'qemu:///system'
conn = libvirt.open(uri)
if conn is None:
    print(f"Failed to open connection to {uri}", file=sys.stderr)
    exit(1)

try:
    domainUUID = '00311636-7767-71d2-e94a-26e7b8bad250'
    dom = conn.lookupByUUID(domainUUID)
except:
    print('Failed to get the domain object', file=sys.stderr)

conn.close()
exit(0)

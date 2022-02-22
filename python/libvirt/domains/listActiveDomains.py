'''

Example 4. using listDomainsID

The listDomainsID() method returns a list of IDs for all the active domains.

'''

import sys
import libvirt

uri = 'qemu:///system'
conn = libvirt.open(uri)
if conn is None:
    print(f"Failed to open connection to {uri}", file=sys.stderr)
    exit(1)

try:
    domainIDs = conn.listDomainsID()
except:
    print('Failed to get a list of domain IDs', file=sys.stderr)
    exit(1)

print("Active domain IDs:")
if len(domainIDs) == 0:
    print('  None')
else:
    for domainID in domainIDs:
        print('  '+str(domainID))

conn.close()
exit(0)

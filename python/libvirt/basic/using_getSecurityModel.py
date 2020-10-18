'''

Example 24. using getSecurityModel

The getSecurityModel() method returns the security model as a list,
if any is currently in use.

'''

import sys
import libvirt

uri = 'qemu:///system'
conn = libvirt.open(uri)
if conn is None:
    print(f"Failed to open connection to {uri}", file=sys.stderr)
    exit(1)

model = conn.getSecurityModel()

print(f'{model[0]}: {model[1]}')

conn.close()
exit(0)

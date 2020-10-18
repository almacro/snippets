'''

Example 28. using getCPUModelNames

The getCPUModelNames() method gives a list of CPU names that match an
architecture type.

'''


import sys
import libvirt

uri = 'qemu:///system'
conn = libvirt.open(uri)
if conn is None:
    print(f"Failed to open connection to {uri}", file=sys.stderr)
    exit(1)

models = conn.getCPUModelNames('x86_64')

for model in models:
    print(model)

conn.close()
exit(0)

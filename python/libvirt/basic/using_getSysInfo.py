'''

Example 25. using getSysinfo

The getSysinfo() method returns system information as an XML document.
The format used is same as used in the domain XML document.

'''


import sys
import libvirt

uri = 'qemu:///system'
conn = libvirt.open(uri)
if conn is None:
    print(f"Failed to open connection to {uri}", file=sys.stderr)
    exit(1)

xmlInfo = conn.getSysinfo()
print(xmlInfo)

conn.close()
exit(0)

'''

Example 16. using isEncrypted

This example demonstrates the isEncrypted() method, which is used to 
determine if the current connection is encrypted. The method returns

   1 - for an encrypted connection
   0 - for unencrypted connection
  -1 - in case of error

'''

import sys
import libvirt

uri = 'qemu:///system'
conn = libvirt.open(uri)
if conn is None:
    print(f"Failed to open connection to {uri}", file=sys.stderr)
    exit(1)

print(f'Connection is encrypted: {conn.isEncrypted()}')

conn.close()
exit(0)

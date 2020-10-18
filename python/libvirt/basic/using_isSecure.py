'''

Example 17. using isSecure

This example demonstrates the isSecure() method. A connection is considered
to be secure if it is encrypted, or runs on a channel that is not vulnerable
to eavesdropping (such as a UNIX socket). The method returns

   1 - for a secure connection
   0 - for an insecure connection
  -1 - if an error occurs

'''

import sys
import libvirt

uri = 'qemu:///system'
conn = libvirt.open(uri)
if conn is None:
    print(f"Failed to open connection to {uri}", file=sys.stderr)
    exit(1)

print(f'Connection is secure: {conn.isSecure()}')

conn.close()
exit(0)

'''

Example 18. using isAlive

This example shows the isAlive() method, which can be used to check
whether the connection to the hypervisor is still alive. A connection
is considered to be alive if it is either local or running over a 
channel (UNIX or TCP socket) that is not closed.

'''

import sys
import libvirt

uri = 'qemu:///system'
conn = libvirt.open(uri)
if conn is None:
    print(f"Failed to open connection to {uri}", file=sys.stderr)
    exit(1)

alive = conn.isAlive()

print(f'Connection is alive = {alive}')

conn.close()
exit(0)

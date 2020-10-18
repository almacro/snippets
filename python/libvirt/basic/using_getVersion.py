'''

Example 13. using getVersion

This example shows how to use the getVersion() method, which returns
the version of the libvirt library in use, when no name paramter is given
(or is assigned None). When name parameter is given as the name of a
driver linked to the libvirt library, then a tuple is returned as:

  (library_version, driver_version)

If given name references a nonexistent driver then an exception is
raised:

  :no support for hypervisor

Version numbers returned are integers of form:

  (1000000 * major) + (1000 * minor) + release

'''

import sys
import libvirt

uri = 'qemu:///system'
conn = libvirt.open(uri)
if conn is None:
    print(f"Failed to open connection to {uri}", file=sys.stderr)
    exit(1)

print(f'Version: {conn.getVersion()}')

conn.close()
exit(0)

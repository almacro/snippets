'''

Example 19. using compareCPU

This example shows the compareCPU() method, which is used to compare a 
given CPU description with the host CPU. The XML description argument is
same as the domain description XML documents.

'''

import sys
import libvirt

uri = 'qemu:///system'
conn = libvirt.open(uri)
if conn is None:
    print(f"Failed to open connection to {uri}", file=sys.stderr)
    exit(1)

xml = '''<cpu mode="custom" match="exact">
  <model fallback="forbid">kvm64</model>
</cpu>'''

retc = conn.compareCPU(xml)

if retc == libvirt.VIR_CPU_COMPARE_ERROR:
    print('CPUs are not the same or there was an error.')
elif retc == libvirt.VIR_CPU_COMPARE_INCOMPATIBLE:
    print('CPUs are incompatible.')
elif retc == libvirt.VIR_CPU_COMPARE_IDENTICAL:
    print('CPUs are identical')
elif retc == libvirt.VIR_CPU_COMPARE_SUPERSET:
    print('The host CPU is better than the one specified.')
else:
    print('An unknown result code was returned.')

conn.close()
exit(0)


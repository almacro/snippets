'''

Example 22. using getMemoryParameters

This example demonstraes the getMemoryParameters() method. This is used return
all memory parameters as string values.

'''


import sys
import libvirt

uri = 'qemu:///system'
conn = libvirt.open(uri)
if conn is None:
    print(f"Failed to open connection to {uri}", file=sys.stderr)
    exit(1)

pages = [2048]
start = 0
cellcount = 4

buf = conn.getMemoryParameters()

print(f"shm_pages_shared       : {buf['shm_pages_shared']}")
print(f"shm_full_scans         : {buf['shm_full_scans']}")
print(f"shm_merge_across_nodes : {buf['shm_merge_across_nodes']}")

print(f"shm_pages_to_scan      : {buf['shm_pages_to_scan']}")
print(f"shm_pages_unshared     : {buf['shm_pages_unshared']}")
print(f"shm_sleep_millisecs    : {buf['shm_sleep_millisecs']}")

print(f"shm_pages_sharing      : {buf['shm_pages_sharing']}")
print(f"shm_pages_volatile     : {buf['shm_pages_volatile']}")

conn.close()
exit(0)

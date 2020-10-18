'''

Example 27. using getCPUStats

The getCPUStats() method can be used to get stats for one or more CPUs.
The method argument is a CPU number if stats are desired for a single CPU,
or the value VIR_NODE_CPU_STATS_ALL_CPUS to get stats for all node CPUs.

'''


import sys
import libvirt

uri = 'qemu:///system'
conn = libvirt.open(uri)
if conn is None:
    print(f"Failed to open connection to {uri}", file=sys.stderr)
    exit(1)

stats = conn.getCPUStats(0)

print(f"kernel: {stats['kernel']}")
print(f"idle  : {stats['idle']}")
print(f"user  : {stats['user']}")
print(f"iowait: {stats['iowait']}")

conn.close()
exit(0)

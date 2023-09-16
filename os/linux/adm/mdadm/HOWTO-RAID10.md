# Creating a Complex RAID10 array

* Requires minimum of 3 storage devices
* Primary benefit is performance and redundancy
* Amount of capacity reduction for the array is defined by number of data copies chosen to keep.
  The number of copies stored with mdadm style RAID10 is configurable.
  
The default is to store two copies of each data block in the `near` layout. These layouts for storing data blocks are supported:

     * **near**: The default arrangement. Copies of each chunk are written consecutively when striping, meaning that the copies of the data blocks will be written around the same part of multiple disks.
     * **far**: The first and subsequent copies are written to different parts of the storage devices in the array. For instance, the first chunk might be written near the beginning of a disk, while the second chunk would be written halfway down on a different disk. This can give some read performance gains for traditional spinning disks at the expense of write performance.
     * **offset**: Each stripe is copied, and offset by one drive. This means that the copies are offset from one another, but still close together on the disk. This helps minimize excessive seeking during some workloads.


### Find the indentifiers for the raw disks to be used:
```
lsblk -o NAME,SIZE,FSTYPE,TYPE,MOUNTPOINT
```

## Create and mount the filesystem

### Create a RAID10 with commands
EXAMPLE - sets up 2 copies using `near` layout (does not specify a layout and copy number)
```
sudo mdadm --create --verbose /dev/md0 --level=10 --raid-devices=4 /dev/sdf /dev/sdg /dev/sdh /dev/sdi
```

To use a different layout or change the number of copies, use the --layout= option.
This takes a layout and copy identifier. The layouts are `n` for near, `f` for far, and `o` for offset.
The number of copies to store is appended afterward.

EXAMPLE - creates array with three copies in offset layout
```
sudo mdadm --create --verbose /dev/md0 --level=10 --layout=o3 --raid-devices=4 /dev/sdf /dev/sdg /dev/sdh /dev/sdi
```

### Check `/proc/mdstat` to monitor assembly

The array is built using the recovery process for performance. This may take some time to complete,
but the array can be used during this process. Monitor the process of mirroring with:
```
cat /proc/mdstat
```

### Create a filesystem on the array
```
sudo mkfs.ext4 -F /dev/md0
```

### Create a mount point to attach the new filesystem
```
sudo mkdir -p /mnt/md0
```

### Mount the filesystem
```
sudo mount /dev/md0 /mnt/md0
```

### Check new space is available
```
df -h -x devtmpfs -x tmpfs
```

## Save the array layout

### Ensure the array is finished assembling
```
cat /proc/mdstat
```

### Scan the active array and append to `/etc/mdadm/mdadm.conf`
```
sudo mdadm --detail --scan | sudo tee -a /etc/mdadm/mdadm.conf
```

### Update initramfs to make array available during early boot process
```
sudo update-initramfs -u
```

### Add new filesystem options to automatically mount at boot
```
echo '/dev/md0 /mnt/md0 ext4 defaults,nofail,discard 0 0' | sudo tee -a /etc/fstab
```

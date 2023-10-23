
# Destroy mdadm array

### Find active arrays in the `/proc/mdstat` file
```
cat /proc/mdstat
```

Example output (no arrays configured):
```
$ cat /proc/mdstat
Personalities : [linear] [multipath] [raid0] [raid1] [raid6] [raid5] [raid4] [raid10] 
unused devices: <none>
```

### Unmount array from filesystem
```
sudo umount /dev/md0
```

### Stop and remove the array:
```
sudo mdadm --stop /dev/md0
```

### Find the devices that were used to build the array with command:
```
lsblk -o NAME,SIZE,FSTYPE,TYPE,MOUNTPOINT
```

### After discovering the devices used to create an array, zero their superblock that holds metadata for the RAID setup.
Zeroing this removes the RAID metadata and resets them to normal:
EXAMPLE
```
sudo mdadm --zero-superblock /dev/sda
sudo mdadm --zero-superblock /dev/sdb
```

### Remove any persistent references to the array.
Edit the `/etc/fstab` file and comment out or remove the reference to the array.


### Comment or remove the array definition from the `/etc/mdadm/mdadm.conf` file:

### Update the `initramfs` again so that the early boot process does not try to bring an unavailable array online:
```
sudo update-initramfs -u
```

# Creating a RAID6 array

* Requires minimum of 4 storage devices
* Primary benefit is double redundancy with more usable capacity
* Parity information is distributed while two disk's worth of capacity will be used for parity.
  RAID6 has poor performance when in degraded state.

### Find the indentifiers for the raw disks to be used:
```
lsblk -o NAME,SIZE,FSTYPE,TYPE,MOUNTPOINT
```

## Create and mount the filesystem

### Create a RAID6 with commands
EXAMPLE
```
sudo mdadm --create --verbose /dev/md0 --level=6 --raid-devices=4 /dev/sdf /dev/sdg /dev/sdh /dev/sdi
```

### Check `/proc/mdstat` to Confirm the RAID was successfully created
```
cat /proc/mdstat
```

WARN: While the array is building the system will report inaccurate number of spares.
Wait until the array is finished assembling before updating `/etc/mdadm/mdadm.conf`.
Otherwise the system will have incorrect information about array state and will be
unable to assemble it automatically at boot with the correct name.

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

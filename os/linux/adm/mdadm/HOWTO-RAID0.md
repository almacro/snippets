# Creating a RAID0 array

* Requires minimum of 2 storage devices
* Primary benefit is performance in terms of read/write access and capacity
* A single device failure will destroy all data in the array

### Find the indentifiers for the raw disks to be used:
```
lsblk -o NAME,SIZE,FSTYPE,TYPE,MOUNTPOINT
```

## Create and mount the filesystem

### Create a RAID0 with commands
EXAMPLE
```
sudo mdadm --create --verbose /dev/md0 --level=0 --raid-devices=2 /dev/sdf /dev/sdg
```

### Check `/proc/mdstat` to Confirm the RAID was successfully created
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

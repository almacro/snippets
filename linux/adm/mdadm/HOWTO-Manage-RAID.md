# Manage RAID arrays with `mdadm`

## Query RAID info

Get detailed information about a RAID device use `-D` or `--device` option
```
sudo mdadm -D /dev/md0
```

For brief details (appropriate for adding to `/dev/mdadm/mdadm.cond`, use `--brief` or `-b`
flags with the detail option
```
sudo mdadm -Db /dev/md0
```

To get human-readable RAID device summary, use the `-Q` option
```
sudo mdadm -Q /dev/md0
```

## Getting Component Device info

The `Q` option, when used with a component device, will tell you the array it is part of and its role:
```
sudo mdadm -Q /dev/sdc
```

Get more details by using the `-E` or `--examine` options:
```
sudo mdadm -E /dev/sdc
```

## Reading `/proc/mdstat` info

For details about assembled arrays on the server, check the `/proc/mdstat` file.
This is often the best way to get status of active arrays on the system.
```
cat /proc/mdstat
```

## Stop an array

Change directory to outside mounted volume
```
cd ~
```

Unmount the filesystem
```
sudo umount /mnt/md0
```

Stop all active arrays by running:
```
sudo mdadm --stop /dev/md0
```

To stop a specific array, pass it the `mdadm --stop` command:
```
sudo mdadm --stop /dev/md0
```

This will stop the array. It needs to be reassembled before it can be accessed again.

## Start an array

To start all arrays defined in the configuration files or `/proc/mdstat`, type:
```
sudo mdadm --assemble scan
```

To start a specific array, pass it in aa an argument to `mdadm --assemble`:
```
sudo mdadm --assemble /dev/md0
```

This works if the array is defined in the configuration file.

If the correct definition for the array is missing from the configuration file, 
the array can still be started by passing in the component devices:
```
sudo mdadm --assemble /dev/md0 /dev/sda /dev/sdb /dev/sdc /dev/sdd
```

Once the array is assmebled, it can be mounted as usual:
```
sudo mount /dev/md0 /mnt/md0
```

After this, the array should be accessible at the mount point.

## Add a spare device to an array

Spare devices can be added to any arrays that offer redundancy (such
as RAID 1, 5, 6, or 10). The spare will not be actively used by the
array unless an active device fails. When this happens, the array
will resync the data to the spare drive to repair the array to full
health. Spares cannot be added to non-redundant arrays (RAID 0)
because the array will not survive the failure of a drive.

To add a spare, pass in the array and the new device to `mdadm -add`:
```
sudo mdadm /dev/md0 --add /dev/sde
```

If the array is not in a degraded state, the new device will be added as a spare.
If the array is degraded, the resync operation will immediately begin using the
spare to replace the faulty drive.

After a spare is added, update the configuration file to reflect the new device
orientation. Remove or comment out the line that corresponds to the array definition.
Then append the current configuration with:
```
sudo mdadm --detail --brief /dev/md0 | sudo tee -a /etc/mdadm/mdadm.conf
```

## Increase the number of active devices in an array

It is possible to grow an array by increasing the number of active
devices within the assembly. The exact procedure depends slightly
on the RAID level you are using.

### With RAID1 or RAID10

Begin by adding the new device as a spare:
```
sudo mdadm /dev/md0 --add /dev/sde
```

Find out the current number of RAID devices in the array:
```
sudo mdadm --detail /dev/md0
```

Reconfigure the array to have an additional active device. The spare
will be used to satisfy the extra drive requirement:
```
sudo mdadm --grow --raid-devices=3 /dev/md0
```

The array will reconfigure with an additional active disk.
To view the progress of syncing data, enter:
```
cat /proc/mdstat
```


### With RAID5 or RAID6

Begin by adding the new device as a spare:
```
sudo mdadm /dev/md0 --add /dev/sde 
```

Check current number of RAID devices in the array:
```
sudo mdadm --detail /dev/md0
```

Reconfigure the array to have an additional active device. The spare                                                                                     will be used to satisfy the extra drive requirement. When growing a RAID 5 or RAID 6 array,
it is important to include the `--backup-file` option. This should point to a location off
the array where a backup file containing critical information will be stored.

This backup file is only used a very short but critical time during
the reconfiguration process and will be deleted automatically when the
process is finished. As the time whenthis is needed is very brief, the
file may not be apparent on disk, but in the event that something goes
wrong, it can be used to rebuild the array.

```
sudo mdadm --grow --raid-devices=4 --backup-file=/root/md0_grow.bak /dev/md0
```

Check progress of the change with
```
cat /proc/mdstat
```

After the reshape is complete, the filesystem on the array will need to be expanded to use
the added space.
```
sudo resize2fs /dev/md0
```

### With RAID0

Check the current number of RAID devices in the array
```
sudo mdadm --detail /dev/md0
```

Increase number of RAID devices and add a new drive:
```
sudo mdadm --grow /dev/md0 --raid-devices=3 --add /dev/sdc
```

Check progress with
```
cat /proc/mdstat
```

Resize the filesystem to fill increased space
```
sudo resize2fs /dev/md0
```


## Remove a device from an array

Removing a drive from a RAID array is sometimes necessaey if there is a fault or the disk needs to be switched out.

For a device to be removed, it must first be marked "failed" within the array.
Check if there is a failed device by using  `mdadm --detail`:
```
sudo mdadm --detail /dev/md0
```

If a drive needs to be removed that does not have a problem, it can manually be marked as failed with `--fail` option:
```
sudo mdadm /dev/md0 --fail /dev/sdc
```

Once a device is failed, remove it from the array with `mdadm --remove`:
```
sudo mdadm /dev/md0 --remove /dev/sdc 
```

Replace failed device with fresh device
```
sudo mdadm /dev/md0 --add /dev/sdd
```

The array will recover by copying data to the new drive


## Delete an array

Change directory to outside mounted volume
```
cd ~
```

Unmount the filesystem
```
sudo umount /mnt/md0
```

Stop the array
```
sudo mdadm --stop /dev/md0
```

Delete the array
```
sudo mdadm --remove /dev/md0
```

Check for superblocks on component devices (see FSTYPE column)
```
lsblk --fs
```

Remove labels, illustrated in following command:
```
sudo mdadm --zero-superblock /dev/sda /dev/sdb /dev/sdc
```

Remove or comment out any references to the array in the `/etc/fstab` file.

Remove or comment out any references to the array from file `/etc/mdadm/mdadm.conf`.

Update initramfs
```
sudo upate-initramfs -u
```

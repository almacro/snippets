# Manage RAID arrays with `mdadm`

# Query RAID info

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

# Getting Component Device info

The `Q` option, when used with a component device, will tell you the array it is part of and its role:
```
sudo mdadm -Q /dev/sdc
```

Get more details by using the `-E` or `--examine` options:
```
sudo mdadm -E /dev/sdc
```

# Reading `/proc/mdstat` info

For details about assembled arrays on the server, check the `/proc/mdstat` file.
This is often the best way to get status of active arrays on the system.
```
cat /proc/mdstat
```

# Stop an array

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

# Start an array

Start all arrays defined in the configuration files or `/proc/mdstat` run the command:
```
sudo mdadm --assemble --scan
```

Start a specific array by passing an argument to `mdadm --assemble`, for example:
```
sudo mdadm --assemble /dev/md0
```

This depends on the array as defined in the configuration file.

If no correct definition for the array is in the configuration file, it can still be started by passing in the component devices:
```
sudo mdadm --assemble /dev/md0 /dev/sda /dev/sdb /dev/sdc /dev/sdd
```

After it is assembled the array can be mounted:
```
sudo mount /dev/md0 /mnt/md0
```

This makes the array accessible at the mount point.

# Add a spare device to an array

   Spare devices can be added to any arrays that offer redundancy, such as RAID 1, 5, 6, or 10. The spare will not be actively used by the array unless an active device fails. When this happens, the array will re-sync the data to the spare drive to repair the array to full health. Spares cannot be added to non-redundant arrays (RAID 0) because the array will not survive the failure of a drive.

   To add a spare, pass in the array and the new device to the `mdadm --add` command:
```
sudo mdadm /dev/md0 --add /dev/sde
```
   
   If the array is not in a degraded state, the new device will be added as a spare. If the device is currently degraded, the re-sync operation will immediately begin using the spare to replace the faulty drive.

   After you add a spare, update the configuration file to reflect your new device orientation.

   Remove or comment out the current line that corresponds to your array definition:

   Afterwards, append your current configuration:
```
sudo mdadm --detail --brief /dev/md0 | sudo tee -a /etc/mdadm/mdadm.conf
```

   The new information will be used by the mdadm utility to assemble the array.

# Increase the number of active devices in an array

   An array can grow by increasing the number of active devices within the assembly. The exact procedure depends on the RAID level used.

## With RAID1 or RAID10

   Begin by adding the new device as a spare:
```
sudo mdadm /dev/md0 --add /dev/sde
```

   Find out the number of RAID devices currently in the array:
```
sudo mdadm --detail /dev/md0
```

   Reconfigure the array to have an additional active device. The spare will be used to satisfy the extra drive requirement.
   Remember to replace your target number of RAID devices in this command. This command will increase a RAID 1 with 2 devices to 3. If RAID 10 is used with 4 devices increase it to 5:
```
sudo mdadm --grow --raid-devices=3 /dev/md0
```

   The array will begin to reconfigure with an additional active disk. To view the progress of syncing the data, run the following:
```
cat /proc/mdstat
```

The device can be used as the process completes.

## With RAID5 or RAID6

   Begin by adding the new device as a spare as demonstrated in the last section:
```
sudo mdadm /dev/md0 --add /dev/sde
```
   Find out the current number of RAID devices in the array:
```
sudo mdadm --detail /dev/md0
```

   Output
```
/dev/md0:
        Version : 1.2
  Creation Time : Wed Oct 5 18:38:51 2022
     Raid Level : raid5
     Array Size : 209584128 (199.88 GiB 214.61 GB)
  Used Dev Size : 104792064 (99.94 GiB 107.31 GB)
   Raid Devices : 3
  Total Devices : 4
    Persistence : Superblock is persistent

    . . .
```

   In this example, the array is configured to actively use three devices, and that the total number of devices available to the array is four because of the added spare device.

   Reconfigure the array to have an additional active device. The spare will be used to satisfy the extra drive requirement. When growing a RAID 5 or RAID 6 array, it is important to include an additional option called `--backup-file`. This will point to a location off the array where a backup file containing critical information will be stored:

   Note: The backup file is only used for a very short but critical time during this process, after which it will be deleted automatically. Because the time when this is needed is brief, you will likely never see the file on disk, but in the event that something goes wrong, it can be used to rebuild the array. This post has some additional information if you would like to know more.
```
sudo mdadm --grow --raid-devices=4 --backup-file=/root/md0_grow.bak /dev/md0
```
   The following output indicates that the critical section will be backed up:

```
mdadm: Need to backup 3072K of critical section..
```

   The array will begin to reconfigure with an additional active disk. To view the progress of syncing data, run:
```
cat /proc/mdstat
```

   The device is available for use as this process completes.

   After the reshape is complete, expand the filesystem on the array to utilize the additional space:
```
sudo resize2fs /dev/md0
```

   Your array will now have a filesystem that matches its capacity.

## With RAID0

   RAID 0 arrays cannot have spare drives because there is no chance for a spare to rebuild a damaged RAID 0 array. The new
   device has to be added at the same time that the array is expanded.

# Remove a device from an array

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


# Delete an array

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
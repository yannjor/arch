#!/bin/bash -e
# Lazy script to partition a drive and create filesystems. Also runs pacstrap
# and creates an fstab file.

### Global variables
drive="/dev/sda"

### Start of script

# Partition drive with 512MiB for the boot partition and the rest for root.
sgdisk -o \
    -n 1:0:+512MiB -t 1:ef00 \
    -n 2:0:0 -t 2:8300 \
    $drive

# Create filesystems
boot_partition="${drive}1"
root_partition="${drive}2"
mkfs.fat -F32 $boot_partition
mkfs.ext4 $root_partition

# Mount partitions
mount $root_partition /mnt
mkdir /mnt/boot
mount $boot_partition /mnt/boot

# Pacstrap
pacstrap /mnt base linux linux-firmware

# Generate fstab
genfstab -U /mnt >> /mnt/etc/fstab

echo "Done. You can now run 'arch-chroot /mnt' to change root into the new system."

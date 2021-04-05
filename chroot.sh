#!/bin/bash
# Script that is intended to be run after chrooting into a new system. Installs
# systemd-boot as the boot manager.
# Most commands are from: https://wiki.archlinux.org/index.php/Installation_guide

### Global variables
boot_path="/boot"
root_partition="/dev/sda2"
time_zone="Europe/Helsinki"
locale="en_US.UTF-8 UTF-8"
lang="LANG=en_US.UTF-8"

### Start of script

# Install systemd-boot
[ -d "$boot_path" ] || echo "Boot directory not found, exiting"; exit 1
bootctl install

# Loader configuration
# https://wiki.archlinux.org/index.php/Systemd-boot#Loader_configuration
cat > /boot/loader/loader.conf <<EOF
default arch.conf
timeout 5
console-mode max
editor no
EOF

# Loader entry
root_partition_uuid=$(lsblk -dno PARTUUID "$root_partition")
cat > /boot/loader/entries/arch.conf <<EOF
title   Arch Linux
linux   /vmlinuz-linux
initrd  /initramfs-linux.img
options root=PARTUUID=$root_partition_uuid rw
EOF

# Set root password
echo "Set a new root password"
passwd

# Set time zone
ln -sf /usr/share/zoneinfo/"$time_zone" /etc/localtime
hwclock --systohc

# Set system locale and language
echo "$locale" >> /etc/locale.gen
locale-gen
echo "$lang" > /etc/locale.conf

# Install and enable network manager
pacman -S --noconfirm --needed networkmanager
systemctl enable NetworkManager

# Set hostname
read -p "Enter a hostname: " host
echo "$host" > /etc/hostname

# Set /etc/hosts configuration
cat > /etc/hosts <<EOF
#
# hosts - static table lookup for hostnames
#
127.0.0.1  localhost
127.0.1.1  $host
::1        localhost ip6-localhost ip6-loopback
ff02::1    ip6-allnodes
ff02::2    ip6-allrouters
EOF

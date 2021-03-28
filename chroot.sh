#!/bin/bash
# Script that is intended to be run after chrooting into a new system. Installs
# systemd-boot as the boot manager and copies example loader configurations.
# Most commands are from: https://wiki.archlinux.org/index.php/Installation_guide

### Global variables
boot_path="/boot"
time_zone="Europe/Helsinki"
locale="en_US.UTF-8 UTF-8"
lang="LANG=en_US.UTF-8"

### Start of script

# Install systemd-boot
[ -d "$boot_path" ] || echo "Boot directory not found, exiting"; exit 1
bootctl install
# Copy example configurations
cp /usr/share/systemd/bootctl/loader.conf /boot/loader/
cp /usr/share/systemd/bootctl/arch.conf /boot/loader/entries/

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

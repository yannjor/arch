#!/bin/bash

./dotfiles/scripts/0-preinstall.sh
arch-chroot /mnt /root/dotfiles/scripts/1-setup.sh
arch-chroot /mnt /root/dotfiles/scripts/2-install.sh

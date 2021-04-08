#!/bin/bash
# Creates a user and installs packages from packages.csv. Also sets zsh as
# the default shell for the user.
# Quite rough script, use at own risk!


### Global variables
package_file=$(realpath "packages.csv")


### Functions
function installpkg() {
    echo "Installing package: $1"
    pacman -S --noconfirm --needed "$1" >/dev/null 2>&1 || echo "Failed to install package: $1"
}

function aurinstall() {
    echo "Installing package: $1 from AUR"
    sudo -u "$user" yay -S --noconfirm --needed "$1" >/dev/null 2>&1 || echo "Failed to install package: $1"
}

### Start of script

## Install base packages
printf "\n---Installing base packages---\n"
for pkg in git base-devel zsh; do
    installpkg "$pkg"
done


## Create user
printf "\n"
read -p "Enter a username: " user
useradd -m "$user"
passwd "$user"
usermod -aG wheel,audio,optical,storage,video "$user"
sed -i '/^# %wheel ALL=(ALL) ALL/s/^# //' /etc/sudoers


## Install yay (AUR helper)
printf "\n---Installing yay---\n"
cp "$package_file" /tmp
cd /tmp
sudo -u "$user" git clone https://aur.archlinux.org/yay.git
cd yay
sudo -u "$user" makepkg -si --noconfirm
cd /tmp

## Install NVIDIA drivers if wanted
printf "\n"
read -p "Install NVIDIA drivers? [y/n] " -s -n1 nvidia
[ "$nvidia" != "n" ] && installpkg nvidia && installpkg nvidia-settings
printf "\n"

## Install packages
printf "\n---Installing packages from $package_file---\n"
read -p "Install GNOME? [y/n] " -s -n1 gnome
printf "\n"
# Read csv, skip first line
tail -n +2 "$package_file" | while IFS=, read -r tag pkg desc; do
    # Skip GNOME package if not wanted
    [[ "$tag" = *"GNOME"* && "$gnome" = "n" ]] && continue
    case "$tag" in
    *"AUR"*)
        aurinstall "$pkg"
        ;;
    *)
        installpkg "$pkg"
        ;;
    esac
done

# Enable gdm on startup for GNOME
[ "$gnome" != "n" ] && systemctl enable gdm.service

# Make zsh the default shell
chsh -s /bin/zsh "$user"

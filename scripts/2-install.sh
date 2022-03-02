#!/bin/bash
# Creates a user and installs packages from packages.csv. Also sets zsh as
# the default shell for the user.
# Some stuff is from: https://github.com/LukeSmithxyz/LARBS

### Global variables
package_file="/root/dotfiles/packages.csv"
aur_helper="yay"

### Functions
function installpkg() {
    echo "Installing package: $1 ($2)"
    pacman -S --noconfirm --needed "$1" > /dev/null 2>&1 || echo "Failed to install package: $1"
}

function aurinstall() {
    echo "Installing AUR package: $1 ($2)"
    sudo -u "$user" yay -S --noconfirm --needed "$1" > /dev/null 2>&1 || echo "Failed to install package: $1"
}

### Start of script

## Install base packages
echo -e "\n---Installing base packages---\n"
for pkg in git base-devel zsh; do
    installpkg $pkg
done

## Create user
echo
read -rp "Enter a username: " user
useradd -m "$user"
passwd "$user"
usermod -aG wheel,audio,optical,storage,video "$user"
sed -i '/^# %wheel ALL=(ALL) ALL/s/^# //' /etc/sudoers

## Install AUR helper
echo -e "\n---Installing $aur_helper (AUR helper)---\n"
sudo -u "$user" git clone https://aur.archlinux.org/$aur_helper.git
cd $aur_helper || exit
sudo -u "$user" makepkg -si --noconfirm

## Install NVIDIA drivers if wanted
echo
read -rp "Install NVIDIA drivers? [y/n] " -s -n1 nvidia
[ "$nvidia" != "n" ] && installpkg nvidia && installpkg nvidia-settings
echo

## Install packages
echo -e "\n---Installing packages from $package_file---\n"

read -rp "Install GNOME? [y/n] " -s -n1 gnome
echo
read -rp "Install i3 WM? [y/n] " -s -n1 i3
echo
# Read csv, skip first line
tail -n +2 "$package_file" | while IFS=, read -r tag pkg desc; do
    # Skip GNOME/i3 packages if not wanted
    [[ "$tag" = *"GNOME"* && "$gnome" = "n" ]] && continue
    [[ "$tag" = *"i3"* && "$i3" = "n" ]] && continue
    case "$tag" in
        *"AUR"*)
            aurinstall "$pkg" "$desc"
            ;;
        *)
            installpkg "$pkg" "$desc"
            ;;
    esac
done

# Enable gdm on startup for GNOME
[ "$gnome" != "n" ] && systemctl enable gdm.service

# Make zsh the default shell
chsh -s /bin/zsh "$user"

echo "Done with installation"

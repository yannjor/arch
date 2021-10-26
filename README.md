# dotfiles
Configuration files and installation scripts to set up my Arch Linux
system.

## Install
Boot Arch ISO, then:
```
pacman -Sy git
git clone https://github.com/yannjor/dotfiles.git
./dotfiles/scripts/install.sh
```

Deploy dotfiles with [stow](https://www.gnu.org/software/stow/) e.g.,
```
stow -t ~ alacritty git nvim (...)
```

#!/bin/bash
# Script to symlink my dotfiles

cwd=$(pwd)
dotfiles_path=${cwd%/scripts}

ln -sf $dotfiles_path/.config/nvim/init.vim ~/.config/nvim/init.vim
ln -sfn $dotfiles_path/.config/alacritty ~/.config/alacritty
ln -sfn $dotfiles_path/.config/mpv ~/.config/mpv
ln -sfn $dotfiles_path/.config/gtk-3.0 ~/.config/gtk-3.0
ln -sf $dotfiles_path/.zshrc ~/.zshrc
ln -sf $dotfiles_path/.gitconfig ~/.gitconfig
ln -sf $dotfiles_path/.tmux.conf ~/.tmux.conf

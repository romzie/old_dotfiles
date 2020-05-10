#! /bin/bash

dotfiles_folder=~/.config/dotfiles

# i3
cp ~/.config/regolith/i3/config ${dotfiles_folder}/i3.config

# compton
cp ~/.config/regolith/compton/config ${dotfiles_folder}/compton.config

# polybar
cp -r ~/.config/polybar ${dotfiles_folder}

# ranger
cp ~/.config/ranger/rc.conf ${dotfiles_folder}/ranger.config

# gnome-terminal theme
cp ~/.config/gtk-3.0/gtk.css ${dotfiles_folder}/gtk.css

# rofi
cp ~/.config/rofi/app-launcher.rasi ${dotfiles_folder}/app-launcher.rasi

# Xresources
cp ~/.config/regolith/Xresources ${dotfiles_folder}/regolith.Xresources

# zshrc
cp ~/.zshrc ${dotfiles_folder}/.zshrc

# powerlevel10k
cp ~/.p10k.zsh ${dotfiles_folder}/.p10k.zsh

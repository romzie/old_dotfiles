#! /bin/bash

###
# This is not a script to launch but rather a fully documented guide
# since it requires a few manual steps (for git) and manual restarts
#
# For a VM, mount the Guest Additions ISO and run 'sudo bash autorun.sh'
###

### Regolith config setup file

sudo add-apt-repository ppa:jonathonf/vim

sudo apt update

sudo apt install -y git wget zsh build-essential dkms htop neofetch autojump vim python3-dev cmake

## disable automatic updates
systemctl stop packagekit
systemctl mask packagekit

## setup configs
git clone https://github.com/romzie/dotfiles.git ~/.config/dotfiles
# i3
mkdir -p ~/.config/regolith/i3
cp ~/.config/dotfiles/i3.config ~/.config/regolith/i3/config
# compton
mkdir -p ~/.config/regolith/compton
cp ~/.config/dotfiles/compton.config ~/.config/regolith/compton/config
# i3blocks
mkdir -p ~/.config/regolith/i3xrocks
cp -r ~/.config/dotfiles/i3xrocks.conf.d ~/.config/regolith/i3xrocks/conf.d

## oh-my-zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

## nerd fonts
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.0.0/DejaVuSansMono.zip
unzip DejaVuSansMono.zip
rm -f DejaVuSansMono.zip
fc-cache -fv
cd

## git
git config --global user.email "my.email@here.fr"
git config --global user.name "My Name"

## vim
git clone --depth=1 https://github.com/romzie/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh
cd ~/.vim_runtime
git submodule update --init --recursive
cd ~/.vim_runtime/sources_non_forked/youcompleteme
python3 install.py
cd

# restart session for shell to switch

## terminal prompt powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
cp ~/.config/dotfiles/.p10k.zsh ~/.p10k.zsh

## lsd
wget https://github.com/Peltoche/lsd/releases/download/0.17.0/lsd_0.17.0_amd64.deb
sudo dpkg -i lsd_0.17.0_amd64.deb
rm -f lsd_0.17.0_amd64.deb

# finish shell config customization by replacing the zshrc
cp ~/.config/dotfiles/.zshrc ~/.zshrc

## keybindings
## to replace in /etc/regolith/i3/config
# bindsym $mod+d exec $i3-wm.program.launcher.app
# bindsym $mod+Shift+d exec $i3-wm.program.launcher.cmd
# bindsym $mod+Ctrl+d exec $i3-wm.program.launcher.window
# bindsym $mod+s split toggle
## to add
# bindsym $mod+v split v
# bindsym $mod+b split h
# workspace_auto_back_and_forth yes
# exec --no-startup-id xhost +local:docker

# reboot to finish installation

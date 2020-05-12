#! /bin/bash

###
# This is not a script to launch but rather a fully documented guide
# since it requires a few manual steps (for git) and manual restarts
#
# For a VM, mount the Guest Additions ISO and run 'sudo bash autorun.sh'
# Also run 'sudo adduser $USER vboxsf' to access shared folders
###


### GENERAL APT

sudo add-apt-repository ppa:jonathonf/vim
sudo add-apt-repository ppa:papirus/papirus

sudo apt update

sudo apt install -y git wget zsh build-essential dkms htop neofetch autojump \
    vim python3-dev python3-pip cmake numlockx libnotify-bin ranger highlight \
    papirus-icon-theme net-tools imagemagick feh

pip3 install i3ipc

## disable automatic updates
sudo systemctl stop packagekit
sudo systemctl mask packagekit

## enable verr num on startup
sudo bash -c "echo \"greeter-setup-script=/usr/bin/numlockx on\" >> /usr/share/lightdm/lightdm.conf.d/60-lightdm-gtk-greeter.conf"


### SHELL

## oh-my-zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git $ZSH_CUSTOM/plugins/you-should-use
git clone https://github.com/marlonrichert/zsh-autocomplete.git $ZSH_CUSTOM/plugins/zsh-autocomplete
git clone https://github.com/TamCore/autoupdate-oh-my-zsh-plugins $ZSH_CUSTOM/plugins/autoupdate

## nerd fonts
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.0.0/DejaVuSansMono.zip
unzip DejaVuSansMono.zip
rm -f DejaVuSansMono.zip
fc-cache -fv
cd

## lsd
wget https://github.com/Peltoche/lsd/releases/download/0.17.0/lsd_0.17.0_amd64.deb
sudo dpkg -i lsd_0.17.0_amd64.deb
rm -f lsd_0.17.0_amd64.deb


### DOTFILES

git clone https://github.com/romzie/dotfiles.git ~/.config/dotfiles

# zshrc
cp ~/.config/dotfiles/.zshrc ~/.zshrc

# i3
mkdir -p ~/.config/regolith/i3
cp ~/.config/dotfiles/i3.config ~/.config/regolith/i3/config

# compton
mkdir -p ~/.config/regolith/compton
sudo cp ~/.config/dotfiles/compton.config /etc/regolith/compton/config

# i3blocks
mkdir -p ~/.config/regolith/i3xrocks
cp -r ~/.config/dotfiles/i3xrocks.conf.d ~/.config/regolith/i3xrocks/conf.d

# gnome terminal
mkdir -p ~/.config/gtk-3.0
cp ~/.config/dotfiles/gtk.css ~/.config/gtk-3.0/gtk.css

# Xresources
cp ~/.config/dotfiles/regolith.Xresources ~/.config/regolith/Xresources

# ranger
ranger --copy-config=all
cp ~/.config/dotfiles/ranger.config ~/.config/ranger/rc.conf

# rofi
cp -r ~/.config/dotfiles/rofi ~/.config/rofi

# polybar
cp -r ~/.config/dotfiles/polybar ~/.config/polybar

# powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
cp ~/.config/dotfiles/.p10k.zsh ~/.p10k.zsh

# wallpaper
touch ~/.config/wallpaper.jpg


### OTHER INSTALLATIONS

## polybar (package not available in 20.04)
sudo apt install -y libcairo2-dev libxcb-composite0-dev libxcb-randr0-dev \
    xcb-proto libxcb1-dev libxcb-util0-dev libxcb-icccm4-dev libxcb-ewmh-dev \
    libxcb-image0-dev python3-xcbgen libxcb-xrm-dev libxcb-cursor-dev \
    libasound2-dev libnl-genl-3-dev libjsoncpp-dev
cd ~/.config
wget https://github.com/polybar/polybar/releases/download/3.4.2/polybar-3.4.2.tar
tar -xvf polybar-3.4.2.tar
mv polybar polybar-source
cd polybar-source
mkdir build
cd build
cmake ..
make -j$(nproc)
sudo make install
cd ~/.config
rm -f polybar-3.4.2.tar

## plymouth theme
wget https://github.com/adi1090x/files/raw/master/plymouth-themes/themes/pack_1/cuts_alt.tar.gz
tar -xzvf cuts_alt.tar.gz
sudo mv cuts_alt /usr/share/plymouth/themes/cuts_alt
sudo update-alternatives --install /usr/share/plymouth/themes/default.plymouth default.plymouth /usr/share/plymouth/themes/cuts_alt/cuts_alt.plymouth 100
sudo update-initramfs -u
rm -f cuts_alt.tar.gz

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

## hapycolor
pip3 install colormath scipy imgur_downloader
git clone https://github.com/rvdz/hapycolor ~/.config/hapycolor
mkdir -p ~/.config/hapycolor_palettes

### reboot to finish installation

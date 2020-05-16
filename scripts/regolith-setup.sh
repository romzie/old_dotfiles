#! /bin/bash


### SHELL

## oh-my-zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions.git /home/$USER/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /home/$USER/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git /home/$USER/.oh-my-zsh/custom/plugins/you-should-use
git clone https://github.com/marlonrichert/zsh-autocomplete.git /home/$USER/.oh-my-zsh/custom/plugins/zsh-autocomplete
git clone https://github.com/TamCore/autoupdate-oh-my-zsh-plugins.git /home/$USER/.oh-my-zsh/custom/plugins/autoupdate
git clone https://github.com/zpm-zsh/title.git /home/$USER/.oh-my-zsh/custom/plugins/title


### DOTFILES

#git clone https://github.com/romzie/dotfiles.git ~/.config/dotfiles

# zshrc
cp ~/.config/dotfiles/.zshrc ~/.zshrc

# i3
mkdir -p ~/.config/regolith/i3
cp ~/.config/dotfiles/i3.config ~/.config/regolith/i3/config

# compton
mkdir -p ~/.config/regolith/compton
sudo cp ~/.config/dotfiles/compton.config /etc/regolith/compton/config

# gnome terminal
mkdir -p ~/.config/gtk-3.0
cp ~/.config/dotfiles/gtk.css ~/.config/gtk-3.0/gtk.css

# Xresources
cp ~/.config/dotfiles/regolith.Xresources ~/.config/regolith/Xresources

# ranger
ranger --copy-config=all
cp ~/.config/dotfiles/ranger.config ~/.config/ranger/rc.conf

# rofi
cp -r ~/.config/dotfiles/rofi ~/.config

# polybar
cp -r ~/.config/dotfiles/polybar ~/.config

# powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /home/$USER/.oh-my-zsh/custom/themes/powerlevel10k
cp ~/.config/dotfiles/.p10k.zsh ~/.p10k.zsh

# default theme
cp ~/.config/dotfiles/default_theme/default.jpg ~/.config/wallpaper.jpg
cp ~/.config/dotfiles/default_theme/default.rasi ~/.config/rofi/hapycolor.rasi
mkdir -p ~/.config/hapycolor_palettes
cp ~/.config/dotfiles/default_theme/default.Xresources ~/.config/hapycolor_palettes/.hapycolor.Xresources


### OTHER THEME RELATED STUFF

## plymouth theme
wget https://github.com/adi1090x/files/raw/master/plymouth-themes/themes/pack_1/cuts_alt.tar.gz
tar -xzvf cuts_alt.tar.gz
sudo mv cuts_alt /usr/share/plymouth/themes/cuts_alt
sudo update-alternatives --install /usr/share/plymouth/themes/default.plymouth default.plymouth /usr/share/plymouth/themes/cuts_alt/cuts_alt.plymouth 100
sudo update-initramfs -u
rm -f cuts_alt.tar.gz

## vim
git clone --depth=1 https://github.com/romzie/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh
cd ~/.vim_runtime
git submodule update --init --recursive
cd ~/.vim_runtime/sources_non_forked/youcompleteme
python3 install.py
cd

## hapycolor
git clone https://github.com/rvdz/hapycolor ~/.config/hapycolor

## lightdm greeter
#sudo apt install -y python3-whither liglightdm-gobject-dev python3-gi
#git clone https://github.com/Antergos/web-greeter.git ~/.config/greeter
#cd ~/.config/greeter
#sudo make install
#sudo sh -c 'echo "greater-session=lightdm-webkit2-greeter" >> /etc/lightdm/lightdm.conf'
#cd

## lightdm greeter theme
#git clone https://github.com/NoiSek/Aether.git ~/.config/Aether
#sudo mkdir -p /usr/share/lightdm-webkit/themes
#sudo cp -r ~/.config/Aether /usr/share/lightdm-webkit/themes


### refresh theme
regolith-look refresh


### reboot to finish installation

reboot


### following setup is optional

## git
#git config --global user.email "my.email@here.fr"
#git config --global user.name "My Name"

###

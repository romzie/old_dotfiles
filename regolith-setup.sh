#! /bin/bash

###
# This is not a script to launch but rather a fully documented guide
# since it requires a few manual steps (for git) and manual restarts
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
cp ~/.config/dotfiles/.i3config ~/.config/regolith/i3/config

## oh-my-zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sed -i 's/^plugins=(.*)/plugins=(\n  git\n  python\n  pip\n  autojump\n  common-aliases\n  zsh-autosuggestions\n  zsh-syntax-highlighting\n  command-not-found\n  cp\n  history\n  catimg\n  docker\n  extract\n  colorize\n  npm\n  sudo\n)/g' ~/.zshrc
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
#cd ~/.vim_runtime/sources_non_forked
#git clone https://github.com/yuttie/comfortable-motion.vim
#git clone https://github.com/xuyuanp/nerdtree-git-plugin
#git clone https://github.com/unblevable/quick-scope
#git clone https://github.com/nathanaelkane/vim-indent-guides
#git clone https://github.com/jamshedvesuna/vim-markdown-preview
#git clone https://github.com/sickill/vim-pasta
#git clone https://github.com/valloric/youcompleteme
cd ~/.vim_runtime/sources_non_forked/youcompleteme
git submodule update --init --recursive
python3 install.py
cd

# restart terminal for fonts to load

## terminal prompt powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
sed -i 's/ZSH_THEME=.*$/ZSH_THEME="powerlevel10k\/powerlevel10k"/g' ~/.zshrc

# lsd
wget https://github.com/Peltoche/lsd/releases/download/0.17.0/lsd_0.17.0_amd64.deb
sudo dpkg -i lsd_0.17.0_amd64.deb
rm -f lsd_0.17.0_amd64.deb
echo "alias ls='lsd'" >> ~/.zshrc # or add alias manually

# restart session to finish installation

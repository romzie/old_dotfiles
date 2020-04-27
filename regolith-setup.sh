#! /bin/bash

### Regolith config setup file

sudo add-apt-repository ppa:jonathonf/vim

sudo apt update

sudo apt install -y git wget zsh build-essential dkms htop neofetch autojump vim

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

# restart terminal

## terminal prompt powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
sed -i 's/ZSH_THEME=.*$/ZSH_THEME="powerlevel10k\/powerlevel10k"/g' ~/.zshrc

# restart terminal

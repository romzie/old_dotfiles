#! /bin/bash

cd

### ppas
sudo apt update

### basic configuration
sudo apt install -y git vim zsh wget build-essential htop neofetch
mkdir -p ~/Config
chsh -s $(which zsh)
# restart session

### system requirements
### i3-gaps
sudo apt install -y gcc make dh-autoreconf libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev xcb libxcb1-dev \
    libxcb-icccm4-dev libyajl-dev libev-dev libxcb-xkb-dev libxcb-cursor-dev libxkbcommon-dev libxcb-xinerama0-dev \
    libxkbcommon-x11-dev libstartup-notification0-dev libxcb-randr0-dev libxcb-xrm0 libxcb-xrm-dev libxcb-shape0 libxcb-shape0-dev
### polybar
sudo apt install -y cmake cmake-data pkg-config python3-sphinx libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev \
    libxcb-composite0-dev python-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-xkb-dev \
    libxcb-xrm-dev libxcb-cursor-dev libasound2-dev libpulse-dev i3-wm libjsoncpp-dev libmpdclient-dev libcurl4-openssl-dev \
    libnl-genl-3-dev


### INSTALLATION

### oh-my-zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sudo apt install -y autojump
sed -i 's/^plugins=(.*)/plugins=(\n  git\n  python\n  pip\n  autojump\n  common-aliases\n  zsh-autosuggestions\n  zsh-syntax-highlighting\n  command-not-found\n  cp\n  history\n  catimg\n  docker\n  extract\n  colorize\n  npm\n  sudo\n)/g' ~/.zshrc
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
# restart terminal

### i3wm
sudo apt install -y i3

### i3-gaps
cd ~/Config
git clone --depth 1 https://www.github.com/Airblader/i3 i3-gaps
cd i3-gaps
autoreconf --force --install
rm -rf build/
mkdir -p build && cd build/
../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
make
sudo make install
cd

### rofi
sudo apt install -y rofi

### polybar
cd ~/Config
git clone --depth 1 --branch 3.4 --recursive https://github.com/polybar/polybar.git
cd polybar
mkdir -p build && cd build
cmake ..
make -j$(nproc)
sudo make install
cd

### polybar theme
cd ~/Config
git clone --depth 1 https://github.com/adi1090x/polybar-themes.git
mkdir -p ~/.config/polybar/
cp -r polybar-themes/polybar-3/* ~/.config/polybar/
echo "exec --no-startup-id ~/.config/polybar/launch.sh" >> ~/.config/i3/config
cd

### nerd fonts
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.0.0/DejaVuSansMono.zip
unzip DejaVuSansMono.zip
rm -f DejaVuSansMono.zip
fc-cache -fv
cd
# restart terminal

### PowerLevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
sed -i 's/ZSH_THEME=.*$/ZSH_THEME="powerlevel10k\/powerlevel10k"/g' ~/.zshrc
# restart terminal

### Chrome
cd ~/Downloads
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y ./google-chrome-stable_current_amd64.deb
rm -f google-chrome-stable_current_amd64.deb
cd

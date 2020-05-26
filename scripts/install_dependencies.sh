#! /bin/bash


### APT

sudo add-apt-repository ppa:jonathonf/vim -y
sudo add-apt-repository ppa:papirus/papirus -y

sudo apt update

sudo apt install -y git wget zsh build-essential dkms htop neofetch autojump \
    vim python3-dev python3-pip cmake numlockx libnotify-bin ranger highlight \
    papirus-icon-theme net-tools imagemagick feh mutter-common curl

pip3 install i3ipc

## disable automatic updates
sudo systemctl stop packagekit
sudo systemctl mask packagekit

## enable verr num on startup
sudo bash -c "echo \"greeter-setup-script=/usr/bin/numlockx on\" >> /usr/share/lightdm/lightdm.conf.d/60-lightdm-gtk-greeter.conf"

## polybar (package not available in 20.04)
sudo apt install -y libcairo2-dev libxcb-composite0-dev libxcb-randr0-dev \
    xcb-proto libxcb1-dev libxcb-util0-dev libxcb-icccm4-dev libxcb-ewmh-dev \
    libxcb-image0-dev python3-xcbgen libxcb-xrm-dev libxcb-cursor-dev \
    libasound2-dev libnl-genl-3-dev libjsoncpp-dev
wget https://github.com/polybar/polybar/releases/download/3.4.2/polybar-3.4.2.tar
tar -xvf polybar-3.4.2.tar
rm -f polybar-3.4.2.tar
mv polybar ~/.config/polybar-source
cd ~/.config/polybar-source
mkdir build
cd build
cmake ..
make -j$(nproc)
sudo make install
cd

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

## hapycolor
pip3 install colormath scipy imgur_downloader


### OH MY ZSH

sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

###

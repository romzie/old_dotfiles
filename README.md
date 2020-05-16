# romzie's dotfiles

I present to you my personnal dotfiles.

OS: Ubuntu 20.04
DE: Regolith 1.4
WM: i3-gaps
Terminal: gnome-terminal

## Pre-installation steps from VirtualBox VM on Windows 10

Mount the Guest Additions ISO to access all screen resolutions and follow the
2 next steps :
`sudo apt install -y build-essential dkms`
`sudo bash /media/$USER/vbox_mounted_device/autorun.sh` 

To allow user to access shared folders:
`sudo adduser $USER vboxsf`

## Installation

run `sudo apt install -y git`

then `git clone https://github.com/romzie/dotfiles.git ~/.config/dotfiles`

then install dependencies with `sudo ~/.config/dotfiles/scripts/install_dependencies.sh`

finally my theme `sudo ~/.config/dotfiles/scripts/install_themes.sh`

# Bug fixes

If gnome-control-center fails to launch with error `Settings schema org.gnome.mutter is not installed`,
it is a known issue (see https://bugs.launchpad.net/ubuntu/+source/gnome-control-center/+bug/1875243).
Just do `sudo apt install mutter-common` to solve this.

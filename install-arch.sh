sudo pacman -S --noconfirm base-devel zsh git neovim python-neovim xclip xsel wget cmake diff-so-fancy keychain the_silver_searcher ttf-liberation xdg-utils awesome unclutter compton xautolock rofi network-manager-applet rxvt-unicode rxvt-unicode-terminfo rlwrap vicious firefox alsa-utils

git submodule update --init --recursive

cd vim/bundle/youcompleteme
./install.py
cd ../../..

wget https://github.com/Jguer/yay/releases/download/v2.219/yay_2.219_x86_64.tar.gz
tar xfvz yay_2.219_x86_64.tar.gz
cd yay_2.219_x86_64
sudo ./yay -S yay
rm -r yay_*

yay -S --noconfirm google-chrome betterlockscreen-git ruby-neovim brightnessctl


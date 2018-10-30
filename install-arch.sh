sudo pacman -S --noconfirm base-devel zsh git neovim python-neovim xclip xsel wget cmake diff-so-fancy keychain the_silver_searcher ttf-liberation xdg-utils awesome unclutter compton xautolock rofi network-manager-applet rxvt-unicode rxvt-unicode-terminfo rlwrap vicious firefox alsa-utils

git submodule update --init --recursive

cd vim/bundle/youcompleteme
./install.py
cd ../../..

wget https://github.com/Jguer/yay/releases/download/v8.1173.0/yay_8.1173.0_x86_64.tar.gz -O yay.tar.gz
tar xfvz yay.tar.gz
cd yay_8.1173.0_x86_64
./yay -S yay
cd ..
rm -r yay*

yay -S --noconfirm google-chrome betterlockscreen-git ruby-neovim brightnessctl


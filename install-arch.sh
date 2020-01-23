sudo pacman -S --noconfirm base-devel zsh git neovim python-neovim xclip xsel wget cmake diff-so-fancy keychain the_silver_searcher ttf-liberation xdg-utils awesome unclutter xautolock rofi network-manager-applet rxvt-unicode rxvt-unicode-terminfo rlwrap vicious firefox alsa-utils

git submodule update --init --recursive

wget https://github.com/Jguer/yay/releases/download/v9.4.0/yay_9.4.0_x86_64.tar.gz
tar xfvz yay.tar.gz
cd yay_9.4.0_x86_64
./yay -S yay
cd ..
rm -r yay*

yay -S --noconfirm google-chrome betterlockscreen-git ruby-neovim brightnessctl
npm install -g neovim
gem install --user neovim

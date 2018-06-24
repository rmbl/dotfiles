sudo pacman -S base-devel zsh git neovim python-neovim xclip xsel wget cmake diff-so-fancy keychain the_silver_searcher

git submodule update --init --recursive

cd vim/bundle/youcompleteme
./install.py
cd ../../..

wget https://github.com/Jguer/yay/releases/download/v2.219/yay_2.219_x86_64.tar.gz
tar xfvz yay_2.219_x86_64.tar.gz
cd yay_2.219_x86_64
sudo ./yay -S yay
rm -r yay_*

yay -S --noconfirm google-chrome ttf-liberation xdg-utils

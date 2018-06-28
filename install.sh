#!/bin/sh

echo "      _       _    __ _ _             "
echo "     | |     | |  / _(_) |            "
echo "   __| | ___ | |_| |_ _| | ___  ___   "
echo "  / _\` |/ _ \| __|  _| | |/ _ \/ __|  "
echo " | (_| | (_) | |_| | | | |  __/\__ \  "
echo "(_)__,_|\___/ \__|_| |_|_|\___||___/  "
echo "______________________________________________"
echo
echo "Installing dotfiles into user's home directory ..."

lnif() {
    if [ -e $2 ]; then
        if [ ! -L $2 ]; then
            echo "WARNING: $2 exists but is not a symlink."
        fi
    else
        ln -s $1 $2
    fi
}

# Config files
lnif $PWD/bashrc $HOME/.bashrc
lnif $PWD/dircolors $HOME/.dircolors
lnif $PWD/gemrc $HOME/.gemrc
lnif $PWD/gitconfig $HOME/.gitconfig
lnif $PWD/gitignore_global $HOME/.gitignore_global
lnif $PWD/irbrc $HOME/.irbrc
lnif $PWD/tmux.conf $HOME/.tmux.conf
lnif $PWD/tmux.theme.conf $HOME/.tmux.theme.conf
lnif $PWD/vimrc $HOME/.vimrc
lnif $PWD/Xresources $HOME/.Xresources
lnif $PWD/zshrc $HOME/.zshrc

# .config directories
mkdir -p $HOME/.config
lnif $PWD/awesome $HOME/.config/awesome
lnif $PWD/nvim $HOME/.config/nvim
lnif $PWD/compton.conf $HOME/.config/compton.conf

# Directories
lnif $PWD/bin $HOME/.bin
lnif $PWD/vim $HOME/.vim
lnif $PWD/zsh $HOME/.zsh

# Fonts
mkdir -p $HOME/.local/share/fonts
lnif $PWD/fonts/truetype $HOME/.local/share/fonts/truetype
lnif $PWD/fonts/type1 $HOME/.local/share/fonts/type1

echo ""
echo "Updating font cache ..."
fc-cache -vf $HOME/.local/share/fonts

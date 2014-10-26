#!/bin/sh

echo "      _       _    __ _ _             "
echo "     | |     | |  / _(_) |            "
echo "   __| | ___ | |_| |_ _| | ___  ___   "
echo "  / _\` |/ _ \| __|  _| | |/ _ \/ __|  "
echo " | (_| | (_) | |_| | | | |  __/\__ \  "
echo "(_)__,_|\___/ \__|_| |_|_|\___||___/  "
echo "______________________________________________"
echo
echo "Installing dotfiles into user's home directory"

for name in *; do
    target="$HOME/.$name"
    if [ -e "$target" ]; then
        if [ ! -L "$target" ]; then
            echo "WARNING: $target exists but is not a symlink."
        fi
    else
        if [ "$name" != 'install.sh' ] && [ "$name" != 'README.md' ] && [ "$name" != 'osx.sh' ]; then
            echo "Creating $target"
            ln -s "$PWD/$name" "$target"
        fi
    fi
done

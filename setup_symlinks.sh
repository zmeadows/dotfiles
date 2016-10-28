#!/bin/bash

echo "SETTING UP DOTFILES ON: $HOSTNAME\n"

if [[ ! -d ~/.oh-my-zsh ]]; then
    echo "INSTALLING OH-MY-ZSH"
    sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
fi

dir=~/dotfiles                           # dotfiles directory
olddir=~/dotfiles_old                    # old dotfiles backup directory
files="vimrc" # list of files/folders to symlink in homedir

if [[ $HOSTNAME == *"macbook"* ]]; then
elif [[ $HOSTNAME == *"lxplus"* ]]; then
elif [[ $HOSTNAME == *"titan"* ]]; then
else
    echo "UNRECOGNIZED HOSTNAME: $HOSTNAME"
    echo "EXITING..."
    exit 1
fi


#!/bin/bash

echo "SETTING UP DOTFILES ON: $HOSTNAME\n"

if [[ ! -d ~/.oh-my-zsh ]]; then
    echo "INSTALLING OH-MY-ZSH"
    sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
fi

dir=~/dotfiles          # dotfiles directory
olddir=~/dotfiles_old   # old dotfiles backup directory
files="vimrc tmux.conf zshrc" # list of files/folders to symlink in homedir

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

if [[ $HOSTNAME == *"macbook"* ]]; then
    cp zshrc_macbook zshrc
elif [[ $HOSTNAME == *"lxplus"* ]]; then
    dir=/afs/cern.ch/user/z/zmeadows/private/dotfiles
    olddir=/afs/cern.ch/user/z/zmeadows/private/dotfiles_old
    cp zshrc_lxplus zshrc
elif [[ $HOSTNAME == *"titan"* ]]; then
    files="$files zshrc_titan"
    cp zshrc_titan zshrc
else
    echo "UNRECOGNIZED HOSTNAME: $HOSTNAME"
    echo "EXITING..."
    exit 1
fi

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done

rm zshrc

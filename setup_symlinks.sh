#!/bin/bash

echo "SETTING UP DOTFILES ON: $HOSTNAME\n"

dir=~/dotfiles          # dotfiles directory
olddir=~/dotfiles_old   # old dotfiles backup directory
files="emacs vimrc tmux.conf zshrc.local" # list of files/folders to symlink in homedir

if [[ $HOSTNAME == *"lxplus"* ]]; then
    dir=/afs/cern.ch/user/z/zmeadows/private/dotfiles
    olddir=/afs/cern.ch/user/z/zmeadows/private/dotfiles_old
fi

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

cd $dir

date_str=$(date +"%m%d%Y:%T")
for file in $files; do

    old_file=~/.$file
    backup_file="$olddir/$file.$date_str"
    mv $old_file $backup_file

    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done

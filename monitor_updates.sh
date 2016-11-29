#!/bin/sh

dir=$HOME/dotfiles      
if [[ $HOSTNAME == *"lxplus"* ]]; then
    dir=/afs/cern.ch/user/z/zmeadows/private/dotfiles
fi

cd $dir
git fetch origin > /dev/null 2>&1
git status > /dev/null 2>&1

git diff --quiet origin/master
if [ $? -ne 0 ]; then
    echo "###############"
    echo "### WARNING ###"
    echo "###############"

    echo "dotfiles in $dir NOT in sync with remote github repository!"
fi

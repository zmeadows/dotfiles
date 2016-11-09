#!/bin/sh

dir=$HOME/dotfiles      
if [[ $HOSTNAME == *"lxplus"* ]]; then
    dir=/afs/cern.ch/user/z/zmeadows/private/dotfiles
fi

cd $dir
git status > /dev/null 2>&1

git diff --quiet origin/master..HEAD
if [ $? -ne 0 ]; then
    echo "NOT in sync with github dotfiles!"
else
    echo "in sync with github dotfiles."
fi

#!/bin/sh

git diff-index --quiet HEAD --
if [ $? -ne 0 ]; then
    echo "NOT in sync with github dotfiles!"
else
    echo "in sync with github dotfiles."
fi

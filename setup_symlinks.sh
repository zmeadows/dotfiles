#!/bin/bash

echo $HOSTNAME



if [[ $HOSTNAME == *"macbook"* ]]
then
    echo "on macbook";
fi

if [[ $HOSTNAME == *"lxplus"* ]]
then
    echo "on lxplus";
fi

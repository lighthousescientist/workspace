#!/bin/bash

#filetests.sh

if [ -e "/etc/resolv.conf" ]
then
    echo "The /etc/resolv.conf file exists"
else
    echo "The /etc/resolv.conf file aint there"
fi

echo

if [ -r "/etc/shadow" ]
then
    echo "I can read /etc/shadow"
else
    echo "I cannot read /etc/shadow"
    exit 1
fi


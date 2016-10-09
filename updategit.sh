#!/bin/bash

#this script saves me from remembering git commands

#this would be better than blindly using $1
#should at least be checking if $1 has anything in it
#read -p "Update message? " message

chmod u+x ~/workspace/lab1/*.sh
chmod u+x ~/workspace/lab2/*.sh
chmod u+x ~/workspace/lab3/*.sh
chmod u+x ~/workspace/lab4/*.sh

cd ~/workspace/bin/
ln -s ../lab1/*.sh ./
ln -s ../lab2/*.sh ./
ln -s ../lab3/*.sh ./
ln -s ../lab4/*.sh ./
ln -s ../*.sh ./

git add -A
git commit -m "$1"
git push origin master


#!/bin/bash

#this script saves me from remembering git commands

#this would be better than blindly using $1
#should at least be checking if $1 has anything in it
#read -p "Update message? " message

git add -A
git commit -m "$1"
git push origin master


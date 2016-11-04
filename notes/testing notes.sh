#!/bin/bash

#is this thing a directory?
[ -d /etc ] && echo this is a directory
[ -d /etb ] || echo this is not a directory

#more extended tests
#[[ ]]


echo $?
[ $? = 0 ] && echo handle error

read -p "This is an example prompt" myvar

#-v / -n means something in var
#-z means empty var
#numbertesting
#-eq -ne -lt -gt -le -ge

#unary tests (one thing at a time)
#-s (is file empty or is there something in it?)

#binary testing (working with two things)
#-nt (newer)
#-ot (older than)


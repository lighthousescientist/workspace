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

We can do unary tests for file existence (-e), type (-f,-d,-h,-p,-b,-c,-S), permissions (-r,-w,-x,-k,-u), ownership (-O,-G), size (-s), modification (-N), and whether a file is an open terminal device (-t fd)
We can do binary tests on files based on their dates (-nt, -ot), and determine if two filenames are hard linked (-ef)
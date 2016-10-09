#!/bin/bash
#Lab 1 - Step 6
#"lists all the setuid and setgid regular files in the /usr directory tree using find"

#another way for setuid
#find /usr -xdev \( -perm -4000 \) -type f -print0 | xargs -0 ls -l

#another way for setuid
echo "SETUID Files in /usr"
echo "--------------------"
find /usr -type f -perm -4000 -ls

#find setgid
echo
echo "SETGID Files in /usr"
echo "--------------------"
find /usr -xdev \( -perm -2000 \) -type f -print0 | xargs -0 ls -l

#don't use -6000 because that looks for BOTH as a condition

#setuid - 's' no matter who runs program, sets uid to owner of program (dangerous!)  
#!/bin/bash
#Lab 1 - Step 7
#"display how many regular files there are in the Pictures dir & how much disk space used"
#"show the sizes of the 3 largest files in Pictures"

#lab4
#Modify picstats.sh to accept a help option to display command help, a directory on the 
#command line to search for pictures and a count of how many of the biggest files to display 
#(-c or --count #). Default to ~/Pictures and the biggest 3 files if the user doesn't give 
#parameters for those on the command line. If any errors occur, use your error-message 
#function to display them. Use a function to display command syntax help when necessary.

#Dennis Method
#how many
echo -n "In the ~/lab4Pictures directory, there are "
find ~/workspace/lab4/lab4Pictures -type f | wc -l
echo "files."

#how much space
echo
echo -n "The pictures directory uses "
du -sh ~/workspace/lab4/lab4Pictures | awk '{print $1}'

echo
echo "The three largest files in the directory are:"
echo "============================================="
du -h ~/workspace/lab4/lab4Pictures/* | sort -h | tail -3

#My Method
#display how many
#ls ~/workspace/bin/Pictures | wc -l

#show 3 largest
#ls -go --block-size=KB ~/workspace/bash/lab1/Pictures | sort -nr | head -4

#show all
#ls -go --block-size=KB ~/workspace/bash/lab1/Pictures | sort -nr

echo

#echo "Total Files:" + ls ~/workspace/bin/Pictures | wc -l

#echo "Top 3 File Sizes"
#ls -go --block-size=KB ~/workspace/bin/Pictures | sort -nr | head -3

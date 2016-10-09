#!/bin/bash
#Lab 1 - Step 7
#"display how many regular files there are in the Pictures dir & how much disk space used"
#"show the sizes of the 3 largest files in Pictures"

#Dennis Method
#how many
echo -n "In the ~/Pictures directory, there are "
find ~/workspace/bash/lab1/Pictures -type f | wc -l
echo "files."

#how much space
echo
echo -n "The pictures directory uses "
du -sh ~/workspace/bash/lab1/Pictures | awk '{print $1}'

echo
echo "The three largest files in the directory are:"
echo "============================================="
du -h ~/workspace/bash/lab1/Pictures/* | sort -h | tail -3

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

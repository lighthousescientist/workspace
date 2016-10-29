#!/bin/bash

read count
if [[ "$count" -eq "10" || "$count" -eq "6" ]]; then
exit 1
elif [[ "$count" -gt "10" ]]; then
echo "too high"
elif [[ "$count" -lt "6" ]]; then
echo "too low"
exit 2
fi

#for ((initial expression; text expression; loop expression); do

#this or that
#if ["$guess" -eq "10" || "$guess" -eq "6"]

#not valid
#else
#exit
#fi


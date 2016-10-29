#!/bin/bash

# This script will display how many regular files there are in the user-specified directory
#   and how much disk space they use. It will also show the sizes
#   and names of the user-specified (default is 3) largest files in that directory.

### Variables definitions
declare -i numberOfFilesToShow # numberOfFilesToShow is the number of files to show
numberOfFilesToShow=3 # our default count of files to show is 3
declare -i filecount # this variable will hold our count of regular files
 # default directory to work in is our Pictures directory in our home directory
directory=~/Pictures

### MAIN

## Process our command line
# allow directory to be specified and filecount to be specified
# only allow one directory name on the command line
alreadyGotADirectory=no
while [ $# -gt 0 ]; do
    case "$1" in
        -h )
            echo "Usage: $0 [-h] [-c #] [directory]"
            exit 0
            ;;
        -c )
            if [[ "$2" =~ ^[1-9][0-9]* ]]; then
                numberOfFilesToShow=$2
                shift
            else
                echo "Usage: $0 [-h] [-c #] [directory]" >&2
                echo "-c option requires a count" >&2
                exit 1
            fi
            ;;
        * )
            if [ $alreadyGotADirectory = "no" ]; then
                directory=$1
                alreadyGotADirectory=yes
            else
                echo "Usage: $0 [-h] [-c #] [directory]" >&2
                echo "I don't understand $1" >&2
                exit 1
            fi
            ;;
    esac
    shift
done

if [ ! -d "$directory" ]; then
    echo "No such directory: $directory" >&2
    exit 1
fi


filecount=`find "$directory" -type f | wc -l`
echo "In the $directory directory, there are $filecount files."

totalspaceused=`du -sh "$directory" | awk '{print $1}'`
echo "The $directory directory uses $totalspaceused"

echo "The $numberOfFilesToShow largest files in the $directory directory are:"
echo "===================================================="
du -h "$directory"/* | sort -h | tail -$numberOfFilesToShow
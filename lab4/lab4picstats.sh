#!/bin/bash

#lab4
#Modify picstats.sh to accept a help option to display command help, a directory on the 
#command line to search for pictures and a count of how many of the biggest files to display 
#(-c or --count #). Default to ~/Pictures and the biggest user-specified 
#files if the user doesn't give 
#parameters for those on the command line. If any errors occur, use your error-message 
#function to display them. Use a function to display command syntax help when necessary.

### Variable definitions
declare -i count #count is the number of files to show, default of 0
count=3 #default count of files to show is 3
directory=~/workspace/lab4/lab4Pictures #default picture directory
declare -i filecount
getdir=no
while [ $# -gt 0 ]; do
	case "$1" in
	-h )
		echo "Usage: $0 [-h] [-f #] [directory]"
		exit 0
		;;
	-f )
    if [[ "$2" =~ ^[1-9][0-9]*$ ]]; then #could be as many digits as the user wants
      filecount=$2
      #Need shift for EACH addition item to be processed
      shift
    else
      echo "-f requires a count" >&2
      echo "Usage: $0 [-h] [-f #] [directory]" #remind user of usage
      exit 1
    fi
    ;;
	* )
	    if [[ $getdir = "no" ]]; then
	        directory=$1
	        $getdir = "yes"
	    else
	        echo "Usage: $0 [-h] [-f #] [directory]" #remind user of usage
	        echo "What is $1?" >&2
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
### MAIN
filecount=`find "$directory" -type f | wc -l`
echo "In the $directory directory, there are $filecount files."

totalspaceused=`du -sh "$directory" | awk '{print $1}'`


#how much space
echo
echo -n "The pictures directory uses "
du -sh "$directory" | awk '{print $1}'

echo
echo "The three largest files in the directory are:"
echo "============================================="
du -h "$directory"/* | sort -h | tail -3

#My Method
#display how many
#ls ~/workspace/bin/Pictures | wc -l

#show 3 largest
#ls -go --block-size=KB ~/workspace/bash/lab1/Pictures | sort -nr | head -4

#show all
#ls -go --block-size=KB ~/workspace/bash/lab1/Pictures | sort -nr

#echo "Total Files:" + ls ~/workspace/bin/Pictures | wc -l

#echo "Top 3 File Sizes"
#ls -go --block-size=KB ~/workspace/bin/Pictures | sort -nr | head -3

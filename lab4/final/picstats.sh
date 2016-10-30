#!/bin/bash
#William McArthur 200324001

# -accept a help option to display command help 
# -accept a directory on the command line to search for pictures
# -accept a count of how many of the biggest files to display (-c or --count #)
# -Default to ~/Pictures and the biggest 3 files 
# -If any errors occur, use your error-message function
# -Use a function to display command syntax help 

### These are my functions

## This function shows help information
function showUsage {
  #$0 will be the name of the script
  echo "Usage: $0 [-h] [-c #] [directory]"
}
## This function gives an error message
function error-message {
 #>&1 - redirect output to stdout
 #$@ is all positional parameters
 #this allows for more specific error messages
 echo "(!)ERROR(!): $@" >&1
}



### These are my variables
declare -i show #how many files to show
declare -i count #how many files are in directory
show=3 #if user does not specify, show top 3 files by default
default=~/Pictures #if no directory specified, use ~/Pictures

### MAIN

## Process our command line
# allow directory to be specified and filecount to be specified
# only allow one directory name on the command line

#setting directory to false by default will use the default directory ~/Pictures
#if no directory is entered as an argument
directory=false
#testing for arguments with case
while [ $# -gt 0 ]; do
    case "$1" in
        #help
        -h )
            showUsage
            exit 0
            ;;
        #how many files to show
        -c )
            #checking for integer
            if [[ "$2" =~ ^[1-9][0-9]* ]]; then
                show=$2
                shift
            else
                echo "Usage: $0 [-h] [-c #] [directory]" >&2
                error-message "-c option requires a count"
                exit 1
            fi
            ;;
        * ) #use the default directory
            if [ $directory = "false" ]; then
                default=$1
                directory=true
            else
            #this will handle all other nonsense entered
                echo "Usage: $0 [-h] [-c #] [directory]" >&2
                error-message "$1 does not make sense"
                exit 1
            fi
            ;;
    esac
    shift
done
#if there is no directory called such and such
if [ ! -d "$default" ]; then
    #tell the user there is no directory and exit
    error-message "No such directory: $default"
    exit 1
fi

#use find to make a list of files and trunk to wc to count lines
count=`find "$default" -type f | wc -l`
#print how many files there are in the directory
echo "In the $default directory, there are $count files."
#using du, calculate how large the dir is in human-readable format
totalspaceused=`du -sh "$default" | awk '{print $1}'`
echo "The $default directory uses $totalspaceused"
#print a list of the largest files
echo "The $show largest files in the $default directory are:"
echo "===================================================="
#using du, list human-readable sizes and sort from smallest to largest
#show last x entries using tail and the var "show", or the top largest files
du -h "$default"/* | sort -h | tail -$show
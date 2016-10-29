#!/bin/bash
##Modify rolldice.sh to accept a count of dice and a number of sides as command 
##line options, only asking the user for those numbers if they didn't give them 
##on the command line. Also accept a help option (-h or --help) that shows 
##command syntax. Use a function to display command syntax help when appropriate.
## this script prompts the user for a count of dice and then rolls them

### Variables definitions
declare -i numdice
declare -i numside

#Functions
function shusage {
  	echo "Usage: $0 [-h] [-c #] [-s #]"
}
function errormsg {
    echo "***ERROR: $@" >&2
}

## Process the command line
# set some reasonable defaults
numdice=0
numside=0
while [ $# -gt 0 ]; do
	case "$1" in
	-h )
		shusage
		exit 0
		;;
	-c )
    if [[ "$2" =~ ^[1-5]$ ]]; then
      numdice=$2
      #Need shift for EACH addition item to be processed
      shift
    else
      errormsg "Invalid number for -c, please use 1-5"
      exit 2
    fi
    ;;
  -s )
    if [[ "$2" =~ ^[1-9][0-9]*$ ]]; then
      if [ "$2" -ge 4 -a "$2" -le 20 ]; then
        numside=$2
        shift
      else
        errormsg "Invalid number for -s, please use 4-20"
        exit 2
      fi
    else
      errormsg "Invalid number for -s, please use 4-20" 
      exit 2
    fi
    ;;
	* )
		shusage
		errormsg "Argument '$1' not recognized"
		exit 2
		;;
	esac
	shift
done
# we now have count and sides variables
# count and sides may have zero in them if the user didn't give us anything for them

## Get a roll count if there wasn't one on the command line
# get a valid roll count from the user
until [[ $numdice =~ ^[1-5]$ ]]; do
  read -p "How many dice will be rolled[1-5]? " count
# ignore empty count
  [ -n "$numdice" ] || continue
# specificied count must have the number 1-5 only
#  [[ $count =~ ^[1-5]$ ]] && break
done
# get a valid number of sides from the user
while [ "$numside" -lt 4 -o "$numside" -gt 20 ]; do
  read -p "How many sides will be rolled[4-20]? " sides
# ignore empty number
  [ -n "$numside" ] || continue
# specified sides must have the number 4-20 only
  if [[ "$numside" =~ ^[1-9][0-9]*$ ]]; then
    if [ "$numside" -ge 4 -a "$numside" -le 20 ]; then
      break
    fi
  fi

done

## Do the script's work
# do the dice roll as many times as the user asked for
for (( numroll=0 ; numroll < numdice ; numroll++ )); do
# roll the dice
  die1=$(($RANDOM % $numside +1))
  die2=$(($RANDOM % $numside +1))
  sum=$(($die1 + $die2))
# show the roll results
  echo "Rolled $die1,$die2 for $sum"
done
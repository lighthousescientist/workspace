#!/bin/bash

#refer to yahtzee

#Prompt the user to provide a count from 1 to 5 which will be your number of dice, defaulting to 2 dice if the user just presses enter.
# Prompt the user for how many sides the dice should have (assume they all have the same number of sides). The number of sides must be from 4 to 20,
# with 6 being the default if the user just presses enter.
# Roll your virtual dice, and display what number came up on each,
#along with the sum of the rolls. Be sure to include the defaults in your prompts to the user.

#Lab4
#Modify rolldice.sh to accept a count of dice and a number of sides as command 
#line options, only asking the user for those numbers if they didn't give them 
#on the command line. Also accept a help option (-h or --help) that shows command 
#syntax. Use a function to display command syntax help when appropriate.

#lab4#######################
# while getopts ":d:h:" opt; do
#   case $opt in
#     d)
#       echo "# of dice"
#       let dice=${OPTARG}
#       [ -z "$dice" ] && let dice=2
#       echo $dice
#       shift
#       ;;
#     s)
#       echo "# of sides"
#       let sides=${OPTARG}
#       [ -z "$sides" ] && let sides=6
#       echo $sides
#       exit
#       ;;
#     h)
#       echo "-d      dice count (1-5) (default 2)"
#       echo "-s      side count (4-20) (default 6)"
#       exit
#       ;;
#     \?)
#       echo "Invalid option: -$OPTARG" >&2
#       exit
#       ;;
#   esac
# done
debug=0 #no debugging
while [ $# -gt 0 ]; do
	case "$1" in
	-h | --help )
		echo "Usage: $0 [-d level] [-h]"
		exit 0
		;;
	-d | --debug )
		if [[ "$2" =~ ^[1-9]$ ]]; then
			debug="$2"
			shift
			echo "Debug mode ON, level $debug"
		else
			echo "Cannot set debug without a debug level from 1 to 9">&2
			exit 2
		fi
		;;
	* )
		echo "Usage: $0 [-d level] [-h]"
		echo "Argument '$1' not recognized">&2
		exit 2
		;;
	esac
	shift
done
############################

read -p "Provide a dice count (1-5) (default 2): " dice
[ -z "$dice" ] && let dice=2 
echo $dice

read -p "How many sides should dice have (4-20) (default 6): " sides
[ -z "$sides" ] && let sides=6
echo $sides

echo "Rolling virtual dice..."

i="0"
while [ $i -lt $dice ]
do
roll=$(($RANDOM %$sides+1))
echo Rolled a $roll
total=$(($total + $roll))
i=$[$i+1]
done
echo For a total of $total.

#for (( rolls=0 ; rolls -lt count ; rolls++ )); do
#done

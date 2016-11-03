#!/bin/bash
#William McArthur 200324001
# -accept a count of dice and a number of sides as command line options
# -ask the user for those numbers if they didn't give them on the command line
# -accept a help option (-h or --help) that shows command syntax
# -Use a function to display command syntax help when appropriate

### These are my variable declarations
# integers for num of dice and num of sides on dice
declare -i dice
declare -i sides

### These are my functions

## This function shows help information
function showUsage {
  #$0 will be the name of the script
  echo "Usage: $0 [-h] [-d #] [-s #]"
  #Detailing what options are available and what they do
  echo "Option    Meaning"
  echo "-h        show help"
  echo "-d        # of dice  [1-5]"
  echo "-s        # of sides [4-20]"
}
## This function gives an error message
function error-message {
 #>&1 - redirect output to stdout
 #$@ is all positional parameters
 #this allows for more specific error messages
 echo "(!)ERROR(!) Invalid Input: $@" >&1
}

#set variables to 0 for loops to work
dice=0
sides=0


##testing for arguments with case
while [ $# -gt 0 ]; do
	case "$1" in
	#help argument
	-h )
		showUsage
		exit 0
		;;
	#dice number argument
	-d )
	  #if the number following d is 1 to 5
    if [[ "$2" =~ ^[1-5]$ ]]; then
      #dice is equal to that number
      dice=$2
      #for each additional item to be processed, a shift is required
      shift
    else
      #if number is not 1 to 5, tell the user what you want
      #and invoke error-message
      error-message "Number required for -d, from 1 to 5"
      exit 2
    fi
    ;;
  #side number argument
  -s )
      #if the number following s is > 4 and < 20
      if [ "$2" -ge 4 -a "$2" -le 20 ]; then
        #sides is equal to that number
        sides=$2
        shift
      else
        #if the number does not meet the requirements
        #invoke error-message and explain
        error-message "Number required for -s, from 4 to 20"
        exit 2
      fi
    ;;
  # show error and help for all other invalid input
	* )
		showUsage
		error-message "Argument '$1' is invalid"
		exit 2
		;;
	esac
	#end of case statement
	shift
done

###################################################################

####MAIN####

#keep looping until user responds from 1 to 5
until [[ $dice =~ ^[1-5]$ ]]; do
  #ask the user how many dice
  #catch user input and store it in dice
  read -p "How many dice shall I roll[1-5]? " dice

  #if user just hits enter, ask again
  [ -z "$dice" ] && continue


done

while [ "$sides" -lt 4 -o "$sides" -gt 20 ]; do
  #ask the user how many sides
  #catch user input and store it in sides
  read -p "How many sides should the dice have[4-20]? " sides

  #if user just hits enter, ask again
  [ -z "$sides" ] && continue

    #only break out of while loop if user responds from 4 to 20
    if [ "$sides" -ge 4 -a "$sides" -le 20 ]; then
      break
    fi

done

#number of rolls starts at 0 and counts up 1 each time around (rolls++)
#once rolls reaches dice value, you know you've rolled the right amount of dice
for (( rolls=0 ; rolls < dice ; rolls++ )); do
  
  #generate random integer from 1 to # of sides
  dieroll=$(($RANDOM % $sides +1))
  #each time around, add the number above to a grand total for later
  total=$(($total+$dieroll))
  
  #tell the user what was rolled on each dice roll
  echo "Rolled $dieroll for dice roll $(($rolls+1))"
done
  #finish off with the grand total from all the dice rolls
  #let the user know the program has finished with END
  echo "For a total of $total."
  echo "END"
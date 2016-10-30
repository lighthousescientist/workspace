#!/bin/bash

#Create a script that waits for a user-specified number of seconds printing out
#an update each second showing how many seconds are left, and catches the 
#interrupt and the quit signals. If it gets the interrupt signal (like from a ^C), 
#have it reset the timer to the initial number of seconds and print out a 
#message saying it is doing that. It should simply exit with a message if it 
#receives the quit signal (like from a ^\).

#Use a help function and your error-message function. Use functions 
#for your signal processing.

#Explanation
#The core of the program is a function for counting down a user specified
#number of seconds. The function is contained in a while loop
#Using trap, the program can detect an interrupt and invoke
#a function that resets the time remaining
#when ctrl \ is detected, this triggers a function that prints a message and exits 

#these are my variables
#initialtime allows me to reset the timer
declare -i initialtime
declare -i timeremaining
initialtime=0
timeremaining=0

## This function shows help information
function showUsage {
  echo "Please enter a positive integer."
}
## This function gives an error message
function error-message {
 #>&1 - redirect output to stdout
 echo "(!)ERROR(!) Invalid Input," >&1

}
##ctrl \ 
function quit {
echo ""
echo "Thank you for your time!"
exit 0
}
##ctrl c - reset the countdown
##achieved by resetting timeremaining with initialtime given by user
function int {
echo ""
timeremaining=initialtime
#let the user know the timer is reset
echo "Resetting to $initialtime seconds..."
}
######################################################
#Main body
function countdown {
#only breaks if timeremaining is none of the below
while [ -z "$timeremaining" -o "$timeremaining" = "0" -o "$timeremaining" -lt "0" ]; do 
#ask the user how many seconds the timer should have
read -p "How many seconds would you like to burn?: " initialtime
#assign a new variable with this number
#timeremaining is the working variable and initial time is a backup
timeremaining=initialtime
#if timeremaining is not an integer, display error and help
if [[ "$timeremaining" != ^[1-9][0-9]*$ ]]; then
error-message
showUsage
fi
done
#the countdown only starts if timeremaing is greater than 0    
while [ $timeremaining -gt 0 ]; do

    echo "$timeremaining more seconds..."
    timeremaining=$(($timeremaining-1))
    sleep 1 &
    wait $!
    
done
}
######################################################

#repeat countdown infinitely until quit function is invoked
while [[ 1 ]]; do
trap quit SIGQUIT
trap int SIGINT
countdown
done

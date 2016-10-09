#!/bin/bash

#Create an array containing 11 different food names. 
#Create two variables with random numbers in them from 1-6 each. 
#Add the two numbers together and use the sum as an index to 
#display a food from your array

# create array of foods
foods=(apple banana pizza wings beer steak sandwich "pop tart" chicken ribs dirt)
# roll 2 standard six-sided dice
die1=$(($RANDOM %6))
die2=$(($RANDOM %6))
# the food index is 0-10
foodindex=$((die1 + die2))
# for dicetotal, have to add 2 because the remainders are in the range of 0-5 and dice go 1-6
dicetotal=$((die1 + die2 + 2))
# look up the data first to make the output command more readable
food=${foods[$foodindex]}
# everything done, produce output
echo "Yum, I rolled $dicetotal which gives me $food!"



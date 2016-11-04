#!/bin/bash

#Create array of colours, with at least 4 colours
#Create an associative array of animals, where the keys are colours,
#	and the values are animals who are that colour
#Use the colours you put into the first array
#Ask the user for a number and use it to display a colour from the array,
#	then the corresponding animal from the associative array for that colour

##############
# Variables
# create an array with some colours in it
colours=("red" "green" "blue" "yellow" "orange" "black and white")

#create a hash of animals which relates to the colours array values
declare -A animals
animals=(
    ["red"]="cardinal" 
    ["blue"]="lobster" 
    ["green"]="frog" 
    ["yellow"]="canary"
    ["orange"]="trumpapottamus"
    ["black and white"]="zebra"
        )

##############
# Main
##############
#use a for wordlist look to display all the colours of animals

#notice the quotes making sure "black and white" is treated as one
for colour in "${colours[@]}"; do
    animal=${animals[$colour]}
    echo "We have a $colour $animal"
done


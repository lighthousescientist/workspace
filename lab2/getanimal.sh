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
colours=("red" "green" "blue" "yellow")

#create a hash of animals which relates to the colours array values
declare -A animals
animals=(
    ["red"]="cardinal" 
    ["blue"]="lobster" 
    ["green"]="frog" 
    ["yellow"]="canary"
        )

##############
# Main
##############
#display the colours and animals arrays
echo "The colours array has ${colours[0]}, ${colours[1]}, ${colours[2]} and ${colours[3]} in it."
echo "The @ symbol shows us the colours are: ${colours[@]}"
echo "The red animal is a ${animals[red]}."
echo "The red animal is a ${animals[blue]}."
echo "The red animal is a ${animals[green]}."
echo "The red animal is a ${animals[yellow]}."
echo "The animls hash contains ${animals[@]}."
echo "Their colours are ${!animals[@]}."

#get a number from the user to look up a specific animal and display it
read -p "Give me a number from 0 to 3: " num
colour=${colours[$num]}
animal=${animals[$colour]}
echo "Index $num gives us a $colour $animal."



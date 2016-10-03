#!/bin/bash

#Create an array of 11 food names
#Create 2 vars with random numbers in them from 1-6 each
#Add the two numbers together and use the sum as an index to display a food from array

ARRAY=(apple banana cucumber doritos eggroll fajita greenpepper jell-o lambchop onion porkchop)
random1=$(( ( RANDOM % 6 ) + 1))
random2=$(( ( RANDOM % 6 ) + 1))
index=$(( $random1+$random2 ))

echo ${ARRAY[$index-1]}



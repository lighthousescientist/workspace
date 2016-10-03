#!/bin/bash

# Create a script that displays "Welcome to planet..." output using variables.

export MYNAME="William McArthur"
mytitle="Student"
myhostname=$(hostname)
weekday=$(date +"%A")

echo "Welcome to planet $myhostname, $mytitle $MYNAME!"
echo "Today is $weekday."

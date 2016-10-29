#!/bin/bash

#Create a script that waits for a user-specified number of seconds printing out
#an update each second showing how many seconds are left, and catches the 
#interrupt and the quit signals. If it gets the interrupt signal (like from a ^C), 
#have it reset the timer to the initial number of seconds and print out a 
#message saying it is doing that. It should simply exit with a message if it 
#receives the quit signal (like from a ^\).

#Use a help function and your error-message function. Use functions 
#for your signal processing.

declare -i seconds 

function quit {
    echo "Detected the quite signal."
    #exit 1
}
function again {
    echo "Detected the interrupt signal."
    echo "Restarting..."
    #countdown
}


function countdown {
    trap again SIGINT
    trap quit SIGQUIT
read -p "How many seconds for countdown: " seconds

for (( zero=0 ; seconds > zero ; seconds-- )); do
    
    echo "$seconds more second(s)..."
    
    sleep 1
    
done
}

while [[ 1 -gt 0 ]]; do
countdown
done

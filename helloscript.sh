#!/bin/bash
#Lab 1 - Step 3
#"Displays the string Hello World!"
#Takes no input

#silly way of creating the output
echo -n "helb wold" |
    sed -e "s/b/o/g" -e "s/l/ll/" -e "s/ol/orl/" |
    tr "h" "H"|tr "h" "H"|tr "w" "W"|
    awk '{print $1 "\x20" $2 "\41"}'
    





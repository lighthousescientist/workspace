#!/bin/bash
#William McArthur 200324001

#Create an array using the output of ifconfig which has the names of
#the network interfaces in it. Use those names to extract the ip 
#addresses of the interfaces, also using ifconfig output. 
#Parse the output of route -n to display the ip address of the default gateway.

# -Accept a help option 
# -Accept an interface name to display instead of displaying them all 
# -Only display default route information if the user gives (-r or --route) 
# -Use your error-message function and help function where appropriate.

#Use your error-message function for error messages and a command syntax help function where appropriate.
## Functions

## This function shows help information
function showUsage {
  #$0 will be the name of the script
  echo "Usage: $0 [-h] [-c #] [directory]"
}
## This function gives an error message
function error-message {
 #>&1 - redirect output to stdout
 #$@ is all positional parameters
 #this allows for more specific error messages
 echo "(!)ERROR(!): $@" >&1
}

#these are my variables
defaultroute="false"

#declare interface array
declare -a iparray

#while there is an argument, test with case statements
while [ $# -gt 0 ]; do
	case "$1" in
	#help
	-h )
		showUsage
		exit 0
		;;
	#display default routing information
   -r )
   defaultroute="true"
    ;;
    #for all else
	* )
		#tell the user what the program expects
		showUsage
		#tell the user what they did wrong
		error-message "Argument '$1' not recognized"
		exit 2
		;;
	esac
	shift
done

###############MAIN
#ifconfig displays the interface information
#we pipe to grep that searches for an alphabetical pattern
#finally piping to awk, which will provide field 1 of ifconfig
intname=(`ifconfig |grep '^[a-zA-Z]'|awk '{print $1}'`)
#using associative arrays
#grep locates "intet addr"
#first sed records the inet address
#second sed closes it off as to not include the Bcast and Mask
iparray[0]=`ifconfig ${intname[0]} | grep 'inet addr' | sed -e 's/  *inet addr://' | sed -e 's/ .*//'`
iparray[1]=`ifconfig ${intname[1]} | grep 'inet addr' | sed -e 's/  *inet addr://' | sed -e 's/ .*//'`


#display information for first interface in ifconfig
echo "Interface ${intname[0]} has address ${iparray[0]}"
#display information for second interface
echo "Interface ${intname[1]} has address ${iparray[1]}"
#if the user uses the "-r" flag, display default gateway information
if [ $defaultroute != "false" ]; then
#record default gateway address from "route -n"
gateway=`route -n|grep '^0.0.0.0 '|awk '{print $2}'`
#tell the user what the default gateway is
echo "My default gateway is $gateway"
fi
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
declare -a ips

while [ $# -gt 0 ]; do
	case "$1" in
	-h )
		showUsage
		exit 0
		;;
  -r )
   defaultroute="true"
    ;;
	* )
		showUsage
		error-message "Argument '$1' not recognized"
		exit 2
		;;
	esac
	shift
done

#MAIN

interfacenames=(`ifconfig |grep '^[a-zA-Z]'|awk '{print $1}'`)
ips[0]=`ifconfig ${interfacenames[0]} | grep 'inet addr' | sed -e 's/  *inet addr://'| sed -e 's/ .*//'`
ips[1]=`ifconfig ${interfacenames[1]} | grep 'inet addr' | sed -e 's/  *inet addr://'| sed -e 's/ .*//'`

gatewayip=`route -n|grep '^0.0.0.0 '|awk '{print $2}'`


echo "Interface ${interfacenames[0]} has address ${ips[0]}"
echo "Interface ${interfacenames[1]} has address ${ips[1]}"

if [ $defaultroute != "false" ]; then
echo "My default gateway is $gatewayip"
fi
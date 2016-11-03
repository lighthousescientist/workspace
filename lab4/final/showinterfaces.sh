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

## These are my variables
#this variable is used to point to each name and address couple
declare -i intnum
#this variable determines how many interfaces are shown
declare -i howmany

#start at first interface by default
intnum=0
#because there are only two interfaces, default is 1 for the roof
howmany=1

## These are my functions
## This function shows help information
function showUsage {
  #$0 will be the name of the script
  echo "Usage: $0 [-h] [-r] [-i #]"
  #Detailing what options are available and what they do
  echo "Option    Meaning"
  echo "-h        show help"
  echo "-r        routing information"
  echo "-i        int # [leave blank for all]"
  echo ""
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
		#help function
		showUsage
		exit 0
		;;
	#display default routing information
   -r )
   #handled by if statement for showing default route
   defaultroute="true"
   shift
    ;;
   -i )
   #both intnum and howmany are the same so that only the interface asked
   #for is shown
   intnum=$2
   howmany=$2
   #if the user just enters "-i" with no #, all interfaces are shown up to
   #default interface limit
   [ -z "$2" ] && howmany=1 
   shift
    #for all else
    ;;
	* )
		#tell the user what the program expects
		showUsage
		#tell the user what they did wrong
		error-message "Argument '$1' not recognized"
		exit 2
		;;
	#end of case statement	
	esac
	shift
done

#################################################################MAIN
#ifconfig displays the interface information
#we pipe to grep that searches for an alphabetical pattern
#finally piping to awk, which will provide field 1 of ifconfig
intname=(`ifconfig |grep '^[a-zA-Z]'|awk '{print $1}'`)

while [[ "$intnum" -le "$howmany" ]]; do
    #using associative arrays
	#grep locates "intet addr"
	#first sed records the inet address
	#second sed closes it off as to not include the Bcast and Mask
	#including the below line in the loop allows any number of interfaces
    iparray[$intnum]=`ifconfig ${intname[$intnum]} | grep 'inet addr' | sed -e 's/  *inet addr://' | sed -e 's/ .*//'`
    #if there is no name or address to display, tell the user no int exists
	[ -z "${intname[$intnum]}" ] && error-message "Interface $intnum does not exist." && break
	#print out the name of the interface and its IP address
	echo "Interface ${intname[$intnum]} has address ${iparray[$intnum]}"
	
	#this will break out of the while loop
	intnum=$(($intnum+1))
done

#echo "Interface ${intname[1]} has address ${iparray[1]}"

#if the user uses the "-r" flag, display default gateway information
if [ $defaultroute != "false" ]; then
#Parse the output of route -n to get the ip address of the default gateway
gateway=`route -n|grep '^0.0.0.0 '|awk '{print $2}'`
#tell the user what the default gateway is
echo "My default gateway is $gateway"
fi
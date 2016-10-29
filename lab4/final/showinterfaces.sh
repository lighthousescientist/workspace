#!/bin/bash

#Create an array using the output of ifconfig which has the names of
#the network interfaces in it. Use those names to extract the ip 
#addresses of the interfaces, also using ifconfig output. 
#Parse the output of route -n to display the ip address of the default gateway.

#Use your error-message function for error messages and a command syntax help function where appropriate.
## Functions
function showUsage {
  echo "Usage: $0 [-h] [-i #] [-r]"
}
function error-message {
#  echo "***ERROR: $@" >&2
  prog=`basename $0`
  echo "${prog}: ${1:-Unknown Error - Well this is embarrasing...}" >&2

}

#declare interface array
declare -a ips

while [ $# -gt 0 ]; do
	case "$1" in
	-h )
		showUsage
		exit 0
		;;
	-i )
    if [[ "$2" =~ ^[1-5]$ ]]; then
      dice=$2
      shift
    else
      error-message "Number required for -d, from 1 to 5"
      exit 2
    fi
    ;;
  -r )
    if [[ "$2" =~ ^[1-9][0-9]*$ ]]; then
      if [ "$2" -ge 4 -a "$2" -le 20 ]; then
        sides=$2
        shift
      else
        error-message "Number required for -s, from 4 to 20"
        exit 2
      fi
    else
      error-message "Number required for -s, from 4 to 20"
      exit 2
    fi
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

cat <<EOF
Interface ${interfacenames[0]} has address ${ips[0]}
Interface ${interfacenames[1]} has address ${ips[1]}
My default gateway is $gatewayip
EOF
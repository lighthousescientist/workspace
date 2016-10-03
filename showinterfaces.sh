#!/bin/bash

#Create an array using the output of ifconfig
#Use the names of the interfaces to extract the ip addresses using ifconfig
#Parse the output of "route -n" to display the ip address of the default gateway

#array for interfacenames
declare -a ips
interfacenames=(`ifconfig | grep '^[a-zA-Z]'| awk '{print $1}'` )
ips[0]=`ifconfig ${interfacenames[0]} | grep 'inet addr' | sed -e 's/ *inet addr://'| sed -e 's/ .*//'`
ips[1]=`ifconfig ${interfacenames[0]} | grep 'inet addr' | sed -e 's/ *inet addr://'| sed -e 's/ .*//'`

#variable for default gateway
gatewayip=(`route -n | grep '^0.0.0.0'| awk '{print $2}'` )

#human-friendly report
cat <<EOF
Interface ${interfacenames[0]} has address ${ips[0]}
Interface ${interfacenames[1]} has address ${ips[1]}

My default gateway is $gatewayip
EOF
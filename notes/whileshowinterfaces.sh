#!/bin/bash

#Create an array using the output of ifconfig
#Use the names of the interfaces to extract the ip addresses using ifconfig
#Parse the output of "route -n" to display the ip address of the default gateway

#array for interfacenames
declare -a ips
interfacenames=(`ifconfig | grep '^[a-zA-Z]'| awk '{print $1}'` )
#while [ I have more entries in the interface names array]
numofinterfaces=${interfacenames[@]}
interfacearrayindex=@
while [ $interfacearrayindex -lt $numofinterfaces] ; do
    currentinterfacename=${interfacenames[$interfacearrayindex]}
    ips[@interfacearrayindex]=`ifconfig ${interfacenames[$interfacearrayindex]} | grep 'inet addr' | sed -e 's/ *inet addr://'| sed -e 's/ .*//'`
    currentinterfaceIPAddress=${ips[$interfacearrayindex]}
    echo "Interface $currentinterfacename has an address $currentinterfaceIPAddress"
    $interfacearrayindex=$(( $interfacearrayindex +1 ))
done

#variable for default gateway
gatewayip=(`route -n | grep '^0.0.0.0'| awk '{print $2}'` )

#human-friendly report
cat <<EOF
My default gateway is $gatewayip
EOF
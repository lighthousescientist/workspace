#!/bin/bash
#Lab 1 - Step 5
#"display your public IP address using wget"

#strip HTML using sed
wget -qO- http://icanhazip.com | sed -e 's/<[^>]*>//g'

#another way
#wget -aO - http://icanhazip.com
#another way
#curl icanhazip.com
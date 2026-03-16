#!/bin/bash

##############################################################################################
# This script do the following actions:
#	- Configures multiple interfaces
#   - Starts the NGINX service
#   - Starts the SSH service
#   - Creates an infinite loop to maintain alive the container
##############################################################################################

# We create multiple available IPs
AVAILABLE_INTERFACES=()

for ((i = 20; i <= 255; i++)); do
    AVAILABLE_INTERFACES+=("192.168.${i}.")
    AVAILABLE_INTERFACES+=("172.10.${i}.")
    AVAILABLE_INTERFACES+=("10.0.${i}.")
done

# We create, activate and set a random IP in the fake interfaces
for ((i = 3; i <= 250; i++)); do
    ip link add eth$i type dummy
    ip link set eth$i up

    prefix=${AVAILABLE_INTERFACES[$RANDOM % ${#AVAILABLE_INTERFACES[@]}]}
    ip addr add ${prefix}${i}/24 dev eth$i
done

# Starting services
service cron start
service ssh start

exec nginx -g 'daemon off;'

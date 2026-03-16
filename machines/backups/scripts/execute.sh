#!/bin/bash

##############################################################################################
# This script do the following actions:
#   - Creates an infinite loop to maintain alive the container
##############################################################################################

service ssh start

while [ 1 == 1 ]; do
	sleep 1
done

#!/bin/bash

############################################################################################
# This script do the following actions:
#	- Maps containers and stops them (reading from dockername.txt or from docker-compose.yml)
############################################################################################

if [ -e dockername.txt ]; then
	CONTAINERS=$(cat dockername.txt)
	
	while IFS= read -r name; do
    	docker compose --env-file /dev/null -p $name stop
	done <<< "$CONTAINERS"
else
	mapfile -t CONTAINERS < <(yq '.services | keys | .[]' ./docker-compose.yml)
	
	for name in "${CONTAINERS[@]}"; do
		docker compose --env-file /dev/null -p $name stop
	done;
fi;

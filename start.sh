#!/bin/bash

mkdir -p flags

for flag in {1,2,3}; do
	echo $RANDOM | sha256sum | awk '{print "vera{"$1"}"}' > flags/flag$flag.txt
done;

if [ -e dockername.txt ]; then
	CONTAINERS=$(cat dockername.txt)
	
	while IFS= read -r name; do
    	docker compose --env-file /dev/null -p $name up -d
	done <<< "$CONTAINERS"
else
	mapfile -t CONTAINERS < <(yq '.services | keys | .[]' ./docker-compose.yml)
	
	for name in "${CONTAINERS[@]}"; do
		docker compose --env-file /dev/null -p $name up -d
	done;
fi;
#!/bin/bash

##############################################################################################
# This script do the following actions:
#   - Resets env variables files (if present)
#	- Maps containers (directly from docker-compose.yml)
#	- Sets the available ports, image and container name to dockername.txt
##############################################################################################

# Reset env
> .env
> dockername.txt

mapfile -t CONTAINERS < <(yq '.services | keys | .[]' ./docker-compose.yml)
echo "[" > .env

for name in "${CONTAINERS[@]}"; do
    IMAGE=$(yq ".services.$name.image" ./docker-compose.yml)
    PORTINS=()
    PORTOUTS=()

    mapfile -t PORTS_RAW < <(yq ".services.$name.ports | .[]" ./docker-compose.yml)

    for port in "${PORTS_RAW[@]}"; do
        PORTINS+=($(echo $port | cut -d ':' -f 1))
        PORTOUTS+=($(echo $port | cut -d ':' -f 2))
    done

    PORTINS_STR=$(IFS=','; echo "${PORTINS[*]}")
    PORTOUTS_STR=$(IFS=','; echo "${PORTOUTS[*]}")

    echo "{image: '$IMAGE', portin: '$PORTINS_STR', portout: '$PORTOUTS_STR'}," >> .env
    echo "$name" >> dockername.txt
done;

echo "]" >> .env

echo "Environment prepared. Please check .env and dockername.txt"
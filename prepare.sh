#!/bin/bash

# Reset env
> .env
> dockername.txt

mapfile -t CONTAINERS < <(yq '.services | keys | .[]' ./docker-compose.yml)

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

    echo "{image: '$IMAGE', portin: '$PORTINS_STR', portout: '$PORTOUTS_STR'}" >> .env
    echo "$name" >> dockername.txt
done;

echo "Environment prepared. Please check .env and dockername.txt"
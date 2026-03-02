#! /bin/bash

if [ -e dockername.txt ]; then
	NAME=$(cat dockername.txt);
else
	NAME="imagen-template-system";
fi;

docker compose -p $NAME down --rmi all
#! /bin/bash
echo $RANDOM | sha256sum | awk '{print "conclave{"$1"}"}' > flag/flag.txt

if [ -e dockername.txt ]; then
	NAME=$(cat dockername.txt);
else
	NAME="imagen-template-system";
fi;

docker compose -p $NAME up -d
#! /bin/bash
IMAGE=${1:-imagen-template}
PORTIN=${2:-80}
PORTOUT=${3:-8080}

echo "IMAGE: $IMAGE" > .env;
echo "PORTIN: $PORTIN" >> .env;
echo "PORTOUT: $PORTOUT" >> .env;

echo "$IMAGE-system" > dockername.txt;
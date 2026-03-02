#! /bin/bash
IP=${1:-127.0.0.1}
PORT=${2:-8080}

curl -s http://$IP:$PORT/ | grep -o conclave{.*}
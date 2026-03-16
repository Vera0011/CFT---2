#!/bin/bash

apt-get update && apt-get install -y
apt install nginx openssh-client openssh-server cron nano iproute2 -y

## NGINX configuration and certificates ##
##########################################
mkdir -p /etc/nginx/certs
mkdir -p /usr/share/nginx/html

cp /app/src/nginx.conf /etc/nginx/sites-available/default
cp /app/public/index.html /usr/share/nginx/html/index.html

# We create multiple fake pages
for ((i = 1; i <= 100000; i++)); do
    echo $RANDOM > /usr/share/nginx/html/$RANDOM.html
done

cp /app/src/bastion.key /etc/nginx/certs/bastion.key
cp /app/src/bastion.crt /etc/nginx/certs/bastion.crt

## SSH + NGINX configuration ##
###############################
cp /app/src/id_rsa /usr/share/nginx/html/rsa
chmod 444 /usr/share/nginx/html/rsa

## SSH configuration ##
#######################
mkdir -p ~/.ssh/ /etc/ssh
cp /app/src/id_rsa /usr/share/nginx/html/rsa
cat /app/src/id_rsa.pub > ~/.ssh/authorized_keys
cp /app/src/sshd_config /etc/ssh/sshd_config

cat /app/src/id_rsa | base64 -d > ~/.ssh/id_rsa
ssh-keyscan 192.168.10.2 > ~/.ssh/known_hosts

## Crontab and backups configuration  ##
########################################
mkdir -p /backups

echo "# min  hour  day  month  weekday  command
*/1 * * * *  bash /usr/local/bin/crontab.sh >> /var/log/crontab.log 2>&1" > /etc/cron.d/custom
chmod 0644 /etc/cron.d/custom
crontab /etc/cron.d/custom

cp /app/src/crontab.sh /usr/local/bin/crontab.sh
chmod 0550 /usr/local/bin/crontab.sh

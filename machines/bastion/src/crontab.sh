#!/bin/bash
# Adding IP to known hosts (to avoid disabling the checks)
ssh-keyscan 192.168.10.3 > ~/.ssh/known_hosts

BACKUP_NAME=$(date +'%s').tar

tar -cf /backup-$BACKUP_NAME /etc/nginx /var/log/nginx
scp -4 -i ~/.ssh/id_rsa /backup-$BACKUP_NAME ubuntu@192.168.10.3:/backups/backup-$BACKUP_NAME

rm /backup-$BACKUP_NAME
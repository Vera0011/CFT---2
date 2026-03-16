#!/bin/bash

BACKUP_NAME=$(date +'%s').tar

tar -cf /backup-$BACKUP_NAME /etc/nginx /var/log/nginx
scp -4 -i ~/.ssh/id_rsa /backup-$BACKUP_NAME root@192.168.10.2:/backups/backup-$BACKUP_NAME

rm /backup-$BACKUP_NAME
#!/bin/bash

## Backup configuration ##
##########################
mkdir -p /backups
chown -R ubuntu:ubuntu /backups

## SSH configuration ##
#######################
mkdir -p /home/ubuntu/.ssh/ /etc/ssh

cat /app/src/id_rsa.pub > /home/ubuntu/.ssh/authorized_keys

cp /app/src/sshd_config /etc/ssh/sshd_config
chown -R ubuntu:ubuntu /home/ubuntu/.ssh/authorized_keys
chmod 600 /home/ubuntu/.ssh/authorized_keys

## Privilege escalation setup ##
################################
echo "ubuntu ALL=(ALL) NOPASSWD: /usr/bin/rsync" > /etc/sudoers
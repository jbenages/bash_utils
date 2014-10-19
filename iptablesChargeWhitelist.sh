#!/bin/bash

#Usage 
#./iptablesChargeWhitelist.sh "21,22"

declare ports=( "$1" )

while read ip
do
	if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]] ; then
		echo "[+] Add ip to whitelist $ip"
		whitelist+=( "$ip" )
	else
	    echo "[-] Wrong ip in list: $ip"
	fi
done < whitelist.txt

SAVE_IFS=$IFS
IFS=","
whitelist="${whitelist[*]}"
IFS=$SAVE_IFS

for (( j=0; j<${#ports[@]}; j++ ));do
	if (iptables -A INPUT -p tcp --dport ${ports[$j]} -s $whitelist -j ACCEPT); then
		echo "[+]Command: iptables -A INPUT -p tcp --dport ${ports[$j]} -s $whitelist -j ACCEPT"
	else
		echo "[!] Fail command: iptables -A INPUT -p tcp --dport ${ports[$j]} -s $whitelist -j ACCEPT"
	fi
	if (iptables -A INPUT -p tcp --dport ${ports[$j]} -j DROP); then
		echo "[+]Command: iptables -A INPUT -p tcp --dport ${ports[$j]} -j DROP"
	else
		echo "[!] Fail command: iptables -A INPUT -p tcp --dport ${ports[$j]} -j DROP"
	fi
done

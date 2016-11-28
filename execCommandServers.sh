#!/sbin/bash
# Need RSA root key configured in servers in /root/.ssh/authorized_keys
declare -A servers
servers[servername]="1.1.1.1"
 
 
if [[ -z "$1" ]];then
    echo "[!] Need command for execute"
fi
 
if [[ "$2" == "-y" ]];then
        echo "[+] Accept directly command $1"
else
    read -p "[?] You like exec ( $1 ), Are you sure? [y/N]: " response
    if [[ "$response" != "y" ]];then
        echo "exit ..."
        exit 0
    fi
fi
 
for server in ${!servers[@]}; do
    printf "[i] Exec command $1 in $server ["
    result=$(ssh root@${servers[$server]} "$1")
    if (( ! $? ));then
        printf "+]\n"
    else
        printf "-]\n"
    fi
    echo "[i] Result >>>>"
    echo "$result"
    echo "[i] <<<< Result "
         
done

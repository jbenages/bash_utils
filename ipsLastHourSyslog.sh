#!/bin/bash

# Example: bash ipsLastHourSyslog.sh

PATHLOGS="/var/log"
SEARCHHOUR=`LANG=en_US date '+%h %d %H:'`
echo $SEARCHHOUR
 
while read resultcommand
do 
    lines+=( "$resultcommand" )
done < $(cat $PATHLOGS/syslog  | grep "$SEARCHHOUR" | egrep -E "/[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\n/")
 
result=
 
IFS='\n' read -ra ADDR <<< "$result"
for i in "${ADDR[@]}"; do
    echo "$i \n"
done

#!/bin/bash
 
# @param $1 Total actions to do.
# @param $2 Current state in actions.
# @param $3 Information showed in finish bar.
function progressBar(){
    local total=$1
    local charsExtra=40
    let "charsExtra=$charsExtra-${#3}"
    let "status=$2+1"
    let "percentage=$status*100/$total"
    let "rest=100-$percentage"
    s=$(printf "%"$percentage"s" "•")
    r=$(printf "%"$rest"s")
    e=$(printf "%"$charsExtra"s")
    let "percentage=$status*100/$total"
    echo -ne "\r◘${s// /•}${r}◘ "$percentage"% [Info] $3${e}"
}
 
#Usage example
 
declare actions=( "init" "search" "search." "search.." "search..." "done" )
 
iTop=${#actions[@]}
 
for (( i=0; i<$iTop; i++ ));do
    progressBar "$iTop" "$i"  "LastAction:${actions[$i]}"
    sleep 1
done

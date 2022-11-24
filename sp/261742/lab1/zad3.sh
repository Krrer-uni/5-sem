#!/bin/bash
a=$( find $1 -type f )
text=""
for file in $a 
do
    ap=$( cat $file |  tr '[:space:]' '[\n*]'| sort | uniq )
    text+=" $ap" 
done
echo $text | tr '[:space:]' '[\n*]' | sort | uniq -c 
#!/bin/bash

svn checkout -r $1 $2 temp > /dev/null

a=$( find ./temp -path ./temp/.svn -prune -o -type f )
text=""
for file in $a 
do
    ap=$( cat $file |  tr '[:space:]' '[\n*]'| sort | uniq )
    text+=" $ap" 
done
echo $text | tr '[:space:]' '[\n*]' | sort | uniq -c 

rm -rf ./temp
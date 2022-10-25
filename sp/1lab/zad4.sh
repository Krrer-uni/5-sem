#!/bin/bash
dic=$(find $1 -type f -exec cat {} + | tr '[:space:]' '[\n*]' | sort | uniq )
files=$(find $1 -type f)
for word in $dic
do
    echo "####### word $word"
    for file in $files
    do
    line=$(grep -w "$word" $file)
    if [ "$line" != "" ]
    then
        echo $ $file
        
    fi
    
    done
done
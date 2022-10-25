#!/bin/bash
files=$(find $1 -type f)

for file in $files
do
cat $file | sed  's/a/A/g' >
done

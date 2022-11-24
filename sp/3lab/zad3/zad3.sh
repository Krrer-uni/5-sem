#!/bin/bash

svn checkout -r $1 $2 temp > /dev/null
a=$(find ./temp -path ./temp/.svn -prune -o -type f -exec cat {} \; | tr '[:space:]' '[\n*]' | uniq )
echo $a | tr '[:space:]' '[\n*]' | sort | uniq -c
rm -rf ./temp
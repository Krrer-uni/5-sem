#!/bin/bash

svn checkout -r $1 $2 temp > /dev/null
find ./temp -path ./temp/.svn -prune -o -type f -exec cat {} + | tr '[:space:]' '[\n*]' | sort | sed '/^[[:space:]]*$/d' | uniq -c $b
rm -rf ./temp/
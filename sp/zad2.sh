#!/bin/bash
find $1 -type f -exec cat {} + | tr '[:space:]' '[\n*]' | sort | uniq -c $b
# echo $b
# echo $()
# for c in $(uniq $b)
# do
#     echo $c $(wc -w $b | grep -c $c)
# done
# # tr '[:space:]' '[\n*]' < a/aa/b/aaab | cat aasda

#!/bin/bash
find $1 -type f -exec cat {} + | tr '[:space:]' '[\n*]' | sort | sed '/^[[:space:]]*$/d' | uniq -c $b

#!/bin/bash
a=$(find $1 -type f -exec cat {} \; | tr '[:space:]' '[\n*]' | uniq )
echo $a | tr '[:space:]' '[\n*]' | sort | uniq
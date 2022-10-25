dic=$(find $1 -type f -exec cat {} + | tr '[:space:]' '[\n*]' | sort | uniq )
files=$(find $1 -type f)
for word in $dic
do
    # echo "####### word $word"
    for file in $files
    do
    cat $file | while read line 
    do
    num=$(echo $line | grep -w -o "$word" | sort | wc -w) 
    if (( $num > 1 )) 
    then
        echo $word $file $(echo  $line | grep -w "$word" )
        
    fi
    done
    done
done
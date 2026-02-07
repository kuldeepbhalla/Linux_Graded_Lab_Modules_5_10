#!/bin/bash

# Check if exactly one argument is provided
if [ "$#" -ne 1 ]; then
    echo "Error: Provide exactly one argument"
    exit 1
fi

path="$1"

# Check if path exists
if [ ! -e "$path" ]; then
    echo "Error: Path does not exist"
    exit 1
fi

# If it is a file
if [ -f "$path" ]; then
    lines=$(wc -l < "$path")
    words=$(wc -w < "$path")
    chars=$(wc -c < "$path")
    echo "$lines $words $chars $path"

# If it is a directory
elif [ -d "$path" ]; then
    total_files=$(ls "$path" | wc -l)
    text_files=$(ls "$path"/*.txt 2>/dev/null | wc -l)
    echo "Total files: $total_files"
    echo "Text files: $text_files"
fi

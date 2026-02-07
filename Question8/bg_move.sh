#!/bin/bash

# Check argument count
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

dir="$1"

# Check if directory exists
if [ ! -d "$dir" ]; then
    echo "Directory not found!"
    exit 1
fi

# Create backup subdirectory if not exists
backup="$dir/backup"
mkdir -p "$backup"

echo "Parent PID: $$"

# Move each file in background
for file in "$dir"/*; do
    if [ -f "$file" ]; then
        mv "$file" "$backup/" &
        echo "Moving $(basename "$file") in background with PID $!"
    fi
done

# Wait for all background jobs to finish
wait
echo "All files moved to $backup"

#!/bin/bash

# Check argument count
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <dirA> <dirB>"
    exit 1
fi

dirA="$1"
dirB="$2"

# Check directories exist
if [ ! -d "$dirA" ] || [ ! -d "$dirB" ]; then
    echo "Both directories must exist"
    exit 1
fi

echo "Files only in $dirA:"
comm -23 <(ls "$dirA" | sort) <(ls "$dirB" | sort)

echo ""
echo "Files only in $dirB:"
comm -13 <(ls "$dirA" | sort) <(ls "$dirB" | sort)

echo ""
echo "Files with same name and content check:"
for file in "$dirA"/*; do
    fname=$(basename "$file")
    if [ -f "$dirB/$fname" ]; then
        if cmp -s "$dirA/$fname" "$dirB/$fname"; then
            echo "$fname : SAME"
        else
            echo "$fname : DIFFERENT"
        fi
    fi
done

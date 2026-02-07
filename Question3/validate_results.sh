#!/bin/bash

# Initialize counters
one_fail_count=0
all_pass_count=0

# Check if marks.txt exists
if [ ! -f "marks.txt" ]; then
    echo "Error: marks.txt not found"
    exit 1
fi

echo "Students who failed in exactly ONE subject:"
echo "-----------------------------------------"

# Read file line by line
while IFS=',' read -r roll name m1 m2 m3
do
    fail=0
    
    # Check each mark
    for mark in $m1 $m2 $m3
    do
        if [ "$mark" -lt 33 ]; then
            fail=$((fail + 1))
        fi
    done
    
    if [ "$fail" -eq 1 ]; then
        echo "$roll, $name"
        one_fail_count=$((one_fail_count + 1))
    elif [ "$fail" -eq 0 ]; then
        all_pass_count=$((all_pass_count + 1))
    fi

done < marks.txt

echo ""
echo "Total students who failed in exactly ONE subject: $one_fail_count"
echo "Total students who passed in ALL subjects: $all_pass_count"

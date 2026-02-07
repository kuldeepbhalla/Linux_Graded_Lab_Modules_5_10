#!/bin/bash

# Check if emails.txt exists
if [ ! -f "emails.txt" ]; then
    echo "emails.txt not found!"
    exit 1
fi

# Extract valid emails and remove duplicates
grep -E '^[a-zA-Z0-9]+@[a-zA-Z]+\.com$' emails.txt | sort | uniq > valid.txt

# Extract invalid emails
grep -Ev '^[a-zA-Z0-9]+@[a-zA-Z]+\.com$' emails.txt > invalid.txt

echo "Valid emails saved in valid.txt"
echo "Invalid emails saved in invalid.txt"

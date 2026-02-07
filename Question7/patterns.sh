#!/bin/bash

# Check if input.txt exists
if [ ! -f "input.txt" ]; then
    echo "input.txt not found!"
    exit 1
fi

# Convert file to lowercase, split into words
words=$(tr -cs '[:alpha:]' '\n' < input.txt | tr '[:upper:]' '[:lower:]')

# Words with only vowels
echo "$words" | grep -E '^[aeiou]+$' > vowels.txt

# Words with only consonants
echo "$words" | grep -E '^[^aeiou]+$' > consonants.txt

# Words starting with consonant and having both vowels and consonants
echo "$words" | grep -E '^[^aeiou][a-z]*[aeiou][a-z]*' > mixed.txt

echo "Files created:"
echo "vowels.txt, consonants.txt, mixed.txt"

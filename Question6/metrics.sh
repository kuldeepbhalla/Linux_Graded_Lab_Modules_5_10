#!/bin/bash

# Check if input.txt exists
if [ ! -f "input.txt" ]; then
    echo "input.txt not found!"
    exit 1
fi

# Convert file to words (one per line)
words=$(tr -cs '[:alnum:]' '\n' < input.txt)

# Longest word
longest=$(echo "$words" | awk '{ if(length > max) {max=length; word=$0} } END{print word}')

# Shortest word
shortest=$(echo "$words" | awk 'length>0 { if(min==0 || length<min){min=length; word=$0} } END{print word}')

# Average word length
total_chars=$(echo "$words" | awk '{sum += length} END{print sum}')
total_words=$(echo "$words" | wc -l)
avg=$(echo "scale=2; $total_chars/$total_words" | bc)

# Unique words
unique=$(echo "$words" | tr '[:upper:]' '[:lower:]' | sort | uniq | wc -l)

# Display results
echo "Longest word: $longest"
echo "Shortest word: $shortest"
echo "Average word length: $avg"
echo "Total number of unique words: $unique"

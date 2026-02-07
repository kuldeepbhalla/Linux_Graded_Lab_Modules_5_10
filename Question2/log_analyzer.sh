#!/bin/bash

# Check argument count
if [ "$#" -ne 1 ]; then
    echo "Error: Provide exactly one log file"
    exit 1
fi

logfile="$1"

# Check file exists and readable
if [ ! -f "$logfile" ] || [ ! -r "$logfile" ]; then
    echo "Error: File does not exist or is not readable"
    exit 1
fi

# Count total entries
total=$(wc -l < "$logfile")

# Count log levels
info=$(grep -c " INFO " "$logfile")
warning=$(grep -c " WARNING " "$logfile")
error=$(grep -c " ERROR " "$logfile")

# Most recent ERROR
last_error=$(grep " ERROR " "$logfile" | tail -n 1)

# Display output
echo "Total entries: $total"
echo "INFO count: $info"
echo "WARNING count: $warning"
echo "ERROR count: $error"
echo "Most recent ERROR:"
echo "$last_error"

# Create report file
date=$(date +%Y-%m-%d)
report="logsummary_$date.txt"

{
    echo "Log Summary Report"
    echo "Date: $date"
    echo "Total entries: $total"
    echo "INFO: $info"
    echo "WARNING: $warning"
    echo "ERROR: $error"
    echo "Most recent ERROR:"
    echo "$last_error"
} > "$report"

echo "Report generated: $report"

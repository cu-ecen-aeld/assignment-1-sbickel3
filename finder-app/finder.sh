#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Error: Missing arguments."
    echo "Usage: $0 <directory> <string>"
    exit 1
fi

filesdir="$1"
searchstr="$2"

if [ -d "$filesdir" ]; then
    numberOfFiles=$( find "$filesdir" -type f 2>/dev/null | wc -l )
    numberOfMatches=$( grep -r "$searchstr" "$filesdir" 2>/dev/null | wc -l )
    echo "The number of files are $numberOfFiles and the number of matching lines are $numberOfMatches"
else
    echo "Error: '$filesdir' does not exist or is not a directory."
    exit 1
fi

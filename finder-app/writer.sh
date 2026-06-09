#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Error: Missing arguments."
    echo "Usage: $0 <path to file> <string>"
    exit 1
fi

writefile="$1"
writestr="$2"

# remove trailing slashes
sanitized_path="${writefile%/}"

# retrieve filename after last slash
base_name="${sanitized_path##*/}"

# check if sanitized path is just a directory
if [ -d "$sanitized_path" ]; then
	echo "Error: path is a directory not a path to a file"
	exit 1
fi

# check if filename was provided
if [ -z "$base_name" ]; then
    echo "Error: The provided string does not contain a valid filename."
    exit 1
fi

# Extract the directory portion of the path
dir_path="${sanitized_path%/*}"

# Create the parent folders if they don't exist yet
if [ "$dir_path" != "$sanitized_path" ]; then
    mkdir -p "$dir_path"
    if ! mkdir -p "$dir_path"; then
        echo "Error: Failed to create directory structure '$dir_path'."
        exit 1
    fi
fi

if echo "$writestr" > "$sanitized_path"; then
    echo "Success: Content written to $sanitized_path"
else
    echo "Error: Failed to create or write to the file '$sanitized_path'."
    echo "Possible reasons: Permission denied, disk full, or read-only filesystem."
    exit 1
fi


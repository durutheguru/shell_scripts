#!/bin/bash

# Check if a directory is provided as an argument
if [ -z "$1" ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# Set the target directory
TARGET_DIR="$1"

# Use find to get all files, du to get their sizes, and sort to order them
find "$TARGET_DIR" -type f -exec du -h {} + | sort -hr
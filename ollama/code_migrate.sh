#!/bin/bash


# Function to generate file description using Ollama model
generate_description() {
    local file_content=$1
    description=$(ollama run "llama3.1" "Generate an elaborate comment description for this file, using multi-line comment appropriate for the file type syntax: $file_content")
    echo -e "\n$description"
}

# Function to replace watch words in a file
replace_watch_words() {
    local content=$1
    local swap_file=$2
    while IFS= read -r line; do
        key=$(echo "$line" | cut -d'=' -f1)
        value=$(echo "$line" | cut -d'=' -f2)
        content=$(echo "$content" | sed "s/$key/$value/gI")
    done < "$swap_file"
    echo "$content"
}

# Function to process files
process_files() {
    local source=$1
    local destination=$2
    local include_comments=$3
    local replace_words=$4
    local swap_file=$5

    mkdir -p "$destination"

    find "$source" -type f | while read -r file; do
        if [[ 
            "$file" == *".git"* || 
            "$file" == *".idea"* || 
            "$file" == *".vscode"* || 
            "$file" == *".DS_Store"* || 
            "$file" == *"target"*
         ]]; then
            continue
        fi
        
        echo -e "\n\nProcessing File: $file"

        relative_path="${file#$source/}"
        echo "Relative Path: $relative_path"

        # Replace watch words in folder names if needed
        if [ "$replace_words" == "yes" ] && [ -n "$swap_file" ]; then
            relative_path=$(replace_watch_words "$relative_path" "$swap_file")
        fi

        dest_file="$destination/$relative_path"
        echo "Destination File: $dest_file"
        mkdir -p "$(dirname "$dest_file")"
        
        file_content=$(cat "$file")

        if [ "$replace_words" == "yes" ] && [ -n "$swap_file" ]; then
            file_content=$(replace_watch_words "$file_content" "$swap_file")
        fi

        if [ "$include_comments" == "yes" ]; then
            description=$(generate_description "$file_content")
            echo -e "$description\n\n$file_content" > "$dest_file"
        else
            echo "$file_content" > "$dest_file"
        fi
    done
}

# Get inputs
read -p "Enter source folder: " source_folder
read -p "Enter destination folder: " destination_folder
read -p "Include comments in destination (yes/no): " include_comments
read -p "Replace watch words in destination (yes/no): " replace_watch_words
swap_file=""

if [ "$replace_watch_words" == "yes" ]; then
    read -p "Enter path to .swap file: " swap_file
fi

# Validate inputs
if [ ! -d "$source_folder" ]; then
    echo "Error: Source folder does not exist."
    exit 1
fi

if [ "$replace_watch_words" == "yes" ] && [ ! -f "$swap_file" ]; then
    echo "Error: Swap file does not exist."
    exit 1
fi

# Process files
process_files "$source_folder" "$destination_folder" "$include_comments" "$replace_watch_words" "$swap_file"

echo "Files copied successfully."

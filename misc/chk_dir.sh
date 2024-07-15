#!/bin/bash


## This bash script defines two functions `check_file` and 
 ## `check_directory` and then proceeds to check for sensitive 
 ## information in files within a specified directory. Here's a breakdown 
 ## of what the script does:
 ## 
 ## 1. `check_file()` function:
 ## - Takes a file path as an argument and assigns it to the `file` 
 ## variable.
 ## - Defines an array `patterns` containing sensitive keywords or 
 ## patterns to search for in the file.
 ## - Iterates over each pattern in the `patterns` array and uses `grep` 
 ## to check if any of the patterns exist in the file.
 ## - If a sensitive pattern is found in the file, it prints a message 
 ## indicating that sensitive information was found and returns from the 
 ## function.
 ## 
 ## 2. `check_directory()` function:
 ## - Takes a directory path as an argument and assigns it to the 
 ## `directory` variable.
 ## - Iterates over the items (files and subdirectories) in the specified 
 ## directory.
 ## - Recursively calls `check_directory` if the item is a subdirectory.
 ## - Calls `check_file` if the item is a file.
 ## 
 ## 3. Main script flow:
 ## - Checks if the script is provided with exactly one argument (the 
 ## directory to check). If not, it displays a usage message and exits.
 ## - Confirms that the provided argument is a valid directory. If not, 
 ## it displays an error message and exits.
 ## - Starts the checking process by calling `check_directory` with the 
 ## specified directory as an argument.
 ## - Upon completion of the directory check, it prints a message 
 ## indicating that the check is completed.
 ## 
 ## Overall, this script is designed to search for potentially sensitive 
 ## information in files within a specified directory recursively and 
 ## provides feedback on any findings.

check_file() {
    local file=$1

    local patterns=(
        "password"
        "passwd"
        "secret"
        "key"
        "account"
        "token"
        "API_KEY"
        "PRIVATE_KEY"
        "[0-9]{7,}"
    )

    for pattern in "${patterns[@]}"; do
        if grep -Eqi "$pattern" "$file"; then
            echo "Sensitive information found in file: $file"
            return
        fi
    done
}

# Function to recursively check a directory
check_directory() {
    local directory=$1

    # Iterate over all files and subdirectories
    for item in "$directory"/*; do
        if [ -d "$item" ]; then
            check_directory "$item"
        elif [ -f "$item" ]; then
            check_file "$item"
        fi
    done
}

# Check if directory is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# Check if the provided argument is a directory
if [ ! -d "$1" ]; then
    echo "Error: '$1' is not a directory."
    exit 1
fi

# Start checking the directory
check_directory "$1"

echo "Check completed."



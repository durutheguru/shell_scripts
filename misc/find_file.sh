#!/bin/bash


## This bash script is designed to search for a specified filename 
 ## within a specified directory. It takes two arguments: the directory 
 ## path and the filename to search for. Here is a breakdown of what the 
 ## script does:
 ## 
 ## 1. The `usage` function is defined to display the correct usage of 
 ## the script if the arguments are not provided correctly.
 ## 
 ## 2. It checks if two arguments are provided; if not, it calls the 
 ## `usage` function and exits the script.
 ## 
 ## 3. It assigns the provided directory path and filename to variables.
 ## 
 ## 4. It checks if the specified directory exists. If not, it outputs an 
 ## error message and exits the script.
 ## 
 ## 5. It uses the `find` command to search for the specified filename 
 ## within the specified directory and stores the results in a variable 
 ## called `results`.
 ## 
 ## 6. It checks if the `find` command was successful by inspecting the 
 ## exit code. If not, it outputs an error message and exits the script.
 ## 
 ## 7. If no files were found with the specified filename, it outputs a 
 ## message stating that the file was not found. Otherwise, it displays 
 ## the list of files that match the filename within the specified 
 ## directory.
 ## 
 ## Overall, this script provides a simple way to search for a specific 
 ## file in a directory and display the results.

# Function to display usage
usage() {
    echo "Usage: $0 <directory> <filename>"
    exit 1
}

# Check if the correct number of arguments is provided
if [ $# -ne 2 ]; then
    usage
fi

# Assigning input arguments to variables
directory=$1
filename=$2

# Check if the specified directory exists
if [ ! -d "$directory" ]; then
    echo "Error: Directory '$directory' does not exist."
    exit 1
fi

# Search for the file and store results
results=$(find "$directory" -type f -name "$filename")

# Check if the find command was successful
if [ $? -ne 0 ]; then
    echo "Error: An error occurred while searching for the file."
    exit 1
fi

# If no files were found
if [ -z "$results" ]; then
    echo "File '$filename' not found in directory '$directory'."
else
    echo "Found the following files:"
    echo "$results"
fi


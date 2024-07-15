#!/bin/bash


## This bash script performs a validation check on YAML files in a 
 ## specified directory using the tool `yq`. Here is a breakdown of what 
 ## the script does:
 ## 
 ## 1. It checks if the `yq` command is available by attempting to locate 
 ## it.
 ## 2. If `yq` is not found, it displays a message asking the user to 
 ## install it and exits with a status of 1.
 ## 3. It checks if a directory path is provided as an argument when 
 ## running the script. If not, it displays a usage message and exits 
 ## with a status of 1.
 ## 4. It assigns the provided directory path to a variable called 
 ## `DIRECTORY`.
 ## 5. It checks if the provided path is a directory. If not, it displays 
 ## an error message and exits with a status of 1.
 ## 6. It uses the `find` command to search for YAML files within the 
 ## specified directory.
 ## 7. For each YAML file found, it runs `yq` to parse and extract the 
 ## content of the file. It redirects any output to `/dev/null` to 
 ## suppress it.
 ## 8. It checks the exit status of the `yq` command. If the command 
 ## fails, it displays a message indicating that validation failed for 
 ## the file. If successful, it displays a message indicating that 
 ## validation succeeded for the file.
 ## 
 ## Overall, this script validates YAML files in a directory using `yq` 
 ## and provides feedback on the validation status for each file 
 ## processed.

if ! command -v yq &> /dev/null
then
    echo "yq could not be found. Please install it."
    exit 1
fi

if [ -z "$1" ]
then
    echo "Usage: $0 <path_to_directory>"
    exit 1
fi

DIRECTORY=$1

if [ ! -d "$DIRECTORY" ]
then
    echo "The provided path is not a directory."
    exit 1
fi

find "$DIRECTORY" -type f -name "*.yml" | while read -r file; do
    yq e '.' "$file" > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo "Validation failed for $file"
    else
        echo "Validation succeeded for $file"
    fi
done

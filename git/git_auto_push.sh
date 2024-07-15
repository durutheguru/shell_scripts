#!/bin/bash


## This bash script performs the following tasks:
 ## 
 ## 1. Validates the input parameters: It checks whether an input file is 
 ## provided as an argument. If no input file is given, it displays a 
 ## usage message and exits with an error code.
 ## 
 ## 2. Checks if the input file exists: It verifies that the input file 
 ## exists and is a regular file. If the file doesn't exist or is not a 
 ## regular file, it displays an error message and exits with an error 
 ## code.
 ## 
 ## 3. Reads each line from the input file: It reads each line from the 
 ## input file (which is expected to contain a list of directories) and 
 ## performs the following actions for each directory:
 ## 
 ## - Skips blank lines: If a line in the input file is empty, it 
 ## skips processing that line.
 ## - Validates that the directory is a git repository: It verifies if 
 ## the directory contains a `.git` subdirectory. If the directory is not 
 ## a git repository, it displays an error message and exits with an 
 ## error code.
 ## 
 ## 4. Appends a cron job: It appends a new cron job to the current 
 ## user's crontab. The cron job is scheduled to run every 30 minutes and 
 ## executes a script (`git_cron_push.sh`) with the input file path as an 
 ## argument. The output of the cron job is redirected to a log file.
 ## 
 ## 5. Updates the crontab: It updates the user's crontab with the newly 
 ## added cron job.
 ## 
 ## Overall, this script is designed to validate input, check directories 
 ## for `.git` repositories, and set up a scheduled task to periodically 
 ## run a script that pushes changes in the listed git repositories.

# Validate that the input file exists and contains a list of directories
if [ $# -ne 1 ]; then
    echo "Usage: $0 <input_file>"
    exit 1
fi

input_file="$1"
if [ ! -f "$input_file" ]; then
    echo "Error: Input file '$input_file' does not exist or is not a file."
    exit 1
fi

while IFS= read -r dir || [ -n "$dir" ]; do
    # Skip blank lines
    if [[ -z "$dir" ]]; then
        continue
    fi

    # Validate that the directory is a git repository
    if [ ! -d "$dir/.git" ]; then
        echo "Error: Directory '$dir' is not a git repository."
        exit 1
    fi
done < "$input_file"


crontab -l | { cat; echo "*/30 * * * * /usr/local/bin/git_cron_push.sh $(pwd)/$input_file >> ~/.cron.log 2>&1" ;} | crontab -


#!/bin/bash


## This bash script accepts an input file as an argument containing a 
 ## list of directory paths. 
 ## 
 ## The script first validates the input file and ensures it exists and 
 ## is a file. Then, it iterates over each directory in the input file, 
 ## checking if it is a git repository by verifying the presence of a 
 ## `.git` directory within it.
 ## 
 ## Afterward, the script loops through each directory again and checks 
 ## for any changes that need to be pushed to the remote repository. If 
 ## there are changes, the script sets the Git user name and email, 
 ## stages the changes, commits them, pulls from the remote repository, 
 ## and pushes the changes. If there are no changes to push, it prints a 
 ## message indicating there are no changes.
 ## 
 ## Overall, the script automates the process of checking for changes in 
 ## multiple directories and pushing them to remote repositories if there 
 ## are any modifications.



if [ -z "${GIT_USER_NAME}" ]; then
    echo "environment variable GIT_USER_NAME is not set or is empty"
    exit 1
fi


if [ -z "${GIT_EMAIL}" ]; then
    echo "environment variable GIT_EMAIL is not set or is empty"
    exit 1
fi


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

while IFS= read -r dir; do
    # Skip blank lines
    if [[ "$dir" =~ ^[[:space:]]*$ ]]; then
        continue
    fi

    # Validate that the directory is a git repository
    if [ ! -d "$dir/.git" ]; then
        echo "Error: Directory '$dir' is not a git repository."
        exit 1
    fi
done < "$input_file"


# Loop through all directories and check for changes to push
while IFS= read -r dir; do
    cd "$dir" || continue
    if [ "$(git status --porcelain)" ]; then
        # Commit and push changes
        git config --global user.name "$GIT_USER_NAME"
        git config --global user.email "$GIT_EMAIL"
        git diff --name-status | awk '$1 == "M" {print "Updated: "$2} $1 == "A" {print "Created: "$2}' | git commit -aF -
        git pull origin "$(git branch --show-current)"
        git push origin "$(git branch --show-current)"
    else
        echo "No changes to push in dir $dir"
    fi
    cd - >/dev/null || continue
done < "$input_file"



#!/bin/bash


## This bash script is intended to search for files containing a 
 ## specific text within a specified directory. Here is a breakdown of 
 ## what the script does:
 ## 
 ## 1. It checks the number of arguments provided when running the 
 ## script. If the number of arguments is not equal to 2, it prompts the 
 ## user to enter the search directory and the text to search for.
 ## 
 ## 2. If two arguments are provided when running the script, it assigns 
 ## the first argument as the search directory and the second argument as 
 ## the text to search for.
 ## 
 ## 3. It then uses the `find` command to search for files within the 
 ## specified directory (`SEARCH_DIR`) and executes the `grep` command to 
 ## search for the specified text (`SEARCH_TEXT`) within those files.
 ## 
 ## 4. The `-type f` option in the `find` command ensures that only 
 ## regular files (not directories or other types of files) are 
 ## considered in the search.
 ## 
 ## 5. The `-exec grep -l "$SEARCH_TEXT" {} +` part of the script tells 
 ## `find` to execute the `grep` command with the specified text search 
 ## in the found files. The `-l` option in `grep` is used to only print 
 ## the names of files that contain the search text.
 ## 
 ## Therefore, this script provides a simple way to search for files 
 ## containing a specific text within a directory.

if [ "$#" -ne 2 ]; then
    echo "Simple Usage: $0 [directory] [text_to_search]"

    read -p "Enter Search Directory: " SEARCH_DIR
    read -p "Enter text to find: " SEARCH_TEXT
else
    SEARCH_DIR=$1

    SEARCH_TEXT=$2
fi


find "$SEARCH_DIR" -type f -exec grep -l "$SEARCH_TEXT" {} +


#!/bin/bash


## This bash script prompts the user to input a file name and then uses 
 ## the `find` command to search the entire filesystem (`/`) for files 
 ## with the input name. The search results are displayed on the standard 
 ## output. Any error messages that occur during the search are 
 ## redirected to `/dev/null`, effectively hiding them from the user. 
 ## Additionally, the script runs with elevated privileges by using 
 ## `sudo`.

read -p "Enter File Name: " file_name

sudo find / -name $file_name 2>/dev/null

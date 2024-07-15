#! /bin/bash


## This bash script is a simple script that iterates over all files in 
 ## the specified directory `~/VSCode/Private/scripts/bash/` and prints 
 ## out the path of each file to the terminal. The script uses a `for` 
 ## loop to loop through each file in the specified directory 
 ## (`~/VSCode/Private/scripts/bash/`) and then uses the `echo` command 
 ## to print out the file path (`$FILE`) to the terminal.
 ## 
 ## Overall, the script lists the paths of all files in the specified 
 ## directory.


for FILE in ~/VSCode/Private/scripts/bash/*; do echo $FILE; done


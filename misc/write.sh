#! /bin/bash


## This Bash script prompts the user to enter a commit message and then 
 ## reads the input provided. It then asks the user to input the name of 
 ## the file to which the input text will be written. The script appends 
 ## the input text to the specified file and then displays a message 
 ## confirming that the contents have been successfully written to the 
 ## file.


echo "Type Commit Message. Ctrl+D to save... "

txt=$(cat)


read -p "Enter file to write: " file

echo $txt >> $file

echo "contents successfully written to $file"


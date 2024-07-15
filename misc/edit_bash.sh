#! /bin/bash


## This bash script prompts the user to type text that will be appended 
 ## to the ~/.bash_profile file. The script reads the input text provided 
 ## by the user and stores it in the variable "text". Then, it appends 
 ## the contents of the "text" variable to the end of the ~/.bash_profile 
 ## file using the '>>' redirection operator. This allows the user to 
 ## easily add custom text to their ~/.bash_profile file using this 
 ## script.


echo "Type Text to append to ~/.bash_profile"

text=$(cat)


echo $text >> ~/.bash_profile





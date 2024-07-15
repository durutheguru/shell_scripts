#!/bin/bash


## This bash script prompts the user to enter a command and then it 
 ## captures the command input. It then retrieves the current directory 
 ## path using the "pwd" command and stores it in the variable "dir". 
 ## 
 ## Next, the script uses the "osascript" command, which allows running 
 ## AppleScript from the command line, to execute a block of AppleScript 
 ## code enclosed within "<<END" and "END" delimiters. The AppleScript 
 ## code executed by this bash script opens a new Terminal window and 
 ## runs the command entered by the user after changing the directory to 
 ## the directory captured earlier in the script.
 ## 
 ## In summary, this script enables a user to input a command, and the 
 ## script will run the command in a new Terminal window after switching 
 ## to the current directory.

read -p "Enter Command: " command

dir=$(pwd)

osascript <<END 
tell application "Terminal"
    do script "cd $dir && $command"
end tell
END

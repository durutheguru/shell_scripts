#!/bin/bash


## This bash script performs the following actions:
 ## 
 ## 1. Prints the current working directory using the `pwd` command.
 ## 2. Displays the status of the local git repository using the `git 
 ## status` command.
 ## 3. Asks the user if they wish to add the files to the git staging 
 ## area. If the user enters 'n', the script exits; otherwise, it adds 
 ## all files using `git add .`
 ## 4. Prompts the user to provide a commit message by reading input 
 ## until Ctrl+D is pressed. 
 ## 5. Asks the user if they wish to commit the changes. If the user 
 ## enters 'n', the script exits; otherwise, it commits the changes using 
 ## `git commit -m "$msg"`, where `$msg` is the commit message provided 
 ## by the user.
 ## 6. Asks the user if they wish to push the changes upstream. If the 
 ## user enters 'n', the script exits; otherwise, it pushes the changes 
 ## to the remote repository using `git push origin HEAD`.
 ## 7. Displays "Done!!" to indicate that the script has completed its 
 ## execution.

pwd

git status

read -p "Do you wish to add the files? (y/n) " proceed

[ $proceed == "n" ] && exit 1 || git add .


echo "Type Commit Message. Ctrl+D to save... "

msg=$(cat)

read -p "Do you wish to Commit changes? (y/n) " proceed


[ $proceed == "n" ] && exit 1 || git commit -m "$msg"


read -p "Do you wish to push changes upstream? (y/n) " proceed

[ $proceed == "n" ] && exit 1 || git push origin HEAD


echo "Done!!"



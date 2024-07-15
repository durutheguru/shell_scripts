#! /bin/bash


## This bash script prompts the user to enter a remote Git URL, 
 ## initializes a Git repository in the current directory, sets the 
 ## remote origin to the URL provided by the user, and then executes a 
 ## script located at `/usr/local/bin/git_commit_push.sh`. The script is 
 ## likely designed to automate the process of setting up a new Git 
 ## repository with a remote origin and triggering an initial commit and 
 ## push to the remote repository.


read -p "Enter remote Git URL: " gitUrl

git init

git remote add origin $gitUrl

/usr/local/bin/git_commit_push.sh



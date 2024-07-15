#! /bin/bash


## This bash script performs the following actions:
 ## 
 ## 1. Retrieves the name of the current git branch and assigns it to the 
 ## variable `branch` using the `git rev-parse --abbrev-ref HEAD` command.
 ## 2. Switches to the `master` branch using `git checkout master`.
 ## 3. Pulls the latest changes from the remote repository's `master` 
 ## branch using `git pull origin master`.
 ## 4. Switches to the `main` branch using `git checkout main`.
 ## 5. Pulls the latest changes from the remote repository's `main` 
 ## branch using `git pull origin main`.
 ## 6. Deletes the local branch that was saved in the variable `branch` 
 ## using `git branch -d $branch`.
 ## 
 ## Overall, this script is designed to switch to both the `master` and 
 ## `main` branches, pull the latest changes from their respective remote 
 ## branches, and then delete the local branch that was originally 
 ## checked out before switching.

branch=$(git rev-parse --abbrev-ref HEAD)


git checkout master
git pull origin master

git checkout main
git pull origin main

git branch -d $branch



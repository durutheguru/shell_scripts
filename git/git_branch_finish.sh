#! /bin/bash


## This bash script does the following:
 ## 
 ## 1. It first gets the current branch name using the `git rev-parse 
 ## --abbrev-ref HEAD` command.
 ## 2. It then extracts the branch type and name from the full branch 
 ## name by removing the slash-separated parts using substitution.
 ## 3. It uses the extracted branch type and name to perform a git flow 
 ## finish operation on that branch using the `git flow $branch_type 
 ## finish $branch` command.
 ## 4. Finally, it pulls changes from the remote `master` and `main` 
 ## branches using the `git pull origin master` and `git pull origin 
 ## main` commands, respectively.
 ## 
 ## In summary, this script automates the process of finishing a feature 
 ## or release branch using git flow and then pulls the latest changes 
 ## from the `master` and `main` branches.

branch=$(git rev-parse --abbrev-ref HEAD)

branch_type=$(echo ${branch/\/*})
branch=$(echo ${branch/*\/})

git flow $branch_type finish $branch

git pull origin master
git pull origin main


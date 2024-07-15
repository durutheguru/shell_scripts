#! /bin/bash


## This bash script takes a patch name as a command line argument. If 
 ## the script is executed with an argument, the patch name is set to the 
 ## provided argument. Otherwise, if no argument is provided, the script 
 ## will prompt the user to enter a patch name using the "read" command.
 ## 
 ## After obtaining the patch name, the script then proceeds to execute 
 ## the following Git commands:
 ## 1. `git flow hotfix start $patch_name`: This command initiates a new 
 ## hotfix branch with the specified patch name.
 ## 2. `git pull origin master`: This command pulls the changes from the 
 ## remote Git repository's "master" branch to the local repository to 
 ## ensure the hotfix branch is up to date.
 ## 3. `git pull origin develop`: This command pulls the changes from the 
 ## remote Git repository's "develop" branch to the local repository to 
 ## synchronize any changes made to the develop branch before starting 
 ## the hotfix.
 ## 
 ## Overall, this script automates the process of starting a hotfix 
 ## branch in a Git repository and ensures that the local repository is 
 ## up to date with the latest changes from the master and develop 
 ## branches.


if [ $# -lt 1 ];
then
    read -p "Enter Patch Name: " patch_name
else 
    patch_name=${1}
fi


git flow hotfix start $patch_name

git pull origin master

git pull origin develop


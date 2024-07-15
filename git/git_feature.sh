#! /bin/bash


## This Bash script checks if an argument is provided when running the 
 ## script. If no argument is provided, it prompts the user to enter a 
 ## "Feature Name." Otherwise, it uses the first argument provided as the 
 ## feature name.
 ## 
 ## After determining the feature name, the script executes the following 
 ## commands:
 ## 
 ## 1. `git flow feature start $feature_name`: This command uses Git Flow 
 ## to start a new feature branch with the specified feature name.
 ## 
 ## 2. `git pull origin master`: This command pulls changes from the 
 ## remote repository's master branch to the local repository to ensure 
 ## you have the latest changes before starting the new feature.
 ## 
 ## Overall, this script is used to streamline the process of starting a 
 ## new feature branch in a Git repository using Git Flow practices.


if [ $# -lt 1 ];
then
    read -p "Enter Feature Name: " feature_name
else 
    feature_name=${1}
fi


git flow feature start $feature_name

git pull origin master


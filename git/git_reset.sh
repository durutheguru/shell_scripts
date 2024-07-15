#!/bin/bash


## This bash script is a simple script that uses the git command to 
 ## unstage changes to the current working directory. The script executes 
 ## the "git restore --staged" command, which will unstage any changes 
 ## that have been added to the staging area but not committed. The "." 
 ## at the end of the command indicates that it will unstage changes in 
 ## the current directory.

git restore --staged .


#! /bin/bash


## This bash script does the following:
 ## 
 ## 1. It starts with the shebang line `#! /bin/bash` indicating that the 
 ## script should be run using the Bash shell.
 ## 
 ## 2. The script executes the command `brew services stop mysql`. This 
 ## command is used to stop the MySQL service managed by Homebrew. 
 ## Homebrew is a package manager for macOS that allows you to easily 
 ## install, manage, and update software packages.
 ## 
 ## Therefore, this script stops the MySQL service running on the system 
 ## using Homebrew.

brew services stop mysql


#! /bin/bash


## This bash script stops the MongoDB Community version 4.4 service 
 ## using Homebrew. The `brew services stop` command is used to stop a 
 ## background service managed by Homebrew, in this case specifically 
 ## targeting the MongoDB Community version 4.4 service. When the script 
 ## is executed in a terminal, it will initiate the process to stop the 
 ## MongoDB service.

brew services stop mongodb-community@4.4

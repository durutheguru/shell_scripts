#!/bin/bash


## This bash script performs the following actions when executed:
 ## 
 ## 1. Extracts the contents of the tar file passed as an argument to the 
 ## script using the `tar` command and the `${1}` variable.
 ## 2. Moves the extracted directory (which is assumed to be the same 
 ## name as the tar file without the `.tar` extension) to the 
 ## `~/IdeaProjects/Private/Learning` directory using the `mv` command. 
 ## The `${1%.*}` variable removes the `.tar` extension from the filename.
 ## 3. Changes the working directory to the moved directory in 
 ## `~/IdeaProjects/Private/Learning` using the `cd` command.
 ## 4. Opens IntelliJ IDEA Community Edition by using the `open` command 
 ## with the `-na` flag to start a new application and specifying the 
 ## path to launch IntelliJ IDEA from `"IntelliJ IDEA CE.app"` with the 
 ## argument `.` (current directory).
 ## 
 ## In summary, this script extracts the contents of a tar file, moves 
 ## the extracted directory to a specific location, changes to that 
 ## directory, and then opens IntelliJ IDEA Community Edition to work 
 ## with the extracted files.

tar -xf ${1}
mv ${1%.*} ~/IdeaProjects/Private/Learning
cd ~/IdeaProjects/Private/Learning/${1%.*}
open -na "IntelliJ IDEA CE.app" --args "."


#! /bin/bash


## This bash script is using the `open` command in macOS to launch 
 ## IntelliJ IDEA Community Edition. The `-na` flag is used to open a new 
 ## instance of the application even if one is already running. The 
 ## `--args "$@"` part is passing any command-line arguments provided to 
 ## the script on to IntelliJ IDEA. This script essentially opens 
 ## IntelliJ IDEA CE with any additional arguments provided when the 
 ## script is executed.

open -na "IntelliJ IDEA CE.app" --args "$@"


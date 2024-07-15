#! /bin/bash


## This bash script starts by sourcing the `.bash_profile` file using 
 ## the `source` command, which loads the environment settings and 
 ## aliases specified in that file. 
 ## 
 ## After that, it executes the `bash -l` command. The `-l` flag tells 
 ## bash to act as if it had been invoked as a login shell, which means 
 ## it will execute the commands from the login scripts such as 
 ## `.bash_profile` and `.bashrc`, in addition to the default ones.
 ## 
 ## In summary, this script ensures that the environment is properly set 
 ## up by loading the `.bash_profile` file and then starts a new bash 
 ## session with the same environment settings by using the `bash -l` 
 ## command.

source ~/.bash_profile
bash -l



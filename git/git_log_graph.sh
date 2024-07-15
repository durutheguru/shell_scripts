#! /bin/bash


## This bash script runs the `git log` command with specific formatting 
 ## options. 
 ## 
 ## The command `git log` is used to display commit logs. In this script, 
 ## the `--pretty=format:"%h %s"` option specifies the format of the log 
 ## output. Here, `%h` represents the abbreviated commit hash and `%s` 
 ## represents the commit subject. 
 ## 
 ## The `--graph` option is used to draw a text-based graphical 
 ## representation of the commit history, showing the relationship 
 ## between commits. 
 ## 
 ## So, when you run this script, it will display the abbreviated commit 
 ## hash, commit subject, and a graphical representation of the commit 
 ## history in your Git repository.

git log --pretty=format:"%h %s" --graph


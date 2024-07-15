#! /bin/bash


## This bash script initializes a Spring Boot application based on user 
 ## inputs. It first lists the available Spring Boot project templates 
 ## using the `spring init --list` command. 
 ## 
 ## Then, it prompts the user to enter the Java version, artifact 
 ## (project name), group ID, description, and dependencies required for 
 ## the Spring Boot project.
 ## 
 ## After obtaining these inputs, the script calls `spring init` with the 
 ## provided parameters to generate a new Spring Boot project. The 
 ## parameters used in the second `spring init` command are as follows:
 ## - `-a="$artifact"`: Specifies the artifact or project name
 ## - `-g="$group"`: Specifies the group ID for the project
 ## - `--build=maven`: Specifies that Maven should be used as the build 
 ## system
 ## - `--description="$description"`: Specifies the description for the 
 ## project
 ## - `-j=$javaVersion`: Specifies the Java version to be used
 ## - `-n="$artifact"`: Specifies the name of the project
 ## - `-d="$dependencies"`: Specifies the dependencies required for the 
 ## project
 ## - `$artifact`: Specifies the final argument, which is the artifact 
 ## (project name) again
 ## 
 ## Overall, this script automates the process of setting up a new Spring 
 ## Boot project by collecting necessary information from the user and 
 ## running the appropriate `spring init` command to create the project 
 ## with the specified configurations.


spring init --list

read -p "java version: " javaVersion
read -p "artifact: " artifact
read -p "group: " group
read -p "description: " description
read -p "dependencies: " dependencies

spring init -a="$artifact" -g="$group" --build=maven --description="$description" -j=$javaVersion -n="$artifact" -d="$dependencies" $artifact


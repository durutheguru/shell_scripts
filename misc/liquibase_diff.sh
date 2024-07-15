#! /bin/bash


## This bash script first checks if the number of arguments provided 
 ## when running the script is equal to 1. If there is only one argument, 
 ## it assigns the value of this argument to the variable `diff_file`. If 
 ## there are no arguments or more than one argument, it prompts the user 
 ## to enter the name of a Diff XML file, and assigns that input to the 
 ## variable `diff_file`.
 ## 
 ## After getting the `diff_file` value, the script then executes two 
 ## Maven commands in sequence using `mvn`. The goal of the first `mvn` 
 ## command is to clean, compile, and run Liquibase's `diff` command with 
 ## the `-DdiffChangeLogFile` parameter set to the value of the 
 ## `diff_file` variable. It also specifies an external settings file 
 ## `settings.xml` for Maven.
 ## 
 ## If the first `mvn` command fails (indicated by the `||` operator), 
 ## the script will then execute a second `mvn` command with the same 
 ## parameters as the first one. This is done as a fallback in case the 
 ## first command encounters an error.
 ## 
 ## In summary, this script is designed to run Maven goals to clean, 
 ## compile, and perform a Liquibase diff operation using a provided or 
 ## user-input Diff XML file.


if [ $# == 1 ];
then
  diff_file=${1}
else
  read -p "Enter Diff xml: " diff_file
fi

mvn clean compile liquibase:diff -DdiffChangeLogFile=$diff_file -s settings.xml || mvn clean compile liquibase:diff -DdiffChangeLogFile=$diff_file



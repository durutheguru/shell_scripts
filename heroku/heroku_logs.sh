#! /bin/bash


## This bash script uses conditional logic to determine the value of the 
 ## variable `app_name`. Here's a breakdown of what it does:
 ## 
 ## 1. If there is at least one argument passed to the script (checked 
 ## with `[ $# -ge 1 ]`), the script assigns the value of the first 
 ## argument to the variable `app_name`.
 ## 2. If no argument is provided when invoking the script, it prompts 
 ## the user to enter an application name using the `read` command and 
 ## stores the input in the `app_name` variable.
 ## 3. Finally, the script uses the `heroku logs --tail -a $app_name` 
 ## command to tail the logs for the Heroku application specified by the 
 ## value of the `app_name` variable.
 ## 
 ## In summary, this script allows a user to specify an application name 
 ## as input or as a command line argument and then uses the Heroku CLI 
 ## to tail the logs of that specific application.


if [ $# -ge 1 ];
then 
  app_name=${1}
else 
  read -p "Enter Application Name: " app_name
fi


heroku logs --tail -a $app_name


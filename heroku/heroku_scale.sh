#! /bin/bash


## This bash script checks if it receives at least two arguments when it 
 ## is run. If it does, it assigns the first argument to the variable 
 ## `app_name` and the second argument to the variable `scale`. If not 
 ## enough arguments are provided, it prompts the user to enter the 
 ## application name and the scale size. 
 ## 
 ## After collecting the required information (either from arguments or 
 ## user input), the script then uses the Heroku command `heroku 
 ## ps:scale` to scale the application's web dynos to the specified size 
 ## (given by `scale`) for the specified application (given by 
 ## `app_name`).


if [ $# -ge 2 ];
then
    app_name=${1}
    scale=${2}
else
    read -p "Enter Application Name: " app_name
    read -p "Enter Scale Size: " scale
fi


heroku ps:scale web=$scale -a $app_name


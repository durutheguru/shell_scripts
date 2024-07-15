#!/bin/bash


## This bash script performs the following tasks:
 ## 
 ## 1. It defines a function called `prompt_and_set`, which prompts the 
 ## user to enter a value for a specified variable and sets it as an 
 ## environment variable.
 ## 
 ## 2. It checks if the environment variable `PROJECT` is set. If it is 
 ## not set, it calls the `prompt_and_set` function to prompt the user to 
 ## enter the value for `PROJECT`.
 ## 
 ## 3. It checks if the environment variable `INSTANCE` is set. If it is 
 ## not set, it calls the `prompt_and_set` function to prompt the user to 
 ## enter the value for `INSTANCE`.
 ## 
 ## 4. It displays the values of the `PROJECT` and `INSTANCE` environment 
 ## variables.
 ## 
 ## 5. It checks the number of arguments passed to the script. If at 
 ## least one argument is passed, it sets the variable `table_name` to 
 ## the first argument. Otherwise, it lists the tables in the specified 
 ## project and instance, prompts the user to enter the table name, and 
 ## sets `table_name` accordingly.
 ## 
 ## 6. It checks if at least two arguments are passed. If so, it sets the 
 ## variable `key` to the second argument. Otherwise, it prompts the user 
 ## to enter the key.
 ## 
 ## 7. Lastly, it uses the `cbt` command with the specified project, 
 ## instance, table name, and key to perform a lookup operation.
 ## 
 ## Overall, this script prompts the user to set values for the `PROJECT` 
 ## and `INSTANCE` environment variables if they are not already set, 
 ## allows the user to specify the table name and key either through 
 ## arguments or interactive prompts, and performs a lookup operation 
 ## using the `cbt` command with the specified parameters.

# Function to prompt user for input and set environment variable
prompt_and_set() {
    local var_name=$1
    local var_value

    read -p "Please enter the value for $var_name: " var_value
    export $var_name=$var_value
}

# Check if PROJECT is set
if [ -z "$PROJECT" ]; then
    prompt_and_set "PROJECT"
else
    echo "Environment variable PROJECT is already set to $PROJECT"
fi

# Check if INSTANCE is set
if [ -z "$INSTANCE" ]; then
    prompt_and_set "INSTANCE"
else
    echo "Environment variable INSTANCE is already set to $INSTANCE"
fi

# Display the values of the environment variables
echo "PROJECT = $PROJECT"
echo "INSTANCE = $INSTANCE"


if [ $# -ge 1 ];
then
    table_name=$1
else 
    cbt -project $PROJECT -instance $INSTANCE ls
    read -p "Please enter table name: " table_name
fi

if [ $# -ge 2 ];
then
    key=$2
else 
    read -p "Please enter key: " key
fi


cbt -project $PROJECT -instance $INSTANCE lookup $table_name $key

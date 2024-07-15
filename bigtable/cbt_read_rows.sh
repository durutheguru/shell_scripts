#!/bin/bash


## This bash script is designed to set environment variables for a 
 ## Google Cloud Bigtable project and instance, if they are not already 
 ## set. It then displays the values of these environment variables and 
 ## performs operations using the cbt command-line tool for managing 
 ## Google Cloud Bigtable.
 ## 
 ## Here is a breakdown of what the script does:
 ## 
 ## 1. It defines a function named `prompt_and_set` that prompts the user 
 ## to enter a value for a given variable name and sets the environment 
 ## variable with that value.
 ## 
 ## 2. It checks if the `PROJECT` environment variable is set. If it is 
 ## not set, it calls the `prompt_and_set` function to set the `PROJECT` 
 ## environment variable.
 ## 
 ## 3. It checks if the `INSTANCE` environment variable is set. If it is 
 ## not set, it calls the `prompt_and_set` function to set the `INSTANCE` 
 ## environment variable.
 ## 
 ## 4. It displays the values of the `PROJECT` and `INSTANCE` environment 
 ## variables.
 ## 
 ## 5. It uses the `cbt` command to list the tables in the specified 
 ## Google Cloud Bigtable project and instance.
 ## 
 ## 6. It prompts the user to enter a table name and then uses the `cbt` 
 ## command to read the data from the specified table in the Google Cloud 
 ## Bigtable project and instance.
 ## 
 ## Overall, this script ensures that the necessary environment variables 
 ## are set for a Google Cloud Bigtable project and instance, and then 
 ## interacts with the Bigtable using the `cbt` command-line tool.

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


cbt -project $PROJECT -instance $INSTANCE ls
read -p "Please enter table name: " table_name

cbt -project $PROJECT -instance $INSTANCE read $table_name


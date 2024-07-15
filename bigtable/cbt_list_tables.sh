#!/bin/bash


## This bash script prompts the user to enter values for two environment 
 ## variables, PROJECT and INSTANCE, if they are not already set. It then 
 ## displays the values of these environment variables and runs a command 
 ## using the values of PROJECT and INSTANCE.
 ## 
 ## 1. The script defines a function `prompt_and_set()` which takes a 
 ## variable name as an argument, prompts the user to enter a value for 
 ## that variable, and sets the environment variable with that value.
 ## 
 ## 2. It checks if the environment variable PROJECT is set. If not, it 
 ## calls the `prompt_and_set` function to set the value for PROJECT.
 ## 
 ## 3. It then checks if the environment variable INSTANCE is set. If 
 ## not, it calls the `prompt_and_set` function to set the value for 
 ## INSTANCE.
 ## 
 ## 4. After setting or confirming the values of PROJECT and INSTANCE, 
 ## the script displays the values of these environment variables.
 ## 
 ## 5. Lastly, the script uses the values of PROJECT and INSTANCE to run 
 ## the command `cbt -project $PROJECT -instance $INSTANCE ls`.
 ## 
 ## Overall, this script ensures that the required environment variables 
 ## are set, prompts the user to set them if they are not, displays the 
 ## values of the variables, and then uses them in a command to list 
 ## contents in a Cloud Bigtable instance specified by the values of 
 ## PROJECT and INSTANCE.

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

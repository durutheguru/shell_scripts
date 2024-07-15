#! /bin/bash


## This bash script performs the following actions:
 ## 
 ## 1. It sources the `~/.bash_profile` file, which typically contains 
 ## environment variables and settings that are available to all shell 
 ## scripts.
 ## 
 ## 2. Defines an array named `functions` that contains the names of four 
 ## functions: `save_book`, `save_publisher`, `find_books`, and 
 ## `find_publishers`.
 ## 
 ## 3. Iterates over each function name in the `functions` array.
 ## 
 ## 4. For each function, it executes the `set_lambda_config.sh` script 
 ## passing three arguments: the function name, the region (`us-east-1`), 
 ## and an environment variable string 
 ## (`JASYPT_PWD=<<password>>,ENV=PROD`).
 ## 
 ## 5. The `set_lambda_config.sh` script is expected to configure a 
 ## Lambda function with the provided arguments (function name, region, 
 ## and environment variables) in the specified region.
 ## 
 ## In summary, this script is a setup script that iterates over a list 
 ## of functions and configures Lambda functions using the 
 ## `set_lambda_config.sh` script in the `us-east-1` region with 
 ## specified environment variables.

source ~/.bash_profile

functions=(
    "save_book"
    "save_publisher"
    "find_books"
    "find_publishers"
)


for function in "${functions[@]}"
do
  ./set_lambda_config.sh $function "us-east-1" "JASYPT_PWD=<<password>>,ENV=PROD"
done


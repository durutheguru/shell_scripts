#! /bin/bash


## This bash script is designed to retrieve the configuration of an AWS 
 ## Lambda function. 
 ## 
 ## Here is a breakdown of how the script works:
 ## 1. It starts with the shebang line `#! /bin/bash` which specifies 
 ## that the script should be executed using the bash shell.
 ## 2. The script checks the number of arguments passed to it using the 
 ## `$#` variable. If the number of arguments is exactly 2, then it will 
 ## execute the `aws lambda get-function-configuration` command with the 
 ## function name and region provided as arguments.
 ## 3. If the number of arguments is not 2, the script prompts the user 
 ## to enter the function name and region using the `read` command.
 ## 4. After the user enters the function name and region, the script 
 ## executes the `aws lambda get-function-configuration` command with the 
 ## user-provided function name and region.
 ## 
 ## In summary, this script allows the user to either provide the 
 ## function name and region as command line arguments or enter them 
 ## interactively, and then uses the AWS CLI to retrieve the 
 ## configuration of the specified AWS Lambda function.

if [ $# == 2 ];
then
  aws lambda get-function-configuration --function-name ${1} --region ${2}
else
  read -p "Enter Function Name: " function_name
  read -p "Enter Region: " region
  aws lambda get-function-configuration --function-name $function_name --region $region
fi





#! /bin/bash


## This bash script is designed to update the configuration of an AWS 
 ## Lambda function. Here is a breakdown of what it does:
 ## 
 ## 1. It starts with a shebang `#! /bin/bash`, indicating that this is a 
 ## bash script.
 ## 
 ## 2. It checks if the number of arguments passed to the script is equal 
 ## to 3 using the condition `[ $# == 3 ]`.
 ## 
 ## 3. If there are 3 arguments, it assumes that the script is being 
 ## called with the function name, region, and variables as arguments. It 
 ## then uses the AWS CLI command `aws lambda 
 ## update-function-configuration` to update the configuration of the 
 ## Lambda function with the provided function name, region, and 
 ## environment variables.
 ## 
 ## 4. If there are not exactly 3 arguments provided, it prompts the user 
 ## to enter the function name, region, and variables using `read -p` 
 ## command.
 ## 
 ## 5. After the user enters the required information, it again uses the 
 ## AWS CLI command `aws lambda update-function-configuration` to update 
 ## the configuration of the Lambda function with the provided function 
 ## name, region, and environment variables.
 ## 
 ## In summary, this script allows a user to update the configuration of 
 ## an AWS Lambda function by either passing the function details as 
 ## command-line arguments or by entering them interactively when the 
 ## script is run without the required arguments.

if [ $# == 3 ];
then
    aws lambda update-function-configuration --function-name ${1} --region ${2} --environment "Variables={${3}}"
else  
    read -p "Enter Function Name: " function_name
    read -p "Enter Region: " region
    read -p "Enter Variables: " variables
    
    aws lambda update-function-configuration --function-name $function_name --region $region --environment "Variables={$variables}"
fi






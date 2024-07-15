#!/bin/bash


## This bash script is prompting the user to enter their AWS SSO (Single 
 ## Sign-On) profile name and then setting the AWS_PROFILE environment 
 ## variable to the entered profile name. Finally, it runs the `aws sso 
 ## login` command, which will initiate the login process with AWS SSO 
 ## using the specified profile name. This script essentially automates 
 ## the login process for AWS SSO by setting the profile name and logging 
 ## in using that profile.

read -p "Enter your AWS SSO profile name: " profile_name

export AWS_PROFILE="$profile_name";

aws sso login


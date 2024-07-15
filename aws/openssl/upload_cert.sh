#!/bin/bash


## This bash script prompts the user to enter the name of a server 
 ## certificate, the path to the certificate file, and the path to the 
 ## private key file. It then uses the AWS CLI command `aws iam 
 ## upload-server-certificate` to upload the server certificate to AWS 
 ## Identity and Access Management (IAM). The script passes the entered 
 ## certificate name, certificate file path (prefixed with "file://"), 
 ## and private key file path (prefixed with "file://") as arguments to 
 ## the IAM API call for uploading the server certificate.

read -p "Enter Server Certificate Name: " cert_name
read -p "Enter Certificate File: " cert_file
read -p "Enter Private Key File: " private_key_file

aws iam upload-server-certificate --server-certificate-name $cert_name --certificate-body "file://$cert_file" --private-key "file://$private_key_file" 



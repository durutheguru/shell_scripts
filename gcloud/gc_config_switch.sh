#!/bin/bash


## This bash script performs the following actions:
 ## 
 ## 1. Lists the existing configurations in the Google Cloud CLI using 
 ## the command `gcloud config configurations list`.
 ## 2. Prompts the user to enter a new profile name using the `read` 
 ## command with the prompt message "Enter new profile name: ".
 ## 3. Activates the Google Cloud CLI configuration corresponding to the 
 ## new profile name provided by the user using the command `gcloud 
 ## config configurations activate $profile`.
 ## 
 ## In summary, this script allows the user to select and activate a 
 ## specific configuration profile within the Google Cloud CLI tool.

gcloud config configurations list

read -p "Enter new profile name: " profile

gcloud config configurations activate $profile

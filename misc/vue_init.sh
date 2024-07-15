#! /bin/bash


## This bash script prompts the user to enter an application name if it 
 ## is not provided as a command-line argument. It then uses the Vue CLI 
 ## to create a new Vue.js application with the specified name, adds 
 ## Vuetify as a UI framework, and changes the directory to the newly 
 ## created application folder.
 ## 
 ## The lines commented out at the end (`npm init vue@latest`, `vue add 
 ## vuetify`, `vue add tailwind`) appear to be additional commands that 
 ## may have been considered for the script but are currently disabled.

if [ $# -ge 1 ];
then 
  app_name=${1}
else 
  read -p "Enter Application Name: " app_name
fi



vue create $app_name
cd $app_name
vue add vuetify

# npm init vue@latest 
# vue add vuetify
# vue add tailwind
# 

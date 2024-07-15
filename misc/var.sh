#! /bin/bash


## This bash script is designed to set an environment variable in the 
 ## user's bash profile. Here is a breakdown of what each part of the 
 ## script does:
 ## 
 ## 1. The script first checks if there is at least one argument passed 
 ## to the script. If there is, it assigns the first argument to the 
 ## variable `variable`. If not, it prompts the user to enter a variable 
 ## name.
 ## 
 ## 2. Next, the script checks if there is a second argument passed to 
 ## the script. If there is, it assigns the second argument to the 
 ## variable `value`. If not, it prompts the user to enter a value for 
 ## the variable.
 ## 
 ## 3. The script then appends the line `export $variable=$value` to the 
 ## user's `.bash_profile` file. This line exports the variable defined 
 ## earlier with the assigned value.
 ## 
 ## 4. It then sources the `.bash_profile` file to apply the changes made.
 ## 
 ## 5. After sourcing the profile, the script starts a new bash session 
 ## using the `-l` flag to ensure the new environment variable is loaded.
 ## 
 ## 6. Finally, the script prints a message stating the variable name and 
 ## its corresponding value.
 ## 
 ## In summary, this script is meant to allow the user to set an 
 ## environment variable on their system by providing the variable name 
 ## and value as arguments or by interactively entering them.

if [ $# -ge 1 ];
then
   variable=${1}
else 
   read -p "Enter Variable Name: " variable
fi

if [ $# -ge 2 ];
then 
  value=${2}
else 
  read -p "Enter Value: " value
fi

echo "export $variable=$value" >> ~/.bash_profile
source ~/.bash_profile
bash -l
echo "set $variable = $value"



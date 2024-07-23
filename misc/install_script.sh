#! /bin/bash


## This Bash script performs the following tasks:
 ## 
 ## 1. It sets the required argument length to 1 and defines the path to 
 ## the `.bash_profile`.
 ## 2. It reads the content of the `.bash_profile`.
 ## 3. It checks if the number of arguments provided is less than the 
 ## required argument length. If so, it displays the usage message and 
 ## exits with a status of 1.
 ## 4. It assigns the first argument provided to the variable `file`.
 ## 5. It changes the permissions of the file specified in the first 
 ## argument with `chmod +rwx`.
 ## 6. It copies the file to `/usr/local/bin`.
 ## 7. It extracts the name of the file (without the extension) and 
 ## stores it in the `file_name` variable.
 ## 8. It checks if the content of the file is present in the 
 ## `.bash_profile`. If so, it outputs "Updated Installation..."; 
 ## otherwise, it appends an alias to the `.bash_profile` and outputs 
 ## "Installation successful...".
 ## 9. It checks if the number of arguments is 1 or if the second 
 ## argument is "-r". If the condition is met, it starts a new Bash login 
 ## shell with `bash -l`.
 ## 
 ## Overall, the script appears to be a simple script that installs a 
 ## file to `/usr/local/bin`, sets up an alias in the `.bash_profile`, 
 ## and allows for starting a new login shell optionally.

REQUIRED_ARG_LENGTH=1
bash_profile_path=~/.bash_profile
bash_profile_content=`cat $bash_profile_path`

if [ $# -lt $REQUIRED_ARG_LENGTH  ];
then
  echo "Usage `basename $0`: <file_name.ext>" >&2
  exit 1
fi


file=$1

chmod +rwx $file

cp $file /usr/local/bin

file_name=${file%%.*}

if grep -q "$file" "$bash_profile_path"; then
  echo "Updated Installation..."
else
  echo "alias $file_name='bash /usr/local/bin/$file'" >> ~/.bash_profile
  echo "Installation successful..."
fi

if [[ $# == 1 || $2 == "-r" ]]
then
  bash -l
fi



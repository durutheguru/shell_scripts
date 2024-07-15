#! /bin/bash


## This bash script enables the user to create a new bash script. Here 
 ## is an overview of what each part of the script does:
 ## 
 ## 1. `#! /bin/bash` - This is the shebang line that specifies the 
 ## interpreter that should be used to execute the script.
 ## 
 ## 2. `cdir=`pwd`` - Saves the current directory in the variable `cdir`.
 ## 
 ## 3. `cd ~/scripts/bash/` - Changes the directory to `~/scripts/bash/`.
 ## 
 ## 4. `read -p "What's the name of the script? " script_name` - Prompts 
 ## the user to input the name of the new script and stores it in the 
 ## `script_name` variable.
 ## 
 ## 5. `[ ${#script_name} -le 1 ] && echo "Script Name cannot be empty" 
 ## && exit 1 || touch "$script_name" && vim $_` - Checks if the length 
 ## of the script name is less than or equal to 1. If so, it outputs an 
 ## error message and exits the script. Otherwise, it creates a new file 
 ## with the entered script name using the `touch` command and opens it 
 ## for editing using `vim`.
 ## 
 ## 6. `./install_script.sh $script_name -n` - It executes 
 ## `install_script.sh` with the specified script name as an argument. 
 ## The `-n` flag seems to be passed to the script.
 ## 
 ## 7. `cd $cdir` - Changes the directory back to the original directory 
 ## stored in the `cdir` variable after completing the script creation 
 ## process.
 ## 
 ## In summary, this script guides the user in creating a new bash script 
 ## by prompting for a name, creating the script file, opening it in the 
 ## Vim editor for editing, executing `install_script.sh` with the new 
 ## script name, and then returning to the original directory.


cdir=`pwd`

cd ~/scripts/bash/

read -p "What's the name of the script? " script_name

[ ${#script_name} -le 1 ] && echo "Script Name cannot be empty" && exit 1 || touch "$script_name" && vim $_

./install_script.sh $script_name -n

cd $cdir


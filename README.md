# Overview
This repository contains different shell scripts to automate various tasks on a shell terminal. 
Welcome to the **shell scripts** repository, a collection of powerful and easy-to-use scripts designed to automate various tasks and make a developer's life easier! Whether you're looking to streamline your workflow, manage your environment, or perform repetitive tasks effortlessly, shell scripts has got you covered.


## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)
- [Contact](#contact)


## Features
- **Ease of Use**: Simple and intuitive scripts with clear instructions.
- **Productivity Boost**: Automate repetitive tasks to save time and reduce errors.
- **Versatile**: Suitable for various development environments and use cases.
- **Open Source**: Contribute, customize, and enhance the scripts to fit your needs.



## Prerequisites

- **Bash**: Most of the scripts are Bash scripts, so you will need to have a Bash interpreter installed on your local. 
- **Permissions**: Ensure you have the necessary permissions to execute shell scripts. Or, you could run a chmod command to update permissions. 



## Installation

1. Clone the Repository:
   ```
   $ git clone https://github.com/durutheguru/shell_scripts.git
   ```   
2. Next cd into the shell_scripts directory on your terminal and then run `make`. This should install the `install_script.sh` file that allows you to install other shell scripts.    
3. You might want to look at the `install_script.sh` file found in the misc folder. The script installs other shell scripts by copying them to the `/usr/local/bin` folder and adding an alias to the bash_profile with the script name.   
   ```
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
   ```   
4. To install a script, simply invoke: `$ install_script <<script file name>>`   
5. The `install_script` automatically refreshes the terminal, but in some cases, you may need to do a manual reload with either `bash -l` or `source ~/.bash_profile`   
6. After successful installation, you should be able to invoke the script from your terminal by the file name.   


## Usage

Here's an example that installs `find_file.sh` located in the misc folder. find_file is a shell script that searches a directory for a file name.   
```
$ install_script find_file.sh
$ find_file <<directory>> <<file_name>>  ## can be called from any path, context or terminal on the local machine
```


## Contributing

Read the [CONTRIBUTING.md](https://github.com/durutheguru/shell_scripts/blob/main/CONTRIBUTING.md) file


## Contact

Feel free to raise issues if you find bugs in the script. I'll do my best to address them. 







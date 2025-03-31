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

if [ $# -lt $REQUIRED_ARG_LENGTH ]; then
  echo "Usage $(basename "$0"): <file_name.ext>" >&2
  exit 1
fi

file="$1"

if [[ ! -f "$file" ]]; then
    echo "Error: File '$file' does not exist."
    exit 1
fi

# Make the file readable, writable, and executable
chmod +rwx "$file"

# Copy the file to /usr/local/bin
sudo cp "$file" /usr/local/bin || {
    echo "Error: Failed to copy file to /usr/local/bin."
    exit 1
}

file_name=$(basename "$file" .sh)

# Define shell profile paths
bash_profile="$HOME/.bash_profile"
zsh_profile="$HOME/.zshrc"

# Define alias command
alias_command="alias $file_name='bash /usr/local/bin/${file_name}.sh'"

# Function to add alias if it doesn't already exist
add_alias_if_needed() {
    local profile_path="$1"
    if [ -f "$profile_path" ]; then
        if grep -q "alias $file_name=" "$profile_path"; then
            echo "Alias '$file_name' already exists in $(basename "$profile_path"), skipping..."
        else
            echo "$alias_command" >> "$profile_path"
            echo "Added alias '$file_name' to $(basename "$profile_path")..."
        fi
    else
        # Create profile file and add alias if not existing
        echo "$alias_command" >> "$profile_path"
        echo "Created $(basename "$profile_path") and added alias '$file_name'..."
    fi
}

# Add alias to bash and zsh profiles
add_alias_if_needed "$bash_profile"
add_alias_if_needed "$zsh_profile"

echo "Installation successful."

# Restart shell if requested with '-r'
if [[ "$2" == "-r" ]]; then
    current_shell=$(basename "$SHELL")
    echo "Restarting $current_shell..."
    exec "$SHELL" -l
fi




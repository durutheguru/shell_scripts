#!/bin/bash


# Function to accept multi-line input
get_user_prompt() {
    echo -e "\nEnter the prompt for the model (Ctrl+D to end):\n"
    prompt=$(</dev/stdin)
}

# Function to run ollama and get the response
run_ollama() {
    response=$(ollama run "$model_name" "Generate a file for me. $prompt . Don't explain your output. Your output should ONLY include the file contents, no extra strings.")
    filtered_response=$(echo "$response" | grep -v '^```')
    echo -e "\n>> Response from LLM:\n"
    echo -e "$filtered_response\n\n"

    read -p "Are you fine with the generated content? (yes/no): " proceed
    if [[ "$proceed" == "no" ]]; then
        get_user_prompt
        run_ollama
    fi
}

# Function to run the generated script
run_script() {
    # echo $filtered_response | bash
    read -p "Do you want to test run the generated script? (yes/no): " run
    if [[ "$run" == "yes" ]]; then
        eval "$filtered_response"
    fi
}

# Function to get user confirmation
get_confirmation() {
    read -p "Do you want to proceed with the generated script? (yes/no): " proceed
}

# Function to get file path and write the script
write_script_to_file() {
    read -p "Enter the file name to save: " file_name
    echo "$filtered_response" > "$file_name"
    chmod +x "$file_name"
    script_dir=$(pwd)
    script_name=$file_name
}

# Function to run the install_script and execute in a new shell
install_and_run_script() {
    source ~/.bash_profile
    /usr/local/bin/install_script.sh "$script_name"
    bash -l
}


# Main script execution
read -p "Enter the model name (press enter to use the default): " model_name

if [[ -z "$model_name" ]]; then
    model_name="llama3.1"
fi

get_user_prompt
run_ollama
run_script
get_confirmation

if [[ "$proceed" == "yes" ]]; then
    write_script_to_file
    install_and_run_script
    echo "Operation completed successfully."
else
    echo "Operation canceled by user."
fi


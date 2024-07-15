#!/bin/bash


## This bash script is designed to analyze and add comments to all `.sh` 
 ## files within a specified directory. Here is a breakdown of what the 
 ## script does:
 ## 
 ## 1. The script defines two functions:
 ## - `generate_description()`: This function reads the content of a 
 ## file, prepares a data structure for an API request to OpenAI, sends 
 ## the request to the OpenAI API, and extracts the description from the 
 ## response.
 ## - `add_comment()`: This function generates a comment by calling 
 ## `generate_description()` and then adds the comment to the top of a 
 ## `.sh` file after the `#!/bin/bash` line. The comment is formatted to 
 ## have a maximum line length of 70 characters and each line is prefixed 
 ## with `##`.
 ## 
 ## 2. The script exports the `add_comment` and `generate_description` 
 ## functions to make them available for use by the `find` command.
 ## 
 ## 3. It checks if the environment variable `OPENAI_API_KEY` is set. If 
 ## it is not set, the script prints a message asking the user to set 
 ## their OpenAI API key and exits with an error status.
 ## 
 ## 4. The script uses the `find` command to locate all `.sh` files 
 ## within the specified directory (or the current directory if none is 
 ## specified). For each found `.sh` file, it executes the `add_comment` 
 ## function.
 ## 
 ## 5. After processing all `.sh` files, the script outputs a message 
 ## indicating that comments have been added to all `.sh` files in the 
 ## specified directory.
 ## 
 ## Overall, this script automates the process of adding descriptive 
 ## comments to shell script files using the OpenAI API to generate the 
 ## descriptions.

# Function to generate a description using OpenAI API
generate_description() {
    local file="$1"
    local api_key="$OPENAI_API_KEY"
    local content=$(cat "$file")
    
    # Prepare the data for the API request
    local data=$(jq -n --arg content "$content" '{
        "model": "gpt-3.5-turbo-0125",
        "messages": [
            {"role": "system", "content": "You are a helpful assistant."},
            {"role": "user", "content": "Analyze this bash script and provide a description of what it does: \($content)"}
        ]
    }')
    
    # Make the API request to OpenAI
    local response=$(curl -s -X POST https://api.openai.com/v1/chat/completions \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer $api_key" \
        -d "$data")

    # Extract the description from the response
    local description=$(echo "$response" | jq -r '.choices[0].message.content')
    echo "$description"
}

# Function to add a comment at the top of a .sh file after #!/bin/bash
add_comment() {
    local file="$1"
    local comment=$(generate_description "$file")

    # Split comment into lines with a maximum length of 70 characters, prefix each line with ##
    comment=$(echo "$comment" | fold -s -w 70 | sed 's/^/## /' | sed 's/$/DDELIM/')
    
    if ! grep -Fxq "$comment" "$file"; then
        # Create a temporary file
        temp_file=$(mktemp)

        # Insert the comment after the #!/bin/bash line
        awk -v comment="$(echo -e $comment)" '
        NR==1 && /^#!/ {
            print;
            getline;
            if ($0 ~ /^##/) {
                print;
                nextfile;
            } else {
                print ""; 
                print ""; 
                n=split(comment, c, "DDELIM"); 
                for (i = 1; i <= n; i++) print c[i]; 
            }
            next
        } {print}
        ' "$file" > "$temp_file"

        # Replace the original file with the temporary file
        mv "$temp_file" "$file"

        echo "Added comment to $file"
    else
        echo "Comment already exists in $file"
    fi

}

# Export the function so it can be used by find's -exec
export -f add_comment
export -f generate_description

# Ensure the API key is set
if [ -z "$OPENAI_API_KEY" ]; then
    echo "Please set your OpenAI API key in the OPENAI_API_KEY environment variable."
    exit 1
fi

# Recursively find all .sh files in the specified directory and add comments
directory="${1:-.}"  # Default to current directory if no directory is specified
find "$directory" -type f -name "*.sh" -exec bash -c 'add_comment "$0"' {} \;

echo "Comments added to all .sh files in $directory."


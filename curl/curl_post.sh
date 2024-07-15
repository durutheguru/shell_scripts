#!/bin/bash


## This bash script captures user input to construct and send a POST 
 ## request using the curl command to a specified URL. Here is a 
 ## breakdown of what the script does:
 ## 1. The script uses the #!/bin/bash shebang to specify that it should 
 ## be run using the bash shell.
 ## 2. The user is prompted to enter a URL and the desired body content 
 ## type for the POST request using the read command.
 ## 3. The script then prompts the user to enter the data for the POST 
 ## request. The data can be entered on separate lines, and pressing 
 ## Ctrl+D indicates the end of input.
 ## 4. The entered data is stored in the DATA variable.
 ## 5. Finally, the script constructs a POST request using the curl 
 ## command with the following options:
 ## -X POST: Specifies that the request method is POST.
 ## -H "Content-Type: $contentType": Sets the Content-Type header for 
 ## the request using the value provided by the user.
 ## -d "$DATA": Includes the data entered by the user in the request 
 ## body.
 ## "$URL": Specifies the URL provided by the user as the target for 
 ## the POST request.
 ## 
 ## In summary, this script allows the user to input a URL, body content 
 ## type, and data to send a custom POST request using the curl command.

# Read the URL from user input
read -p "Enter the URL: " URL
read -p "Enter the Body Content Type: " contentType

# Read the data from user input
echo "Enter the data (press Ctrl+D when finished):"
DATA=$(</dev/stdin)

# Send the POST request
curl -X POST -H "Content-Type: $contentType" -d "$DATA" "$URL"




#!/bin/bash


## This bash script performs a simple connectivity check to see if the 
 ## script can establish a connection to Google's web server on port 443 
 ## (HTTPS). Here's a breakdown of what the script does:
 ## 
 ## 1. The shebang `#!/bin/bash` at the beginning specifies that this 
 ## script should be run using the Bash shell.
 ## 
 ## 2. The `if` statement checks the exit status of the `nc` (netcat) 
 ## command with options `-z` and `-w1`. 
 ## - `nc -zw1 google.com 443` is used to attempt to establish a 
 ## connection to Google's server on port 443 without sending any data 
 ## and with a timeout of 1 second.
 ## - If the connection is successful, `nc` will return an exit status 
 ## of 0 (success), otherwise it will return a non-zero exit status.
 ## 
 ## 3. If the `nc` command succeeds in establishing a connection, the 
 ## message "we have connectivity!!!" will be echoed to the terminal.
 ## 
 ## In summary, this script checks if the machine running the script has 
 ## network connectivity to Google's server on port 443, and if 
 ## successful, it displays a message indicating that connectivity is 
 ## available.

if nc -zw1 google.com 443; then
  echo "we have connectivity!!!"
fi

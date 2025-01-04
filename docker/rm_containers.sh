#!/bin/bash


## This bash script is designed to interact with Docker containers. Here 
 ## is a breakdown of what each line does:
 ## 
 ## 1. `#!/bin/bash`: This line specifies that the script should be run 
 ## using the bash shell.
 ## 
 ## 2. `echo "Stopping all running containers..."`: This line prints a 
 ## message indicating that all running containers are going to be 
 ## stopped.
 ## 
 ## 3. `docker stop $(docker ps -q)`: This line executes a Docker command 
 ## to stop all running containers. The `docker ps -q` command lists the 
 ## IDs of all running containers, and `docker stop` is used to stop each 
 ## one.
 ## 
 ## 4. `echo "Removing all containers..."`: This line prints a message 
 ## indicating that all containers are going to be removed.
 ## 
 ## 5. `docker rm $(docker ps -a -q)`: This line executes a Docker 
 ## command to remove all containers, including those that are not 
 ## currently running. The `docker ps -a -q` command lists the IDs of all 
 ## containers (both running and stopped), and `docker rm` is used to 
 ## remove each one.
 ## 
 ## 6. `echo "All Docker containers have been stopped and removed."`: 
 ## This line prints a final message indicating that all Docker 
 ## containers have been successfully stopped and removed.
 ## 
 ## In summary, this script stops all running Docker containers and then 
 ## removes all containers (including stopped ones), resulting in a clean 
 ## Docker environment with no containers left.

# Stop all running containers
echo "Stopping all running containers..."
docker stop $(docker ps -q)

# Remove all containers
echo "Removing all containers..."
docker rm $(docker ps -a -q)

echo "All Docker containers have been stopped and removed."

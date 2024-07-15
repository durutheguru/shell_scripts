#! /bin/bash


## This bash script is intended to interact with Docker containers. 
 ## Here's a breakdown of what it does:
 ## 
 ## 1. `docker ps -a`: This command lists all Docker containers, 
 ## including those that are not currently running.
 ## 
 ## 2. `read -p "Enter Container ID: " container_id`: This line prompts 
 ## the user to enter a container ID. The `read` command allows the user 
 ## to input the ID, which is stored in the variable `container_id`.
 ## 
 ## 3. `docker logs -f --tail=1000 $container_id`: This command then 
 ## fetches and outputs the logs of the specified Docker container. The 
 ## `--tail=1000` flag indicates that the last 1000 lines of logs will be 
 ## displayed. The container ID provided by the user earlier is used in 
 ## the command to specify which container's logs to show.
 ## 
 ## In summary, this script first lists all Docker containers, prompts 
 ## the user to enter a specific container ID, and then displays the last 
 ## 1000 lines of logs for that container in real-time.

docker ps -a

read -p "Enter Container ID: " container_id

docker logs -f --tail=1000 $container_id


#!/bin/bash


## This bash script is designed to retrieve the IDs of all running 
 ## Docker containers and then continuously stream their logs. Here is a 
 ## breakdown of what the script does:
 ## 
 ## 1. The script starts with the shebang line "#!/bin/bash" to specify 
 ## that it is a bash script.
 ## 
 ## 2. It uses the command "docker ps -q" to list the IDs of all running 
 ## Docker containers and stores this list in the variable 
 ## "container_ids".
 ## 
 ## 3. The script then enters a "for" loop that iterates through each 
 ## container ID in the list stored in "container_ids".
 ## 
 ## 4. Within the loop, the script uses the command "docker logs -f $id" 
 ## to stream the logs of each container specified by the current ID. The 
 ## "&" at the end of the command sends each log streaming process to the 
 ## background, allowing multiple log streams to run concurrently.
 ## 
 ## 5. After starting the log streaming for all containers in the 
 ## background, the script uses the "wait" command to pause and wait for 
 ## all background processes to complete before exiting.
 ## 
 ## In summary, this script automates the process of streaming logs from 
 ## all running Docker containers simultaneously.


container_ids=$(docker ps -q)

for id in $container_ids; do
  docker logs -f $id &
done


wait


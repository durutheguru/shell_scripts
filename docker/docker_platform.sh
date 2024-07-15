#! /bin/bash


## This Bash script uses the command `docker system info` to display 
 ## information about the Docker system. The `--format` flag is used to 
 ## specify the format of the output. In this case, it specifies to 
 ## display the operating system type and the architecture of the system 
 ## in the format '{{.OSType}}/{{.Architecture}}'. The script will output 
 ## the operating system type and architecture information of the Docker 
 ## system when executed.

docker system info --format '{{.OSType}}/{{.Architecture}}'


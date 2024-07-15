#! /bin/bash


## This Bash script is designed to restart deployments in a Kubernetes 
 ## cluster using `kubectl` commands. Here's a breakdown of what the 
 ## script does:
 ## 
 ## 1. It checks if the number of arguments passed to the script is equal 
 ## to 1 using the condition `[ $# == 1 ]`.
 ## 2. If only one argument is provided, it assumes that the argument is 
 ## the namespace. It then executes the following commands:
 ## - Restart the deployments in the specified namespace using 
 ## `kubectl -n ${1} rollout restart deploy`.
 ## - Retrieve and monitor the pods in the specified namespace using 
 ## `kubectl get pods -n ${1} -w`.
 ## 3. If no or more than one argument is provided, the script prompts 
 ## the user to enter the namespace interactively.
 ## 4. It then restarts the deployments in the entered namespace using 
 ## `kubectl -n $namespace rollout restart deploy`.
 ## 5. It again retrieves and monitors the pods in the entered namespace 
 ## using `kubectl get pods -n $namespace -w`.
 ## 
 ## In summary, the script provides a convenient way to restart 
 ## deployments in a Kubernetes cluster either by passing the namespace 
 ## as an argument or by entering it interactively if no or more than one 
 ## argument is provided.

if [ $# == 1 ];
then
  kubectl -n ${1} rollout restart deploy
  kubectl get pods -n ${1} -w
else
  read -p "Enter Pod namespace: " namespace
  kubectl -n $namespace rollout restart deploy
  kubectl get pods -n $namespace -w
fi






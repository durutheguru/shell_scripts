#! /bin/bash


## This bash script retrieves the logs of a specified pod in a 
 ## Kubernetes namespace. The script first checks if there is at least 
 ## one argument when running the script. If there is, it assigns the 
 ## first argument to the `namespace` variable. If not, it prompts the 
 ## user to enter the Kubernetes namespace.
 ## 
 ## Then, it uses `kubectl get pods` to list all pods in the specified 
 ## `$namespace`. After that, it prompts the user to enter the name of 
 ## the pod they want to retrieve logs from.
 ## 
 ## The script then checks if there is a second argument. If there is, it 
 ## assigns the second argument to the `tail` variable. If not, it 
 ## prompts the user to enter the `tail` value, which specifies how many 
 ## lines from the end of the logs to display. If the user enters "-1" as 
 ## the `tail` value, it uses `kubectl logs -f` to continuously stream 
 ## the logs of the specified `$pod_name` in the specified `$namespace`. 
 ## Otherwise, it uses `kubectl logs -f --tail=$tail` to display a 
 ## specified number of lines from the end of the logs for the specified 
 ## `$pod_name` in the specified `$namespace`.
 ## 
 ## Overall, this script provides a simple way to retrieve and monitor 
 ## logs from a specific pod in a Kubernetes namespace.

if [ $# -ge 1 ];
then
   namespace=${1}
else 
   read -p "Enter Kube Namespace: " namespace
fi

kubectl get pods -n $namespace

read -p "Enter Pod name: " pod_name

if [ $# == 2 ];
then 
  tail=${2}
else 
  read -p "Enter tail: (-1 for none) " tail
fi

if [[ $tail == "-1" ]]
then
   kubectl logs -f $pod_name -n $namespace
else
   kubectl logs -f --tail=$tail $pod_name -n $namespace
fi




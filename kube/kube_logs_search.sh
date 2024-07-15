#! /bin/bash


## This bash script prompts the user to enter a Kubernetes namespace, 
 ## then retrieves the list of pods within that namespace using `kubectl 
 ## get pods -n $namespace`. 
 ## 
 ## It then asks the user to enter a specific pod name, the number of 
 ## lines to tail from the logs, and a search term. Based on the input 
 ## for the number of lines to tail, the script uses `kubectl logs` to 
 ## fetch the logs of the specified pod within the namespace. The logs 
 ## are then piped to `grep` to search for the specified term.
 ## 
 ## If the input for the number of lines to tail is "-1" (indicating no 
 ## tailing of logs required), then logs are retrieved without the 
 ## `--tail` option.
 ## 
 ## In summary, this script allows the user to select a Kubernetes 
 ## namespace and a specific pod within that namespace, tail a specified 
 ## number of lines from the pod's logs, and search for a specific term 
 ## within those logs.

read -p "Enter Kube Namespace: " namespace

kubectl get pods -n $namespace


read -p "Enter Pod name: " pod_name
read -p "Enter tail: (-1 for none) " tail
read -p "Enter search: " search

if [[ tail == "-1" ]]
then
   kubectl logs -f $pod_name -n $namespace | grep $search
else
   kubectl logs -f --tail=$tail $pod_name -n $namespace | grep $search
fi



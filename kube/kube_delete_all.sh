#!/bin/bash


## This bash script is designed to delete resources in a Kubernetes 
 ## namespace. Here's a breakdown of the script:
 ## 
 ## 1. It starts with the shebang line #!/bin/bash, which specifies that 
 ## the script should be run using the Bash shell.
 ## 
 ## 2. It checks for the presence of at least one argument when the 
 ## script is called. If there is at least one argument provided, it 
 ## assigns the first argument to the "namespace" variable. Otherwise, it 
 ## prompts the user to enter the Kubernetes namespace interactively.
 ## 
 ## 3. The script then uses kubectl commands to delete various resources 
 ## in the specified Kubernetes namespace:
 ## - kubectl delete all --all -n $namespace: Deletes all resources of 
 ## all types in the specified namespace.
 ## - kubectl delete pvc --all -n $namespace: Deletes all persistent 
 ## volume claims in the specified namespace.
 ## - kubectl delete pv --all -n $namespace: Deletes all persistent 
 ## volumes in the specified namespace.
 ## 
 ## 4. Finally, the script deletes the Kubernetes namespace itself using 
 ## the command kubectl delete ns $namespace.
 ## 
 ## In summary, this script provides a convenient way to delete resources 
 ## in a specified Kubernetes namespace, either through command-line 
 ## arguments or interactive input from the user.


if [ $# -ge 1 ];
then
   namespace=${1}
else 
   read -p "Enter Kube Namespace: " namespace
fi


kubectl delete all --all -n $namespace
kubectl delete pvc --all -n $namespace
kubectl delete pv --all -n $namespace

kubectl delete ns $namespace

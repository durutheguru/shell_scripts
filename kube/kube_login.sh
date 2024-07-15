#! /bin/bash


## This bash script sets the KUBECONFIG environment variable to point to 
 ## the kubeconfig.yaml file located at 
 ## ~/scripts/yaml/kube/kubeconfig.yaml. This file likely contains 
 ## configuration details for accessing a Kubernetes cluster.
 ## 
 ## After setting the KUBECONFIG variable, it echoes a message "Logged 
 ## into Julian Duru kubernetes cluster" to the console.
 ## 
 ## Finally, it initiates a new bash shell with the -l flag, which 
 ## initiates a login shell. This may be done to ensure that the 
 ## KUBECONFIG variable is available in the new shell session.
 ## 
 ## Overall, the script appears to facilitate logging into the Julian 
 ## Duru Kubernetes cluster by setting the KUBECONFIG file and initiating 
 ## a new shell with the configuration loaded.



export KUBECONFIG=~/scripts/yaml/kube/kubeconfig.yaml
echo "Logged into Julian Duru kubernetes cluster"

bash -l




#! /bin/bash


## This bash script is running the command `kubectl config 
 ## get-contexts`. 
 ## 
 ## The `kubectl` command is a command-line tool provided by Kubernetes 
 ## for interacting with Kubernetes clusters. In this case, the script is 
 ## using the `kubectl config get-contexts` command to list all the 
 ## available contexts. 
 ## 
 ## A context in Kubernetes is a group of access parameters, such as 
 ## cluster, user, and namespace, that define a specific environment in 
 ## which the `kubectl` command should operate.
 ## 
 ## So, this script simply displays a list of available contexts that can 
 ## be used with `kubectl` for managing Kubernetes clusters.

kubectl config get-contexts


#!/bin/bash


## This Bash script prompts the user to input the name of a service, a 
 ## port mapping, and a namespace. It then uses the `kubectl` command to 
 ## forward a local port to a port on a specific service in the 
 ## Kubernetes cluster. The values provided by the user are used to 
 ## specify the service name, namespace, and port mapping for the port 
 ## forwarding operation. This script facilitates accessing services 
 ## running in a Kubernetes cluster by setting up port forwarding.

read -p "Enter Service name: " service_name
read -p "Enter Port-Mapping: " port_mapping
read -p "Enter Namespace: " namespace

kubectl port-forward svc/$service_name -n $namespace $port_mapping

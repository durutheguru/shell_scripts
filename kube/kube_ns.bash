#!/bin/bash


if [ $# -ge 1 ];
then
   namespace=${1}
else 
   read -p "Enter Kube Namespace: " namespace
fi

kubectl get pods -n $namespace

kubectl config set-context --current --namespace $namespace

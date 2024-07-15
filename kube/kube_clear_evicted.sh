# /bin/bash

if [ $# == 1 ];
then
  kubectl get pod -n ${1} | grep Evicted | awk '{print $1}' | xargs kubectl delete pod -n ${1} 
else
  read -p "Enter Pod namespace: " namespace
  kubectl get pod -n $namespace | grep Evicted | awk '{print $1}' | xargs kubectl delete pod -n $namespace
fi



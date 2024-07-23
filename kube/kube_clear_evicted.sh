#!/bin/bash

# Function to delete pods based on their state
delete_pods_by_state() {
  local namespace=$1
  local state=$2
  kubectl get pod -n "$namespace" | grep "$state" | awk '{print $1}' | xargs kubectl delete pod -n "$namespace"
}

if [ $# == 1 ]; then
  namespace=$1
else
  read -p "Enter Pod namespace: " namespace
fi

# Delete pods in Evicted state
delete_pods_by_state "$namespace" "Evicted"

# Delete pods in Error state
delete_pods_by_state "$namespace" "Error"


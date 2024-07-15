#!/bin/bash


## This bash script is designed to delete Persistent Volumes (PVs) that 
 ## have a status phase of "Released" using the Kubernetes command-line 
 ## tool `kubectl`. Here's a breakdown of what the script does:
 ## 
 ## 1. It uses the command `kubectl get pv -o json` to get the 
 ## information about PVs in JSON format.
 ## 2. It pipes the output to `jq`, a command-line JSON processor, to 
 ## filter and extract the names of PVs that have a status phase of 
 ## "Released". The filtered PV names are stored in the variable 
 ## `released_pvs`.
 ## 3. If no PVs are found with the status phase "Released", the script 
 ## prints "No released PVs found." and exits with status code 0.
 ## 4. If there are PVs with the status phase "Released", the script 
 ## prints "Deleting released PVs..." and proceeds to delete each of the 
 ## released PVs using the `kubectl delete pv <pv_name>` command within a 
 ## loop.
 ## 5. After deleting all released PVs, the script prints "Released PVs 
 ## deleted successfully."
 ## 
 ## Overall, this script automates the deletion of released PVs in a 
 ## Kubernetes cluster. Make sure to run the script with the necessary 
 ## permissions and make changes accordingly based on your Kubernetes 
 ## environment.


released_pvs=$(kubectl get pv -o json | jq -r '.items[] | select(.status.phase == "Released") | .metadata.name')

if [[ -z "$released_pvs" ]]; then
  echo "No released PVs found."
  exit 0
fi

echo "Deleting released PVs..."

for pv in $released_pvs; do
  kubectl delete pv "$pv"
done

echo "Released PVs deleted successfully."


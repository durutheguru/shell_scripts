#!/bin/bash


## This bash script interacts with Kubernetes using the `kubectl` 
 ## command to manage MutatingWebhookConfigurations. Here is a breakdown 
 ## of its functionality:
 ## 
 ## 1. It retrieves a list of MutatingWebhookConfigurations using 
 ## `kubectl get mutatingwebhookconfigurations -o 
 ## jsonpath='{.items[*].metadata.name}'` and stores the names in the 
 ## variable `mwc_names`.
 ## 
 ## 2. It checks if the variable `mwc_names` is empty (no 
 ## MutatingWebhookConfigurations found). If so, it displays a message 
 ## ("No MutatingWebhookConfigurations found.") and exits with a status 
 ## code of 0 (indicating successful completion).
 ## 
 ## 3. If MutatingWebhookConfigurations are found, it proceeds to delete 
 ## them one by one.
 ## 
 ## 4. It iterates through the list of MutatingWebhookConfigurations 
 ## stored in `mwc_names` using a `for` loop and deletes each 
 ## configuration using `kubectl delete mutatingwebhookconfiguration 
 ## "$mwc"`.
 ## 
 ## 5. Once all MutatingWebhookConfigurations have been deleted, it 
 ## displays a message ("MutatingWebhookConfigurations deleted 
 ## successfully.").
 ## 
 ## Overall, the script is a simple automation tool to delete 
 ## MutatingWebhookConfigurations within a Kubernetes cluster if any are 
 ## found.

mwc_names=$(kubectl get mutatingwebhookconfigurations -o jsonpath='{.items[*].metadata.name}')

if [[ -z "$mwc_names" ]]; then
  echo "No MutatingWebhookConfigurations found."
  exit 0
fi

echo "Deleting MutatingWebhookConfigurations..."

for mwc in $mwc_names; do
  kubectl delete mutatingwebhookconfiguration "$mwc"
done

echo "MutatingWebhookConfigurations deleted successfully."


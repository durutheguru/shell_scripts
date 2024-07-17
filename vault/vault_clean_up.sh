#!/bin/bash


## This bash script performs the following actions:
 ## 
 ## 1. Sources the `~/.bash_profile`.
 ## 2. Deletes the Kubernetes namespaces `vault` and `vault-kms`.
 ## 3. Deletes the Certificate Signing Requests (CSR) `vault-csr` and 
 ## `vault-kms-csr`.
 ## 4. Deletes the Persistent Volume Claims (PVC) in the `vault` and 
 ## `vault-kms` namespaces.
 ## 5. Deletes the Persistent Volumes (PV) in the `vault` and `vault-kms` 
 ## namespaces.
 ## 6. Calls functions `kube_delete_pvs` and `kube_delete_mwc`.
 ## 7. Changes the directory to 
 ## `./setup_single_instance`
 ## and removes the `cluster-keys.json` file.
 ## 8. Changes the directory to 
 ## `../setup_multi_instance` 
 ## and removes the `cluster-keys.json` file.
 ## 
 ## Overall, this script is intended to clean up various resources 
 ## related to Vault and Kubernetes as well as delete specific files in 
 ## the specified directories.

source ~/.bash_profile


kubectl delete ns vault

kubectl delete ns vault-kms

kubectl delete csr vault-csr

kubectl delete csr vault-kms-csr

kubectl delete pvc -n vault

kubectl delete pvc -n vault-kms

kubectl delete pv -n vault

kubectl delete pv -n vault-kms

kube_delete_pvs

kube_delete_mwc

cd ./setup_single_instance
rm cluster-keys.json

cd ../setup_multi_instance
rm cluster-keys.json



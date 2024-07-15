#!/bin/bash


## This bash script does the following:
 ## 
 ## 1. Adds the HashiCorp Helm repository using the URL 
 ## https://helm.releases.hashicorp.com.
 ## 2. Updates the Helm repositories with the command `helm repo update`.
 ## 3. Creates a Kubernetes namespace named `vault-kms` using the 
 ## `kubectl create namespace` command with dry-run mode enabled and 
 ## output in YAML format, and then applies the configuration with the 
 ## `kubectl apply -f -` command.
 ## 4. Installs the HashiCorp Vault chart from the HashiCorp Helm 
 ## repository into the Kubernetes cluster using the `helm install` 
 ## command. It specifies the values from the 
 ## `vault_override_values.yaml` file, deploys the Vault instance into 
 ## the `vault-kms` namespace, and generates a name for the Vault 
 ## instance based on a template (`--name-template vault-kms-instance`).


# Add Hashicorp helm repo and update
helm repo add hashicorp https://helm.releases.hashicorp.com
helm repo update


kubectl create namespace vault-kms --dry-run=client -o yaml | kubectl apply -f -

helm install hashicorp/vault --values vault_override_values.yaml --namespace vault-kms --name-template vault-kms-instance



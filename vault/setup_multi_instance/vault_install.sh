#!/bin/bash


## This bash script performs the following actions:
 ## 
 ## 1. Adds the Hashicorp Helm repository and updates it.
 ## 2. Creates a Kubernetes namespace called 'vault' using a dry-run of 
 ## client and applies it.
 ## 3. Installs Consul Helm chart 'consul' from the hashicorp repository 
 ## in the 'vault' namespace using values from 'helm_consul_values.yaml'.
 ## 4. Installs Vault Helm chart 'vault' from the hashicorp repository in 
 ## the 'vault' namespace using values from 'vault_override_values.yaml'.
 ## 5. Initiates a Vault cluster with a single key share and threshold.
 ## 6. Unseals the Vault using the obtained unseal key across multiple 
 ## Vault instances.
 ## 7. Displays the root token retrieved during Vault initialization.
 ## 8. Attaches a shell to the 'vault-0' container to access the Vault 
 ## environment interactively.
 ## 
 ## Please note that parts of the script are commented out (such as the 
 ## initial YAML files), and additional configurations or commands not 
 ## explicitly stated may exist in those files.

# Add Hashicorp helm repo and update
helm repo add hashicorp https://helm.releases.hashicorp.com
helm repo update

# Create vault kubernetes namespace
kubectl create namespace vault --dry-run=client -o yaml | kubectl apply -f -


# kubectl apply -f auth_service_account.yaml


# kubectl apply -f role_binding.yaml


# Install Consul helm
helm install consul hashicorp/consul --values helm_consul_values.yaml --namespace vault

# Install Vault helm
helm install vault hashicorp/vault --values vault_override_values.yaml --namespace vault

# You can check the status of a vault pod with the following command:
# kubectl exec <<vault pod name>> -n vault -- vault status

# kubectl exec vault-0 -n vault -- vault operator init -key-shares=1 -key-threshold=1 -format=json > cluster-keys.json

# echo "Cluster Keys: "
# cat cluster-keys.json | jq -r ".unseal_keys_b64[]"

# VAULT_UNSEAL_KEY=$(cat cluster-keys.json | jq -r ".unseal_keys_b64[]")

# kubectl exec vault-0 -n vault -- vault operator unseal $VAULT_UNSEAL_KEY
# kubectl exec vault-1 -n vault -- vault operator unseal $VAULT_UNSEAL_KEY
# kubectl exec vault-2 -n vault -- vault operator unseal $VAULT_UNSEAL_KEY
# kubectl exec vault-3 -n vault -- vault operator unseal $VAULT_UNSEAL_KEY
# kubectl exec vault-4 -n vault -- vault operator unseal $VAULT_UNSEAL_KEY


# echo "Root Token: "
# cat cluster-keys.json | jq -r ".root_token"

# kubectl exec -ti vault-0 -n vault -- sh

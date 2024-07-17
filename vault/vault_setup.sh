#!/bin/bash


cd ./setup_single_instance
bash ./vault_kms_tls_setup.sh

bash ./vault_kms_install.sh

# Wait for Vault to be ready
echo "Waiting for Vault to be ready..."



while true; do
    
    if kubectl get pods -n vault-kms | grep vault-kms-instance | grep "0/1"; then
        echo "Vault is ready!!!"
        break
    fi

    sleep 2
done


echo "Checking Vault Status"
kubectl exec vault-kms-instance-0 -n vault-kms -- vault status


echo "Initializing Vault"
kubectl exec vault-kms-instance-0 -n vault-kms -- vault operator init -key-shares=1 -key-threshold=1 -format=json > cluster-keys.json


echo "Checking Vault Status"
kubectl exec vault-kms-instance-0 -n vault-kms -- vault status


VAULT_UNSEAL_KEY=$(cat cluster-keys.json | jq -r ".unseal_keys_b64[]")


echo "Unseal Key: $VAULT_UNSEAL_KEY"


echo "Unsealing Vault"
kubectl exec vault-kms-instance-0 -n vault-kms -- vault operator unseal $VAULT_UNSEAL_KEY


ROOT_TOKEN=$(cat cluster-keys.json | jq -r '.root_token')

kubectl exec -ti vault-kms-instance-0 -n vault-kms -- sh \
    -c "vault login $ROOT_TOKEN && \
    vault secrets enable transit && \
    vault write -f transit/keys/autounseal && \
    vault policy write autounseal -<<EOF       
path \"transit/encrypt/autounseal\" {
    capabilities = [ \"update\" ]
}

path \"transit/decrypt/autounseal\" {
    capabilities = [ \"update\" ]
}
EOF"

cd ../setup_multi_instance
bash ./tls_setup.sh

kubectl apply -f auth_service_account.yaml

kubectl apply -f role_binding.yaml


K8S_HOST=$(kubectl config view --raw --minify --flatten --output 'jsonpath={.clusters[].cluster.server}')

# kubectl exec -ti vault-kms-instance-0 -n vault-kms -- sh \
#     -c "vault login $ROOT_TOKEN && \
#     vault auth enable kubernetes && \
#     vault write auth/kubernetes/config \
#         token_reviewer_jwt='$(kubectl exec -ti vault-kms-instance-0 -n vault-kms -- cat /var/run/secrets/kubernetes.io/serviceaccount/token)' \
#         kubernetes_host='$K8S_HOST' \
#         kubernetes_ca_cert=@/var/run/secrets/kubernetes.io/serviceaccount/ca.crt && \
#     vault write auth/kubernetes/role/autounseal \
#         bound_service_account_names=vault-auth \
#         bound_service_account_namespaces=vault \
#         policies=autounseal \
#         ttl=1h"

kubectl exec -ti vault-kms-instance-0 -n vault-kms -- sh \
    -c "vault login $ROOT_TOKEN && \
    vault auth enable kubernetes && \
    vault write auth/kubernetes/config \
        token_reviewer_jwt='$(kubectl exec -ti vault-kms-instance-0 -n vault-kms -- cat /var/run/secrets/kubernetes.io/serviceaccount/token)' \
        kubernetes_host='https://$KUBERNETES_PORT_443_TCP_ADDR:443' \
        kubernetes_ca_cert=@/var/run/secrets/kubernetes.io/serviceaccount/ca.crt && \
    vault write auth/kubernetes/role/autounseal \
        bound_service_account_names=vault-auth \
        bound_service_account_namespaces=vault \
        policies=autounseal \
        ttl=1h"

    
WRAPPING_TOKEN=$(kubectl exec -ti vault-kms-instance-0 -n vault-kms -- vault token create -orphan -policy="autounseal" -wrap-ttl=600 -period=24h | awk '/wrapping_token:/{print $2}')
echo "$WRAPPING_TOKEN"

WRAPPING_TOKEN=$(echo "$WRAPPING_TOKEN" | tr -cd '[:print:]')
echo "Sanitized Wrapping Token: $WRAPPING_TOKEN"

UNWRAPPED_TOKEN=$(kubectl exec -ti vault-kms-instance-0 -n vault-kms -- sh -c "VAULT_TOKEN=$WRAPPING_TOKEN vault unwrap" | awk '/^token\s*[^_]/{print $2}')
echo "$UNWRAPPED_TOKEN"

UNWRAPPED_TOKEN=$(echo "$UNWRAPPED_TOKEN" | tr -cd '[:print:]')
echo "Sanitized Unwrapped Token: $UNWRAPPED_TOKEN"

file_path="vault_override_values.yaml"

sed -i "" "s|token = \".*\"|token = \"$UNWRAPPED_TOKEN\"|" "$file_path"

bash ./vault_install.sh

kubectl exec vault-0 -n vault -- vault status

# Wait for Vault to be ready
echo "Waiting for Vault to be ready..."


# Loop until the desired condition is met
while true; do
    # Check if Vault is ready
    if kubectl get pods -n vault | grep vault-0 | grep "0/1"; then
        echo "Vault is ready!!!"
        break
    fi

    # Sleep for a certain period before checking again
    sleep 2
done


kubectl exec vault-0 -n vault -- vault operator init -format=json > cluster-keys.json

# kubectl exec vault-0 -n vault -- vault operator init -key-shares=1 -key-threshold=1 -format=json > cluster-keys.json


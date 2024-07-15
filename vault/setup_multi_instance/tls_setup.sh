#!/bin/bash


## This bash script creates a TLS certificate and associated resources 
 ## for the Vault service running in a Kubernetes environment. Here is a 
 ## breakdown of the script:
 ## 
 ## 1. It sets various environment variables including the name of the 
 ## Vault service, the namespace where the service is running, the name 
 ## of the secret to be created, temporary working directory, and the 
 ## certificate signing request (CSR) name.
 ## 
 ## 2. It generates an RSA private key using OpenSSL and saves it in a 
 ## temporary directory.
 ## 
 ## 3. It creates a configuration file for the CSR with subject 
 ## alternative names (SAN) specifying the Vault service and its 
 ## different variations within the Kubernetes cluster.
 ## 
 ## 4. For each Vault pod (specified in the loop), it generates a 
 ## certificate signing request, saves it in the temporary directory, and 
 ## creates a CSR YAML file using Kubernetes API conventions.
 ## 
 ## 5. It creates and approves the certificate signing request for each 
 ## Vault pod, extracts the server certificate, and saves it in the 
 ## temporary directory.
 ## 
 ## 6. It extracts the CA certificate used by the Kubernetes cluster, 
 ## creates a namespace if it does not exist, and creates a Kubernetes 
 ## secret with the Vault server key and certificate.
 ## 
 ## 7. It creates a CA certificate secret as well.
 ## 
 ## 8. Lastly, the script includes commented-out sections for creating 
 ## additional resources such as Kubernetes secrets for KMS credentials 
 ## and for creating a Vault Webhook certificate (which is present in 
 ## another section commented out).
 ## 
 ## Overall, this script automates the process of generating TLS 
 ## certificates for the Vault service pods in a Kubernetes environment, 
 ## approving the certificate signing requests, and creating the 
 ## necessary secrets for secure communication within the cluster.


# SERVICE is the name of the Vault service in Kubernetes.
# It does not have to match the actual running service, though it may help for consistency.
export SERVICE=vault

# NAMESPACE where the Vault service is running.
export NAMESPACE=vault

# SECRET_NAME to create in the Kubernetes secrets store.
export SECRET_NAME=tls-server

# TMPDIR is a temporary working directory.
export TMPDIR=/tmp

# CSR_NAME will be the name of our certificate signing request as seen by Kubernetes.
export CSR_NAME=vault-csr


openssl genrsa -out ${TMPDIR}/vault.key 2048


cat <<EOF >${TMPDIR}/csr.conf
[req]
req_extensions = v3_req
distinguished_name = req_distinguished_name
[req_distinguished_name]
[ v3_req ]
basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
extendedKeyUsage = serverAuth
subjectAltName = @alt_names
[alt_names]
DNS.1 = ${SERVICE}
DNS.2 = ${SERVICE}.${NAMESPACE}
DNS.3 = ${SERVICE}.${NAMESPACE}.svc
DNS.4 = ${SERVICE}.${NAMESPACE}.svc.cluster.local
DNS.5 = vault-agent-injector-svc
DNS.6 = vault-agent-injector-svc.vault
DNS.7 = vault-agent-injector-svc.vault.svc
DNS.8 = vault-agent-injector-svc.vault.svc.cluster.local
IP.1 = 127.0.0.1
EOF


# Additional entries for the differnent Vault pods
for ((i=0; i<3; i++)); do
  NODE_NAME="${SERVICE}-${i}"
  offset=$((i * 7))
  echo "DNS.$((offset + 9)) = ${NODE_NAME}" >> ${TMPDIR}/csr.conf
  echo "DNS.$((offset + 10)) = ${NODE_NAME}.${NAMESPACE}" >> ${TMPDIR}/csr.conf
  echo "DNS.$((offset + 11)) = ${NODE_NAME}.${NAMESPACE}.svc" >> ${TMPDIR}/csr.conf
  echo "DNS.$((offset + 12)) = ${NODE_NAME}.${NAMESPACE}.svc.cluster.local" >> ${TMPDIR}/csr.conf
  echo "DNS.$((offset + 13)) = ${NODE_NAME}.${NAMESPACE}-internal" >> ${TMPDIR}/csr.conf
  echo "DNS.$((offset + 14)) = ${NODE_NAME}.${NAMESPACE}-internal.svc" >> ${TMPDIR}/csr.conf
  echo "DNS.$((offset + 15)) = ${NODE_NAME}.${NAMESPACE}-internal.svc.cluster.local" >> ${TMPDIR}/csr.conf
done



openssl req -new -key ${TMPDIR}/vault.key \
    -subj "/O=system:nodes/CN=system:node:${SERVICE}.${NAMESPACE}.svc" \
    -out ${TMPDIR}/server.csr \
    -config ${TMPDIR}/csr.conf


cat <<EOF >${TMPDIR}/csr.yaml
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: ${CSR_NAME}
spec:
  groups:
  - system:authenticated
  request: $(cat ${TMPDIR}/server.csr | base64 | tr -d '\r\n')
  signerName: kubernetes.io/kubelet-serving
  usages:
  - digital signature
  - key encipherment
  - server auth
EOF

kubectl create -f ${TMPDIR}/csr.yaml

kubectl certificate approve ${CSR_NAME}

kubectl get csr ${CSR_NAME}

# Possibly employ wait until certificate has been created

serverCert=$(kubectl get csr ${CSR_NAME} -o jsonpath='{.status.certificate}')

echo "Processing Server Cert: ${serverCert}"

echo "${serverCert}" | openssl base64 -d -A -out ${TMPDIR}/vault.crt

kubectl config view --raw --minify --flatten -o jsonpath='{.clusters[].cluster.certificate-authority-data}' | base64 -d > ${TMPDIR}/ca.crt

kubectl create namespace ${NAMESPACE}

echo -e "\nCA Certificate:\n"
cat ${TMPDIR}/ca.crt | base64


kubectl create secret generic ${SECRET_NAME} \
  --namespace ${NAMESPACE} \
  --from-file=vault.key=${TMPDIR}/vault.key \
  --from-file=vault.crt=${TMPDIR}/vault.crt


kubectl create secret generic tls-ca \
  --namespace ${NAMESPACE} \
  --from-file=ca.crt=${TMPDIR}/ca.crt


# kubectl create secret generic kms-creds \
#     --namespace ${NAMESPACE} \
#     --from-file=key.json=${TMPDIR}/key.json
















# #!/bin/bash


# # SERVICE is the name of the Vault service in Kubernetes.
# # It does not have to match the actual running service, though it may help for consistency.
# export SERVICE=vault

# # NAMESPACE where the Vault service is running.
# export NAMESPACE=vault

# # SECRET_NAME to create in the Kubernetes secrets store.
# export SECRET_NAME=tls-server

# # TMPDIR is a temporary working directory.
# export TMPDIR=/tmp

# # CSR_NAME will be the name of our certificate signing request as seen by Kubernetes.
# export CSR_NAME=vault-csr

# for ((i=0; i<5; i++)); do
#   NODE_NAME="${SERVICE}-${i}"

#   openssl genrsa -out ${TMPDIR}/${NODE_NAME}.key 2048

#   cat <<EOF >${TMPDIR}/csr.conf
# [req]
# req_extensions = v3_req
# distinguished_name = req_distinguished_name
# [req_distinguished_name]
# [ v3_req ]
# basicConstraints = CA:FALSE
# keyUsage = nonRepudiation, digitalSignature, keyEncipherment
# extendedKeyUsage = serverAuth
# subjectAltName = @alt_names
# [alt_names]
# DNS.1 = ${NODE_NAME}
# DNS.2 = ${NODE_NAME}.${NAMESPACE}
# DNS.3 = ${NODE_NAME}.${NAMESPACE}.svc
# DNS.4 = ${NODE_NAME}.${NAMESPACE}.svc.cluster.local
# IP.1 = 127.0.0.1
# EOF

#   openssl req -new -key ${TMPDIR}/${NODE_NAME}.key \
#       -subj "/O=system:nodes/CN=system:node:${NODE_NAME}.${NAMESPACE}.svc" \
#       -out ${TMPDIR}/${NODE_NAME}.csr \
#       -config ${TMPDIR}/csr.conf

#   cat <<EOF >${TMPDIR}/csr-${NODE_NAME}.yaml
# apiVersion: certificates.k8s.io/v1
# kind: CertificateSigningRequest
# metadata:
#   name: ${CSR_NAME}-${NODE_NAME}
# spec:
#   groups:
#   - system:authenticated
#   request: $(cat ${TMPDIR}/${NODE_NAME}.csr | base64 | tr -d '\r\n')
#   signerName: kubernetes.io/kubelet-serving
#   usages:
#   - digital signature
#   - key encipherment
#   - server auth
# EOF

#   kubectl create -f ${TMPDIR}/csr-${NODE_NAME}.yaml

#   kubectl certificate approve ${CSR_NAME}-${NODE_NAME}

#   # Wait until the certificate has been created
#   until kubectl get csr ${CSR_NAME}-${NODE_NAME} | grep "Approved"; do
#     sleep 1
#   done

#   serverCert=$(kubectl get csr ${CSR_NAME}-${NODE_NAME} -o jsonpath='{.status.certificate}')

#   echo "Processing Server Cert for ${NODE_NAME}: ${serverCert}"

#   echo "${serverCert}" | openssl base64 -d -A -out ${TMPDIR}/${NODE_NAME}.crt

#   kubectl create secret generic ${SECRET_NAME}-${NODE_NAME} \
#     --namespace ${NAMESPACE} \
#     --from-file=${NODE_NAME}.key=${TMPDIR}/${NODE_NAME}.key \
#     --from-file=${NODE_NAME}.crt=${TMPDIR}/${NODE_NAME}.crt

# done





# # Create the CA certificate

# kubectl config view --raw --minify --flatten -o jsonpath='{.clusters[].cluster.certificate-authority-data}' | base64 -d > ${TMPDIR}/ca.crt

# kubectl create namespace ${NAMESPACE}

# echo -e "\nCA Certificate:\n"
# cat ${TMPDIR}/ca.crt | base64

# kubectl create secret generic tls-ca \
#   --namespace ${NAMESPACE} \
#   --from-file=ca.crt=${TMPDIR}/ca.crt





# # Create the Vault Webhook certificate
# WEBHOOK_NAME="vault-webhook"
# openssl genrsa -out ${TMPDIR}/${WEBHOOK_NAME}.key 2048

# cat <<EOF >${TMPDIR}/csr-webhook.conf
# [req]
# req_extensions = v3_req
# distinguished_name = req_distinguished_name
# [req_distinguished_name]
# [ v3_req ]
# basicConstraints = CA:FALSE
# keyUsage = nonRepudiation, digitalSignature, keyEncipherment
# extendedKeyUsage = serverAuth
# subjectAltName = @alt_names
# [alt_names]
# DNS.1 = ${SERVICE}
# DNS.2 = ${SERVICE}.${NAMESPACE}
# DNS.3 = ${SERVICE}.${NAMESPACE}.svc
# DNS.4 = ${SERVICE}.${NAMESPACE}.svc.cluster.local
# IP.1 = 127.0.0.1
# EOF

# openssl req -new -key ${TMPDIR}/${WEBHOOK_NAME}.key \
#     -subj "/CN=${SERVICE}.${NAMESPACE}.svc" \
#     -out ${TMPDIR}/${WEBHOOK_NAME}.csr \
#     -config ${TMPDIR}/csr-webhook.conf

# cat <<EOF >${TMPDIR}/csr-${WEBHOOK_NAME}.yaml
# apiVersion: certificates.k8s.io/v1
# kind: CertificateSigningRequest
# metadata:
#   name: ${CSR_NAME}-${WEBHOOK_NAME}
# spec:
#   groups:
#   - system:authenticated
#   request: $(cat ${TMPDIR}/${WEBHOOK_NAME}.csr | base64 | tr -d '\r\n')
#   signerName: kubernetes.io/kubelet-serving
#   usages:
#   - digital signature
#   - key encipherment
#   - server auth
# EOF

# kubectl create -f ${TMPDIR}/csr-${WEBHOOK_NAME}.yaml

# kubectl certificate approve ${CSR_NAME}-${WEBHOOK_NAME}

# # Wait until the certificate has been created
# until kubectl get csr ${CSR_NAME}-${WEBHOOK_NAME} | grep "Approved"; do
#   sleep 1
# done

# webhookCert=$(kubectl get csr ${CSR_NAME}-${WEBHOOK_NAME} -o jsonpath='{.status.certificate}')

# echo "Processing Webhook Cert: ${webhookCert}"

# echo "${webhookCert}" | openssl base64 -d -A -out ${TMPDIR}/${WEBHOOK_NAME}.crt

# kubectl create secret generic ${SECRET_NAME}-${WEBHOOK_NAME} \
#   --namespace ${NAMESPACE} \
#   --from-file=${WEBHOOK_NAME}.key=${TMPDIR}/${WEBHOOK_NAME}.key \
#   --from-file=${WEBHOOK_NAME}.crt=${TMPDIR}/${WEBHOOK_NAME}.crt








###########################################################
##########################################################################
#######################################################################################
#######################################################





# #!/bin/bash


# # SERVICE is the name of the Vault service in Kubernetes.
# # It does not have to match the actual running service, though it may help for consistency.
# export SERVICE=vault

# # NAMESPACE where the Vault service is running.
# export NAMESPACE=vault

# # SECRET_NAME to create in the Kubernetes secrets store.
# export SECRET_NAME=tls-server

# # TMPDIR is a temporary working directory.
# export TMPDIR=/tmp

# # CSR_NAME will be the name of our certificate signing request as seen by Kubernetes.
# export CSR_NAME=vault-csr

# openssl genrsa -out ${TMPDIR}/vault.key 2048

# cat <<EOF >${TMPDIR}/csr.conf
# [req]
# req_extensions = v3_req
# distinguished_name = req_distinguished_name
# [req_distinguished_name]
# [ v3_req ]
# basicConstraints = CA:FALSE
# keyUsage = nonRepudiation, digitalSignature, keyEncipherment
# extendedKeyUsage = serverAuth
# subjectAltName = @alt_names
# [alt_names]
# DNS.1 = ${SERVICE}
# DNS.2 = ${SERVICE}.${NAMESPACE}
# DNS.3 = ${SERVICE}.${NAMESPACE}.svc
# DNS.4 = ${SERVICE}.${NAMESPACE}.svc.cluster.local
# IP.1 = 127.0.0.1
# EOF


# openssl req -new -key ${TMPDIR}/vault.key \
#     -subj "/O=system:nodes/CN=system:node:${SERVICE}.${NAMESPACE}.svc" \
#     -out ${TMPDIR}/server.csr \
#     -config ${TMPDIR}/csr.conf


# cat <<EOF >${TMPDIR}/csr.yaml
# apiVersion: certificates.k8s.io/v1
# kind: CertificateSigningRequest
# metadata:
#   name: ${CSR_NAME}
# spec:
#   groups:
#   - system:authenticated
#   request: $(cat ${TMPDIR}/server.csr | base64 | tr -d '\r\n')
#   signerName: kubernetes.io/kubelet-serving
#   usages:
#   - digital signature
#   - key encipherment
#   - server auth
# EOF

# kubectl create -f ${TMPDIR}/csr.yaml

# kubectl certificate approve ${CSR_NAME}

# kubectl get csr ${CSR_NAME}

# # Possibly employ wait until certificate has been created

# serverCert=$(kubectl get csr ${CSR_NAME} -o jsonpath='{.status.certificate}')

# echo "Processing Server Cert: ${serverCert}"

# echo "${serverCert}" | openssl base64 -d -A -out ${TMPDIR}/vault.crt

# kubectl config view --raw --minify --flatten -o jsonpath='{.clusters[].cluster.certificate-authority-data}' | base64 -d > ${TMPDIR}/ca.crt

# kubectl create namespace ${NAMESPACE}

# echo -e "\nCA Certificate:\n"
# cat ${TMPDIR}/ca.crt | base64


# kubectl create secret generic ${SECRET_NAME} \
#   --namespace ${NAMESPACE} \
#   --from-file=vault.key=${TMPDIR}/vault.key \
#   --from-file=vault.crt=${TMPDIR}/vault.crt


# kubectl create secret generic tls-ca \
#   --namespace ${NAMESPACE} \
#   --from-file=ca.crt=${TMPDIR}/ca.crt


# # kubectl create secret generic kms-creds \
# #     --namespace ${NAMESPACE} \
# #     --from-file=key.json=${TMPDIR}/key.json


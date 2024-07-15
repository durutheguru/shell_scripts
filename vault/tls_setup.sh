#!/bin/bash


## This bash script helps in creating a TLS server certificate for a 
 ## Vault service running in a Kubernetes environment. Here's a breakdown 
 ## of what the script does:
 ## 
 ## 1. It sets environment variables for the service name, namespace, 
 ## secret name, temporary directory, and certificate signing request 
 ## (CSR) name.
 ## 
 ## 2. Generates a new RSA private key for the certificate and saves it 
 ## in the temporary directory.
 ## 
 ## 3. Creates a configuration file for the CSR with subject alternative 
 ## names (SANs) including the service's name and namespace.
 ## 
 ## 4. Uses OpenSSL to generate a certificate signing request (CSR) based 
 ## on the private key and configuration file.
 ## 
 ## 5. Generates a YAML file for a CertificateSigningRequest resource in 
 ## Kubernetes with the CSR data encoded in Base64.
 ## 
 ## 6. Creates the CertificateSigningRequest resource in Kubernetes and 
 ## approves it.
 ## 
 ## 7. Extracts the signed TLS server certificate from Kubernetes and 
 ## saves it in the temporary directory.
 ## 
 ## 8. Retrieves the Kubernetes cluster's CA certificate and saves it in 
 ## the temporary directory.
 ## 
 ## 9. Creates a namespace in Kubernetes for the Vault service if it 
 ## doesn't already exist.
 ## 
 ## 10. Outputs the CA certificate for reference.
 ## 
 ## 11. Creates two Kubernetes secrets: one for the TLS server 
 ## certificate and private key, and another for the CA certificate.
 ## 
 ## 12. There is a commented-out section for creating another secret 
 ## 'kms-creds', potentially for key management service credentials.
 ## 
 ## Overall, the script automates the process of generating a TLS server 
 ## certificate, setting up the required Kubernetes resources, and 
 ## creating Kubernetes secrets for secure communication within the Vault 
 ## service.


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
IP.1 = 127.0.0.1

EOF


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


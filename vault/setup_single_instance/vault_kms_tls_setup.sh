#!/bin/bash


## This Bash script is designed to automate the process of generating a 
 ## TLS certificate for a Kubernetes Vault service and storing it 
 ## securely in Kubernetes secrets. Here is a breakdown of what the 
 ## script does:
 ## 
 ## 1. Sets various environment variables including the service name, 
 ## namespace, secret name, temporary directory, and certificate signing 
 ## request name.
 ## 2. Generates a private key using OpenSSL and stores it in a temporary 
 ## directory.
 ## 3. Creates a configuration file for the certificate signing request 
 ## (CSR) with subject alternative names (SANs) including the service 
 ## name and relevant namespaces.
 ## 4. Generates a certificate signing request (CSR) using the private 
 ## key and configuration file.
 ## 5. Creates a Kubernetes certificate signing request (CSR) YAML file 
 ## with the encoded CSR data and necessary metadata.
 ## 6. Submits the certificate signing request to Kubernetes using 
 ## `kubectl create`.
 ## 7. Approves the certificate signing request using `kubectl 
 ## certificate approve`.
 ## 8. Retrieves the server certificate from the approved CSR and decodes 
 ## it.
 ## 9. Retrieves the cluster's CA certificate and stores it in a 
 ## temporary file.
 ## 10. Creates a new Kubernetes namespace if it does not already exist.
 ## 11. Displays the CA certificate in base64 format.
 ## 12. Creates Kubernetes secrets for the generated private key, server 
 ## certificate, and CA certificate using `kubectl create secret`.
 ## 
 ## Overall, the script automates the process of generating a TLS 
 ## certificate, submitting it for approval, and securely storing it in 
 ## Kubernetes secrets for a Vault service running in a Kubernetes 
 ## cluster.


# SERVICE is the name of the Vault service in Kubernetes.
# It does not have to match the actual running service, though it may help for consistency.
export SERVICE=vault-kms-instance

# NAMESPACE where the Vault service is running.
export NAMESPACE=vault-kms

# SECRET_NAME to create in the Kubernetes secrets store.
export SECRET_NAME=vault-kms-tls

# TMPDIR is a temporary working directory.
export TMPDIR=/tmp

# CSR_NAME will be the name of our certificate signing request as seen by Kubernetes.
export CSR_NAME=vault-kms-csr

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



#!/bin/bash


## This bash script is used to generate SSL/TLS certificates using 
 ## OpenSSL. Here is a breakdown of what each command does:
 ## 
 ## 1. `openssl genrsa 2048 > privatekey.pem`: This command generates a 
 ## 2048-bit RSA private key and saves it into a file named 
 ## `privatekey.pem`. This private key will be used to sign the 
 ## certificate request and generate the public certificate.
 ## 
 ## 2. `openssl req -new -key privatekey.pem -out csr.pem`: This command 
 ## creates a new certificate signing request (CSR) using the private key 
 ## generated in the previous step. The CSR is saved in a file named 
 ## `csr.pem`. The CSR will contain details such as the domain name, 
 ## organization, and other relevant information to be included in the 
 ## certificate.
 ## 
 ## 3. `openssl x509 -req -days 365 -in csr.pem -signkey privatekey.pem 
 ## -out public.crt`: This command generates a self-signed public 
 ## certificate using the information in the CSR and the private key. The 
 ## certificate will be valid for 365 days (-days 365). The final public 
 ## certificate is saved into a file named `public.crt`.
 ## 
 ## Overall, this script automates the process of generating a private 
 ## key, creating a certificate signing request (CSR), and then using the 
 ## CSR to generate a self-signed public certificate, all using OpenSSL 
 ## commands.

openssl genrsa 2048 > privatekey.pem

openssl req -new -key privatekey.pem -out csr.pem

openssl x509 -req -days 365 -in csr.pem -signkey privatekey.pem -out public.crt




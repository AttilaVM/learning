#!/bin/bash
set -euo pipefail
set -x

mkdir -p sandbox
cd sandbox

# ------ Create Root CA Certificate -----

# Root CA OpenSSL config
cat << EOF > root-ca.cnf
[ req ]
default_bits       = 1024
default_md         = sha256
prompt             = no
distinguished_name = dn
x509_extensions    = v3_ca

[ dn ]
C = HU
ST = Budapest
L = Budapest
O = My Root CA
CN = My Root CA

[ v3_ca ]
basicConstraints = critical, CA:true, pathlen:3
keyUsage = critical, keyCertSign, cRLSign
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid:always
EOF

# Generates a self-signed certificate
# and the corresponding private key
openssl req \
  -new \
  -x509 \
  -days 3650 \
  -keyout rootCA.key.pem \
  -out rootCA.cert.pem \
  -config root-ca.cnf \
  -nodes

openssl x509 -in rootCA.cert.pem -noout -text

# ------ Create intermediate CA certificate -----

# Intermediate CA OpenSSL config
cat << EOF > intermediate-ca.cnf
[ req ]
default_bits       = 1024
default_md         = sha256
prompt             = no
distinguished_name = dn

[ dn ]
C = HU
ST = Budapest
L = Budapest
O = My Intermediate CA
CN = My Intermediate CA

[ v3_intermediate_ca ]
basicConstraints = critical, CA:true, pathlen:0
keyUsage = critical, keyCertSign, cRLSign
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid:always,issuer
EOF

# 1. Generate CA's private key
openssl genpkey \
  -algorithm RSA \
  -pkeyopt rsa_keygen_bits:1024 \
  -out intermediateCA.key.pem

# 2. Generate CA's certificate signing request
openssl req \
  -new \
  -key intermediateCA.key.pem \
  -out intermediateCA.csr.pem \
  -config intermediate-ca.cnf

openssl req -in intermediateCA.csr.pem -noout -text

# 3. Root CA signs the intermediate CSR
openssl x509 \
  -req \
  -in intermediateCA.csr.pem \
  -CA rootCA.cert.pem \
  -CAkey rootCA.key.pem \
  -CAcreateserial \
  -out intermediateCA.cert.pem \
  -days 1825 \
  -sha256 \
  -extfile intermediate-ca.cnf \
  -extensions v3_intermediate_ca

openssl x509 -in intermediateCA.cert.pem -noout -text

# Verify Intermediate CA against the root CA
openssl verify \
  -CAfile rootCA.cert.pem \
  intermediateCA.cert.pem

# Build a "full chain" file: leaf + intermediate ----
cat intermediateCA.cert.pem rootCA.cert.pem  > server.fullchain.pem

# ------ Create end-entity certificate -----

# ---- OpenSSL config for the leaf server cert ----
cat << 'EOF' > server.cnf
[ req ]
default_bits       = 1024
default_md         = sha256
prompt             = no
distinguished_name = dn
# Extensions to put into the CSR itself
req_extensions     = v3_req

[ dn ]
C  = HU
ST = Budapest
L  = Budapest
O  = My Test Server
CN = server.local

# ---- Extensions requested in the CSR ----
[v3_req]
# Not a CA (even if many CAs ignore basicConstraints in CSR, it's harmless)
basicConstraints = critical, CA:false

# All keyUsage bits except keyCertSign, cRLSign
keyUsage = critical, digitalSignature, nonRepudiation, keyEncipherment, \
           dataEncipherment, keyAgreement, encipherOnly, decipherOnly

extendedKeyUsage = serverAuth, clientAuth, emailProtection, codeSigning, \
                   timeStamping, OCSPSigning

# SAN goes into the CSR so the CA can copy it
subjectAltName = @alt_names

# ---- Extensions that will be put into the final CERT by the CA ----
[v3_server]
basicConstraints = critical, CA:false

# Same key usages as requested,
# normally decided what can be included by the issuer entity
keyUsage = critical, digitalSignature, nonRepudiation, keyEncipherment, \
           dataEncipherment, keyAgreement, encipherOnly, decipherOnly

extendedKeyUsage = serverAuth, clientAuth, emailProtection, codeSigning, \
                   timeStamping, OCSPSigning

subjectKeyIdentifier   = hash
authorityKeyIdentifier = keyid,issuer

# Copy the same SAN into the cert
subjectAltName = @alt_names

[ alt_names ]
DNS.1 = server.local
DNS.2 = localhost
IP.1  = 127.0.0.1
EOF

# 1. Generate server private key
openssl genpkey \
  -algorithm RSA \
  -pkeyopt rsa_keygen_bits:1024 \
  -out server.key.pem

# 2. Create CSR for the server cert
openssl req \
  -new \
  -key server.key.pem \
  -out server.csr.pem \
  -config server.cnf

# 3. Intermediate CA signs the server CSR
openssl x509 \
  -req \
  -in server.csr.pem \
  -CA intermediateCA.cert.pem \
  -CAkey intermediateCA.key.pem \
  -CAcreateserial \
  -out server.cert.pem \
  -days 825 \
  -sha256 \
  -extfile server.cnf \
  -extensions v3_server

openssl x509 -in server.cert.pem  -noout -text

# verify refencing certs in the chain one-by-one
openssl verify \
  -CAfile rootCA.cert.pem \
  -untrusted intermediateCA.cert.pem \
  server.cert.pem

# verify using the chain file
openssl verify \
  -CAfile server.fullchain.pem \
  server.cert.pem

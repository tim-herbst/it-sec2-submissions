#!/bin/bash

# Set variables
KEY_NAME="it_sec2.key"
CERT_NAME="it_sec2.crt"
DAYS_VALID=365
SUBJECT="/C=De/ST=Baden-Wuerttemberg/L=Stuttgart/O=HFT-Stuttgart/OU=IT-Security/CN=finish-study.io"

# Generate a private key
openssl genpkey -algorithm RSA -out $KEY_NAME -pkeyopt rsa_keygen_bits:2048

# Generate a self-signed certificate
openssl req -new -x509 -sha256 -key $KEY_NAME -out $CERT_NAME -days $DAYS_VALID -subj "$SUBJECT"

echo "Generated key and certificate:"
echo "Private Key: $KEY_NAME"
echo "Certificate: $CERT_NAME"
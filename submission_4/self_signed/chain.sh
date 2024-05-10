#!/bin/bash

# Variables
ROOT_KEY="rootCA.key"
ROOT_CERT="rootCA.crt"
INTERMEDIATE_KEY="intermediate.key"
INTERMEDIATE_CERT="intermediate.crt"
STORE_PASS="storepass"
KEY_PASS="keypass"
DAYS=365
STORE_NAME="mykeystore.p12"

# Generate Root CA key and certificate
openssl req -new -newkey rsa:2048 -days $DAYS -nodes -x509 -subj "/C=US/ST=California/L=San Francisco/O=MyRootCA/CN=myrootca.com" -keyout $ROOT_KEY -out $ROOT_CERT

# Generate Intermediate key and certificate
openssl req -new -newkey rsa:2048 -nodes -keyout $INTERMEDIATE_KEY -subj "/C=US/ST=California/L=San Francisco/O=MyIntermediateCA/CN=myintermediateca.com" -out intermediate.csr
openssl x509 -req -in intermediate.csr -CA $ROOT_CERT -CAkey $ROOT_KEY -CAcreateserial -out $INTERMEDIATE_CERT -days $DAYS

# Convert Root CA to PKCS12 format
openssl pkcs12 -export -name rootCA -in $ROOT_CERT -inkey $ROOT_KEY -out rootCA.p12 -password pass:$STORE_PASS

# Convert Intermediate to PKCS12 format
openssl pkcs12 -export -name intermediateCA -in $INTERMEDIATE_CERT -inkey $INTERMEDIATE_KEY -out intermediateCA.p12 -password pass:$STORE_PASS

# Create keystore with both certificates
keytool -importkeystore -deststorepass $STORE_PASS -destkeystore $STORE_NAME -srckeystore rootCA.p12 -srcstoretype PKCS12 -srcstorepass $STORE_PASS -alias rootCA
keytool -importkeystore -deststorepass $STORE_PASS -destkeystore $STORE_NAME -srckeystore intermediateCA.p12 -srcstoretype PKCS12 -srcstorepass $STORE_PASS -alias intermediateCA

# View the keystore
keytool -list -keystore $STORE_NAME -storepass $STORE_PASS
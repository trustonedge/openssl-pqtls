# OpenSSL-based PQ-TLS

This repository provides an improved version of [tls-quantum-safe](https://github.com/seantywork/linuxyz/tree/main/tls-quantum-safe).

## Prerequisites

1. [Install OpenSSL](./docs/openssl-installation.md)  
2. [Set up liboqs](./docs/liboqs-setup.md)  

> **Note**: 
> This setup uses a VM to install a newer system-level OpenSSL version. Don't do it for local system.

## Certificates & Keys

Used **self-signed CA certificates** and **ML-DSA-65** for certs and keys.

### Generate CA certificate
```bash
openssl req -x509 -new -newkey mldsa65 \
  -keyout ca/ca-key.pem \
  -out ca/ca-cert.pem \
  -nodes \
  -subj "/CN=microsoft" \
  -days 3650
```

### Generate server key & CSR

```bash
openssl genpkey -algorithm mldsa65 -out server/server-key.pem

openssl req -new -newkey mldsa65 \
  -keyout server/server-key.pem \
  -out server/server.csr \
  -nodes \
  -subj "/CN=rules"
```

### Sign server certificate with CA

```bash
openssl x509 -req \
  -in server/server.csr \
  -out server/server-cert.pem \
  -CA ca/ca-cert.pem \
  -CAkey ca/ca-key.pem \
  -CAcreateserial \
  -days 365
```

## Build

Compile server and client:

```bash
make
```

Clean build artifacts:

```bash
make clean
```

## Run

Start the server:

```bash
./server/server.out
```

Run the client:

```bash
./client/client.out
```
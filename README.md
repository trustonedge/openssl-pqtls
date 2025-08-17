# OpenSSL-based PQ-TLS

This repository provides an enhanced version of [tls-quantum-safe](https://github.com/seantywork/linuxyz/tree/main/tls-quantum-safe), demonstrating post-quantum TLS using OpenSSL with [liboqs](https://github.com/open-quantum-safe/liboqs).

## Prerequisites

1. [Install OpenSSL](./docs/openssl-installation.md)  
2. [Set up liboqs](./docs/liboqs-setup.md)  

> [!NOTE] 
> Use a virtual machine (VM) for installation. Replacing the system-level OpenSSL on your host machine is not recommended.

## Certificates and Keys

This setup uses **self-signed CA certificates** and **ML-DSA-65** for keys and certificates.

### 1. Generate CA certificate

```bash
mkdir ca/
openssl req -x509 -new -newkey mldsa65 \
  -keyout ca/ca-key.pem \
  -out ca/ca-cert.pem \
  -nodes \
  -subj "/CN=microsoft" \
  -days 3650
````

### 2. Generate server key and CSR

```bash
openssl genpkey -algorithm mldsa65 -out server/server-key.pem

openssl req -new -newkey mldsa65 \
  -keyout server/server-key.pem \
  -out server/server.csr \
  -nodes \
  -subj "/CN=rules"
```

### 3. Sign server certificate with CA

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

Compile the server and client:

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

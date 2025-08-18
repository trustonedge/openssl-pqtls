# OpenSSL Installation Guide

## Overview

This guide explains how to build and install the latest stable version of [OpenSSL](https://github.com/openssl/openssl) (3.5.x LTS or higher) in the system’s default locations.  

> [!IMPORTANT]
> It is strongly recommended to perform this installation in a virtual machine (VM) or dedicated environment to avoid breaking system-wide dependencies.

## Required Dependencies
Install the build dependencies:

```bash
sudo apt update
sudo apt install -y build-essential checkinstall zlib1g-dev libssl-dev
sudo apt install -y perl-modules-5.* perl-doc
```

## Step 1: Download and Verify OpenSSL 3.5.x

OpenSSL 3.5.x can be downloaded from the official [GitHub releases page](https://github.com/openssl/openssl/releases/)

```bash
# Create a working directory
mkdir -p ~/openssl-build && cd ~/openssl-build

# Download OpenSSL 3.5.1 (replace with latest version if available)
wget https://github.com/openssl/openssl/releases/download/openssl-3.5.1/openssl-3.5.1.tar.gz
wget https://github.com/openssl/openssl/releases/download/openssl-3.5.1/openssl-3.5.1.tar.gz.sha256

# Verify the checksum
sha256sum -c openssl-3.5.1.tar.gz.sha256

# Extract source code
tar -xzf openssl-3.5.1.tar.gz
cd openssl-3.5.1
```

## Step 2: Configure OpenSSL 3.5.x

Configure OpenSSL for a system-wide installation using default paths:

```bash
./config
```

## Step 3: Compile OpenSSL

```bash
# Compile OpenSSL (parallel build using all available cores)
make -j$(nproc)

# Run test suite (recommended but optional)
make test
```

## Step 4: Install OpenSSL

```bash
# Install OpenSSL (requires root privileges)
sudo make install

# Update library cache
sudo ldconfig
```

## Step 5: Verify Installation

**Check which OpenSSL is being used by default:**

```bash
openssl version -a
```

![openssl-version-check](./images/openssl-v351.png)
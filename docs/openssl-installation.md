# OpenSSL Installation Guide

## Overview

This guide explains how to build and install the latest stable version of [OpenSSL](https://github.com/openssl/openssl) (3.5.x LTS or higher) in the system’s default locations.

> [!IMPORTANT]
> It is strongly recommended to perform this installation in a **virtual machine (VM)** or dedicated environment to avoid breaking system-wide dependencies.
>
> ⚠️ Never overwrite your system OpenSSL with `ldconfig`, as it may break `sshd` or package-managed software. Instead, configure your shell to use the new OpenSSL only for your user.

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

Configure OpenSSL for installation into `/usr/local/`:

```bash
./config --prefix=/usr/local --openssldir=/usr/local/ssl
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
```

## Step 5: Update User Environment

Instead of running `ldconfig` (which globally overrides libraries and can break SSH/system processes), we make OpenSSL 3.5.x available only for your user by editing `~/.bashrc`.

Open `~/.bashrc` and add at the bottom:

```bash
# Use custom OpenSSL 3.5.1
export PATH=/usr/local/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/lib64:$LD_LIBRARY_PATH
```

Apply the changes:

```bash
source ~/.bashrc
```

**Why Edit `.bashrc` Instead of Clearing the Library Cache?**

* Running `sudo ldconfig /usr/local/lib64/` updates the system-wide dynamic linker cache.
* This forces all services (including `sshd`) to load the new OpenSSL libraries, which may cause **connection failures** if the library ABI doesn’t match what the service expects.
* By setting `PATH` and `LD_LIBRARY_PATH` in `.bashrc`, only your **interactive shell** uses the new OpenSSL, while system services safely continue using the default version.

## Step 6: Verify Installation

**Check which OpenSSL is being used by default:**

```bash
which openssl
openssl version -a
```

![openssl-version-check](./images/openssl-v351.png)
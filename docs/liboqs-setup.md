# LibOQS Setup

This guide explains how to build and install [liboqs](https://github.com/open-quantum-safe/liboqs) from source.


## 1. Install prerequisites

```bash
sudo apt install astyle cmake gcc ninja-build libssl-dev \
  python3-pytest python3-pytest-xdist unzip xsltproc \
  doxygen graphviz python3-yaml valgrind
```

## 2. Clone the repository

```bash
git clone -b main https://github.com/open-quantum-safe/liboqs.git
cd liboqs
```

## 3. Create a build directory

```bash
mkdir build && cd build
```

## 4. Configure the build

```bash
cmake -GNinja ..
```

## 5. Build the library

```bash
ninja
```

## 6. Install the library

```bash
sudo ninja install
```
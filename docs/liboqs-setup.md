### LibOQS Setup

To build and install [liboqs](https://github.com/open-quantum-safe/liboqs) from source, follow these steps:

1. **Clone the repository:**
   ```bash
   git clone -b main https://github.com/open-quantum-safe/liboqs.git
   cd liboqs
   ```

2. **Create a build directory:**
   ```bash
   mkdir build && cd build
   ```

3. **Configure the build:**
   ```bash
   cmake -GNinja ..
   ```

4. **Build the library:**
   ```bash
   ninja
   ```

5. **Install the library:**
   ```bash
   sudo ninja install
   ```
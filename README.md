<p align="center">
  <img src="https://github.com/TMCIT-LowLayer-Institute/NanoUnix/assets/78244973/7b1f4dde-b3fb-46be-a170-d5530a764bac" alt="NanoUnix Logo" width="200" height="200">
</p>

**NanoUnix Operating System**
========================

NanoUnix is a lightweight operating system based on the re-implementation of Dennis Ritchie's and Ken Thompson's Unix Version 6 (v6) called xv6. xv6 loosely follows the structure and style of v6 but is implemented for a modern RISC-V multiprocessor using ANSI C.

*Acknowledgments*
-------------------

NanoUnix is inspired by John Lions's Commentary on UNIX 6th Edition and builds upon the foundation laid by the xv6 operating system. See MIT's xv6 website for additional resources related to v6.

The main contributors to NanoUnix include:

- [unixtech-06](https://github.com/unixtech-06)
- (Add other contributors as needed)

**License**
-----------

The code in the files that constitute NanoUnix is Copyright 2006-2022 Frans Kaashoek, Robert Morris, and Russ Cox.

**Build and Run NanoUnix**
---------------------

To build and run NanoUnix, you will need a RISC-V "newlib" toolchain, available from riscv-gnu-toolchain. Additionally, qemu compiled for riscv64-softmmu is required. Once installed and in your shell search path, use the following command to build and run NanoUnix:

```bash
make qemu

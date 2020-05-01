
# Fmt

An experimental Oberon-7 module to provide formatting
procedures for INTEGER and REAL values inspired by Karl 
Landström's OBNC oberon compiler and his extension library.  

## Installation

### Prerequisite

This repository assumes you have installed Karl Landström's
[OBNC](https://miasap.se/obnc/) compiler v0.16.1 or better.
It assumes you have a working C tool chain configured (e.g. 
clang, gcc, make). If you can compile and install Karl's extenions
modules [obnc-libext-0.7.0.tar.gz](https://miasap.se/obnc/downloads/obnc-libext_0.7.0.tar.gz) then you should be able to install this
package.

### Setup

The installation process was inspired by Karl's scripts for
`https://miasap.se/obnc/downloads/obnc-libext_0.7.0.tar.gz` 
and mirrors that process and most of those assumptions.

The basic process is

1. build
2. test
3. install

In the shell I do

```bash
    ./build.bash && ./test.bash && ./install.bash
```

By default modules are installed relative to your home 
directory but if you want to install them in a system 
directory for other users (e.g. `/usr/local`) then try

```bash
    ./build.bash && ./test.bash && ./install.bash --prefix=/usr/local
```


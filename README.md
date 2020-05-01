
# Fmt

An experimental Oberon-7 module to provide format functions
for INTEGER and REAL values. It is inspired by Karl Landström's
OBNC oberon compiler and his extension library.  

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

## Usage

This module is intended to be used with other Obeorn-7 programs
and module. This is an example of retrieving the Unix epoch.

```Oberon
    MODULE Fmt;
      IMPORT Out;
    VAR
      i : INTEGER;
      r : REAL;
      fmt : ARRAY 24 OF CHAR;
      dest : ARRAY 128 OF CHAR;

    BEGIN
      i := 42;
      Fmt.Int(i, "%4d", dest);
      Out.String("Formatted i: ");Out.String(dest);Out.Ln;
      r := 42.0;
      Fmt.Real(i, "%4.2f", dest);
      Out.String("Formatted r: ");Out.String(dest);Out.Ln;
    END Fmt.
```

## License

This software is freely distributed under a BSD/MIT type license.  Please see the [LICENSE](LICENSE) file for more information.

## Acknowledgments

This project would not be possible with Oberon so a giant thank you
goes to Niklaus Wirth, Jürg Gutknecht, Martin Reiser, Paul Reed et el.

A big thanks also goes to Karl Landström for creating OBNC a very nice
open source Oberon-7 compiler.


# Cpp compilation process
- Notes taken from [Compilers Ultra](https://www.compilersutra.com/docs/how_to/how_to_build_cpp_with_make/)

## Different types of Cpp files

1. `source.cpp`
2. `preprocessed.i`
	- takes the `#include` sections from the header files and brings them into one file
3. `compiled-to-assembly.s`
4. `object-code.o`
5. `final-linked-executable.out/exe`
    - `.out` -> is a legacy format but compilers still output the `.out` named file even though it's really just a made binary

A build = compilation -> linking (and maybe optimisation as well)

## Compiler commands

```bash
g++ main.cpp
#compiles the source code file specified into a .out executable

g++ -S main.cpp -o main.s
# makes assembly code and stops there
```

## Build systems
The compilation commands however can quickly get very large so you need to use a build system.
- Common ones: Make(file), CMake, etc

CMake is supposedly the best of the bad bunch, certainly the one I have heard the most about
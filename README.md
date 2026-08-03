# Running the image to develop

1. Make sure to have build the docker image:
```bash
sudo docker build -t cpp-dev-suite .
```

2. Run the image interactively and build, providing your current username
```bash
sudo docker run -it --mount type=bind,src=$(pwd),dst=/app --rm cpp-dev-suite
```
- `-it` runs interactive terminal from the base `ubuntu` image
- `--mount ...` binds your files in the local source directory into the container destination directory and any changes made there get saved locally
    - now means you need to add the user to the root group to edit them since they're made within a container
- `--rm` automatically removes a container once it is dead

# Cpp compilation process
- Notes taken from [Compilers Ultra](https://www.compilersutra.com/docs/how_to/how_to_build_cpp_with_make/)

## Different types of Cpp files

1. `source.cpp`
2. `preprocessed.i`
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

## Makefile syntax

*General structure:*
```Makefile
target:
	command
```
- `command` runs when you do `make target`
- if only 1 target then it is ran by default when doing `make`

Exists a `help` target to make your own built-in guide
- requires an `@echo` preface instead of an `echo` 
- suppresses default behaviour of `make` (normally shwo commandc being executed when it runs it)

You can provide prerequisites for a target after naming it:

```Makefile
target: prereq_1.file prereq_2.file
	command
```
- checks if the file already exists/needs building based on the time stamps
    - alternatively checks if there is a rule/target to build a file before building the

### Multiple files
You can specify the file to be used with `make` outside of the default `Makefile` name by passing the `-f` parameter
- `make -f dev-makefile` and `make -f prod-makefile` in the same directory

### Structure of a longer file
You can call targets from other targets, creating a chain of compilation commands to build the expected files
- generally need some entry point to building the project

```Makefile
# compiler and flags established as variables to be dragged and dropped in
CC = g++
CFLAGS = -Wall -std=c++17


# main entry point to the compilation process, calling 
all: main

# builds the final object files without any of the linked libraries
main: main.o mathfun.o
	$(CC) $(CFLAGS) main.o mathfun.o -o main
# -o means to choose output file name linking two files together

# Compile main.cpp and assmble it into object code but do not link
main.o: main.cpp mathfun.h
	$(CC) $(CFLAGS) -c main.cpp
# -c means to only compile/assemble but don't link

# Do same as above
mathfun.o: mathfun.cpp mathfun.h
	$(CC) $(CFLAGS) -c mathfun.cpp

# Clean build artifacts
clean:
	rm -f *.o main

# Help command for user guidance
help:
	@echo "make       - build the project"
	@echo "make clean - remove object files and binaries"
	@echo "make help  - display help info"
```
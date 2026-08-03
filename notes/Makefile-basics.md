# Makefile syntax
- Notes taken from [Compilers Ultra](https://www.compilersutra.com/docs/how_to/how_to_build_cpp_with_make/)

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

## Multiple files
You can specify the file to be used with `make` outside of the default `Makefile` name by passing the `-f` parameter
- `make -f dev-makefile` and `make -f prod-makefile` in the same directory

## Structure of a longer file
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

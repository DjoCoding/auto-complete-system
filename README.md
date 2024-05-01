# TEXT AUTO COMPLETE PROJECT
This projet implements the text auto complete feature found in most of today's applications

## 

## PROJECT STRUCTURE

```
.
├── assets
    └── usage.txt

├── bin
    ├── build.sh
    ├── main
    ├── run.sh
    └── test

├── source
    ├── clickf.pas
    ├── colorf.pas
    ├── entryf.pas
    ├── errorf.pas
    ├── graphf.pas
    ├── handlerf.pas
    ├── inputf.pas
    ├── main.pas
    ├── parserf.pas
    ├── pfile.pas
    ├── ptypef.pas
    ├── queuef.pas
    ├── stackf.pas
    ├── string_viewf.pas
    ├── test.pas
    ├── tokenizerf.pas
    └── treef.pas

    ├── files
        └── exemple_file
    ├── graphs
        └── exemple_file.out

├── todo.md
├── README.md
```

## EXPLANATION
This project is implemented using the prefix-tree data structure 

### FILES:

+ treef.pas: contains the implementation of the prefix-tree data structure

+ inputf.pas: handles the user input on the command line depends on the files:
    + lexerf.pas: for lexing the user input (more about lexing  (click here)[https://www.geeksforgeeks.org/introduction-of-lexical-analysis/])

    + tokenizerf.pas: for tokenizing the user input (more about tokenizing (click here)[https://www.geeksforgeeks.org/nlp-how-tokenizing-text-sentence-words-works/])

    + parserf.pas: for parsing the user input and generating output (more about parsing (click here)[https://www.geeksforgeeks.org/introduction-of-parsing-ambiguity-and-parsers-set-1/])
    
    + clickf.pas: for collecting the data from the user on the command line

    + errorf.pas: for the error handling

+ bufferf.pas: implements the buffer data structure (more about the buffer data structure (click here)[https://www.geeksforgeeks.org/gap-buffer-data-structure/])

+ queuef.pas: implements the queue data structure (more about the queue data structure (click here)[https://geeksforgeeks.org/queue-data-structure/])

+ string_viewf.pas: implements the string view data structure (more about the string view data structure (click here)[https://www.geeksforgeeks.org/class-stdstring_view-in-cpp-17/])

+ main.pas: the main file, it generates the project output!


## Getting Started

Follow these instructions to compile and run the programs:

### Prerequisites

- **FREE PASCAL COMPILER**: Make sure you have **fpc** installed to compile the **PASCAL** programs.

### Compilation

To compile the programs, use the following commands in your terminal:

```bash
$ cd bin
$ ./build.sh
```
## Usage

#### EXECTUING
After compiling, run the programs as follows:
```bash
$ ./run.sh
```

#### COMMANDS

```
COMMANDS:
           :add <filename>*                  : to add one or more files to the tree!
           :show  !<options>                 : show all the words available in the tree!
                  options: 
                       -dir                  : show the current directory for the files!
                       -gdir                 : show the directory where the graphs are located!
           :dir <option> <dirname>           : to set the directory in which the files exists!
                  options: 
                        -c                   : set the files directory!
                        -g                   : set the graph directory!
           :graph <filename>                 : outputs a file that contains source code for the tree generation! (use [graphviz](https://edotor.net/))

```



# Author
- BOUHADDA MOHAMME DJAOUED
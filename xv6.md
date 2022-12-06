TODO 

Why say xv6 based on instruction set RISC-V? Where is complier?

[xargs with pipe?](https://stackoverflow.com/questions/35589179/when-to-use-xargs-when-piping)

xargs -n?
```bash
 xv6-labs-2021   util ±  echo "1\n2\n3\n4" | xargs -n 2 echo line
line 1 2
line 3 4
 xv6-labs-2021   util ±  echo "1\n2\n3\n4" | xargs -n 1 echo line
line 1
line 2
line 3
line 4
```

# Ch1 Operating system interfaces

Why OS?
- share computer among programs
- provide services covering on hardware

xv6?
- mimic Unix internal design
- modern os have Unix-like interfaces, Linux,macOS,Windows...

Unix kernels? How interact?
- The collection of system calls that a kernel provides is the interface that user programs see?

Shell?
- An ordinary USER program, reads commands from user and executes them
- NOT PART OF THE KERNEL
  - That means the shell is easy to replace
    - oh-my-zsh

## 1.1 Process and memory

xv6 process consists of?
- user-space memory(instructions, data, stack)
- per-process state private to the kernel
  - when a process not executing, xv6 saves its CPU registers, restoring them next run

```exec```
- when exec succeeds, it does not return to the calling program
- instead, the instructions loaded from the file start executing

```sbrk```
- for runtime extra memory need(```malloc```)

## 1.2 I/O and File descriptors

file descriptor?
- a small integer, representing a kernel-managed object, process may read/write
- A newly allocated file descriptor is always the lowest numbered unused descriptor of the current process
  - ```close``` system call release a file descriptor

How file descriptor interact with ```fork```?
- ```Fork``` copies parent's file descriptor table, along with its memory
- ```Exec``` replaces the memory, but preserves its file table
    ```c
    char *argv[2];
    argv[0] = "cat";
    argv[1] = 0;
    if(fork() == 0) {
        close(0);
        open("input.txt", O_RDONLY);
        exec("cat", argv);
    }
    ```
    - example how to reuse descriptor $0$
    - I/O redirection works in exactly this way
      - fork a child$\rightarrow$ child close file descriptor $0$ $\rightarrow$ child open input.txt 

Why ```fork``` and ```exec``` are separate?
- Between the two, the shell has a chance to redirect the child's I/O without disturbing the I/O setup of the main shell

```dup``` system
- duplicate an existing file descriptor, share write offset
    ```c
    fd = dup(1);
    write(1, "hello ", 6);
    write(fd, "world\n", 6);
    ```
    - **a hidden effect: dup will generate a file descriptor, which means close(0) then dup will assign 0(stdin) to dup's argument!**

When two file descriptors share an offset?
- if they were derived from the same original file descriptor, by ```fork``` or ```dup```

```ls existing-file non-existing-file > tmp1 2>&1```
- >The 2>&1 tells the shell to give the command a file descriptor 2 that is a duplicate of descriptor 1
- Here we direct the error message to &1(stdout), &2 is stderr

## 1.3 Pipes

What's pipe?
- a small kernel buffer, exposed to processes
- **PROCESSES CAN USE IT TO COMMUNICATE!!!**

Why you need to call ```close```?
- if no data available, ```read``` will block until have data/all write end closed
- Hence leave a file not closed may block another process

Why PIPE fork and exec for both end?
- ```echo 1 | sleep 100``` will output 1 then directly end if left is father other than both siblings

PIPE's applicatoin?
- temporary file, ```echo hello | wc```
  - advantages over temporary files?
    1. automatically clean themselves
    2. arbitrarily long streams of data, no requirement for free disk space
    3. auto allow parallel execution, read will wait for write
       - file will read nothing and return
    4. Even though read&write is blocking, pipe is still MORE EFFICIENT THAN NON-BLOCING SEMANTICS OF FILES, when doing inter-process communication

## 1.4 File system

```mknod```?
- create a special file, refer to a device(mouse/printer...)
- when process open a device file, kernel diverts ```read```&```write``` system calls, to the kernel device implementation, instead of passing them to the file system

Link?
- one inode's multiple names
- each link consistes of an entry in a directory
  - entry contains a file name and a reference to an inode
- read/write from a link is same as from original file
  ```c
    fd = open("/tmp/xyz", O_CREATE|O_RDWR);
    unlink("/tmp/xyz");
  ```
  - will create a nameless inode, which will be auto cleaned up

utilities?
- >Unix provides file utilities callable from the shell as user-level programs, for example mkdir,
ln, and rm. This design allows anyone to extend the command-line interface by adding new userlevel programs.Other systems designed at the time of
Unix often built such commands into the shell (and built the shell into the kernel).
- ```cd``` must in shell, since from shell ```fork``` a son and call ```cd``` won't change shell's working directory

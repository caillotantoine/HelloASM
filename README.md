# HelloASM
Small git with my assembly tests

## Compile
```
nasm -fmacho64 hello.asm && ld -macosx_version_min 10.7.0 -o hello hello.o && ./hello
```

## Source

(NASM Tutorial)[https://cs.lmu.edu/~ray/notes/nasmtutorial/]
(‘Hello World’ Assembly Program on macOS Mojave)[https://medium.com/@thisura1998/hello-world-assembly-program-on-macos-mojave-d5d65f0ce7c6]

# HelloASM
Small git with my assembly tests

## Compile
```
nasm -fmacho64 hello.asm && ld -macosx_version_min 10.7.0 -o hello hello.o && ./hello

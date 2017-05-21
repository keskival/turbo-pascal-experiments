@echo off
echo off

echo Please wait, compiling VESA-library.
gcc -O3 -Wall -c -o vesa.a vesa.c

echo Please wait, compiling esim1.exe.

gcc -O3 -Wall -o esim1.exe esim1.c vesa.a


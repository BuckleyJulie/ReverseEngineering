# Author

Name: Julie Buckley

Student Number: C00200976

# License

This project is licensed under the GNU General Public License (GPL). See the LICENSE file for more details.

# Project Description

This project is an x86 Assembly program that reads a string from the user, converts uppercase letters to lowercase and vice versa, and prints the modified string.

# Instructions to Compile and Run

Ensure you have NASM and the GCC linker installed:

sudo apt update && sudo apt install nasm gcc

Compilation & Execution

Assemble the program using NASM:

nasm -f elf32 Project.asm -o Project.o

Link the object file using GCC:

gcc -m32 -nostartfiles -o Project Project.o

Run the executable:

./Project

# Issues/Notes

The program currently supports only ASCII characters. Non-ASCII input may result in unexpected behavior.

Ensure the input string does not exceed 100 characters to prevent buffer overflows.

The program reads input using SYS_READ, which captures the newline character (\n). The conversion logic removes this before processing.

This program is designed for 32-bit Linux environments. 

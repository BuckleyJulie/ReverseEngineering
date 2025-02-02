SYS_EXIT  equ 1               ; Exit system call
SYS_READ  equ 3               ; Read system call
SYS_WRITE equ 4               ; Write system call
STDIN     equ 0               ; Standard input file descriptor
STDOUT    equ 1               ; Standard output file descriptor

segment .data                 ; Data section
    msg1 db "Enter a String: ", 0xA, 0xD 	; Message to prompt for input
    len1 equ $ - msg1          			; Length of the prompt message
    msg2 db "The Reverse case is: " 		; Result message
    len2 equ $ - msg2         ; Length of result message

segment .bss                  ; BSS section (uninitialised data space)
    string resb 101           ; Reserve 101 bytes for user input
    res resb 100              ; Reserve 100 bytes for output

segment .text                 ; Code section
    global _start             ; Entry point for the program

_start:
    ; Print "Enter a String" prompt
    mov eax, SYS_WRITE        ; System call for writing
    mov ebx, STDOUT           ; Output to STDOUT
    mov ecx, msg1             ; Display message 1
    mov edx, len1             ; Length of message 1
    int 0x80                  ; Execute the system call

    ; Read the user input
    mov eax, SYS_READ         ; System call for reading input
    mov ebx, STDIN            ; Input from STDIN
    mov ecx, string           ; Store input in 'string’
    mov edx, 100              ; Max length of the input
    int 0x80                  ; Execute the system call

    mov ecx, eax              ; Get the length of the input string
    dec ecx                   ; Remove newline character

    ; Initialize pointers for string reversal and case change
    mov esi, string           ; Pointer to the input string
    mov edi, res              ; Pointer to the result buffer

loop:
    ; If we've processed all characters, print the result
    cmp ecx, 0		      ; compare ecx to 0
    je print_result	      ; jump to print result if ecx == 0

    mov al, [esi]	      ; Load the current character from 'string' into al

    ; Check if the character is uppercase
    cmp al, 'A'		      ; compare al to ‘A’
    jl not_uppercase	      ; jump to not_uppercase if al <= ‘A’
    cmp al, 'Z'		      ; compare al to ‘Z’
    jg not_uppercase	      ; jump to not_uppercase if al >= ‘Z’

    ; Convert uppercase to lowercase
    add al, 32		      ; add 32 to the character to make lowercase
    jmp store_char	      ; jump to store_char when changed to lowercase

not_uppercase:
    ; Check if the character is lowercase
    cmp al, 'a'		      ; compare al to ‘a’
    jl store_char	      ; jump to store_char if al <= ‘a’
    cmp al, 'z'		      ; compare al to ‘z’
    jg store_char	      ; jump to store_char if al >= ‘z’

    ; Convert lowercase to uppercase
    sub al, 32		      ; subtract 32 from the character to make uppercase

store_char:
    ; Store the converted character in 'res'
    mov [edi], al	      ; move contents of al in the memory address stored in edi
    inc esi		      ; increment esi to next input character
    inc edi		      ; increment edi to next output position
    loop loop		      ; loop to top of loop

print_result:
    ; Print "The Reverse case is:" message
    mov eax, SYS_WRITE        ; System call for writing	
    mov ebx, STDOUT           ; Output to STDOUT
    mov ecx, msg2             ; Display message 2
    mov edx, len2             ; Length of message 2
    int 0x80                  ; Execute the system call

    ; Print the resulting string with swapped cases
    mov eax, SYS_WRITE        ; System call for writing
    mov ebx, STDOUT           ; Output to STDOUT
    mov ecx, res              ; Display Result
    mov edx, 100              ; Max length of result
    int 0x80                  ; Execute the system call

    ; Exit the program
    mov eax, SYS_EXIT	      ; System call for Exit
    xor ebx, ebx	      ; XOR ebx with ebx == 0
    int 0x80                  ; Execute the system call
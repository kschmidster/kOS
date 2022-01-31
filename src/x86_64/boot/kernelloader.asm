section .multiboot
header_start:
	; magic number
	dd 0xe85250d6 ; multiboot2
	; architecture
	dd 0 ; protected mode i386
	; header length
	dd header_end - header_start
	; checksum
	dd 0x100000000 - (0xe85250d6 + 0 + (header_end - header_start))

	; end tag
	dw 0
	dw 0
	dd 8
header_end:

global loader

section .text
loader:
    ; print Hello World!
	mov dword [0xb8000], 0x2f652f48 ; He
    mov dword [0xb8004], 0x2f6c2f6c ; ll
    mov dword [0xb8008], 0x2f202f6f ; o 
    mov dword [0xb800c], 0x2f6f2f57 ; Wo
    mov dword [0xb8010], 0x2f6c2f72 ; rl
    mov dword [0xb8014], 0x2f212f64 ; d!
	hlt

_stop:
    cli
    hlt
    jmp _stop

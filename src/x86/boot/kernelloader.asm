section .multiboot
bits 32
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
extern kmain

section .text
loader:
	mov esp, stack_top
	call kmain

	hlt


_stop:
    cli
    hlt
    jmp _stop

section .bss
stack_bottom:
	resb 2*1024*1024 ; 2MiB
stack_top:

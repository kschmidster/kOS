asm_source_files_x86 = $(shell find src/x86/boot/ -name *.asm)
asm_object_files_x86 = $(patsubst src/x86/boot/%.asm, build/x86/boot/%.o, $(asm_source_files_x86))


default: kOS_x86.iso;

$(asm_object_files_x86): build/x86/boot/%.o : src/x86/boot/%.asm
	mkdir -p build/x86/boot
	nasm -f elf32 $< -o $@
	
kkernel_x86.bin: src/x86/linker/linker.ld $(asm_object_files_x86) 
	ld -melf_i386 -o $@ -T $< $(asm_object_files_x86)
	mv kkernel_x86.bin targets/x86/iso/boot
	
kOS_x86.iso: kkernel_x86.bin
	grub-mkrescue -o $@ targets/x86/iso
	

clean:
	rm -rf build/x86
	find . -name "*x86.iso" -type f -delete
	find targets/x86 -name "*.bin" -type f -delete

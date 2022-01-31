TARGET?=x86

ifeq ($(TARGET),x86)
	NASM_PARAMS=elf32
endif
ifeq ($(TARGET),x86_64)
	NASM_PARAMS=elf64
endif

ifeq ($(TARGET),x86)
	LD_PARAMS=-melf_i386
endif


default: kOS_$(TARGET).iso

asm_source_files = $(shell find src/$(TARGET)/boot/ -name *.asm)
asm_object_files = $(patsubst src/$(TARGET)/boot/%.asm, build/$(TARGET)/boot/%.o, $(asm_source_files))

$(asm_object_files): build/$(TARGET)/boot/%.o : src/$(TARGET)/boot/%.asm
	mkdir -p build/$(TARGET)/boot
	nasm -f $(NASM_PARAMS) $< -o $@
	
kkernel_$(TARGET).bin: src/$(TARGET)/linker/linker.ld $(asm_object_files) 
	ld $(LD_PARAMS) -o $@ -T $< $(asm_object_files)
	mv $@ targets/$(TARGET)/iso/boot
	
kOS_$(TARGET).iso: kkernel_$(TARGET).bin
	grub-mkrescue -o $@ targets/$(TARGET)/iso
	

clean:
	rm -rf build/$(TARGET)
	find . -name "*$(TARGET).iso" -type f -delete
	find targets/$(TARGET) -name "*.bin" -type f -delete
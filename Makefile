GPP_PARAMS=-std=c++1z -m32 -fno-use-cxa-atexit -nostdlib -fno-builtin -fno-rtti -fno-exceptions -fno-leading-underscore -Wno-write-strings

asm_source_files_x86 = $(shell find src/x86/ -name *.asm)
asm_object_files_x86 = $(patsubst src/x86/%.asm, build/x86/%.o, $(asm_source_files_x86))

cpp_source_files = $(shell find src/x86/ -name *.cpp)
cpp_object_files = $(patsubst src/x86/%.cpp, build/x86/%.o, $(cpp_source_files))


default: kOS_x86.iso;

$(asm_object_files_x86): build/x86/%.o : src/x86/%.asm
	mkdir -p $(@D)
	nasm -f elf32 $< -o $@

$(cpp_object_files): build/x86/%.o : src/x86/%.cpp
	mkdir -p $(@D)
	g++ $(GPP_PARAMS) -c -o $@ $<
	
kkernel_x86.bin: src/x86/linker/linker.ld $(asm_object_files_x86) $(cpp_object_files)
	ld -melf_i386 -o $@ -T $< $(asm_object_files_x86) $(cpp_object_files)
	mv kkernel_x86.bin targets/x86/iso/boot
	
kOS_x86.iso: kkernel_x86.bin
	grub-mkrescue -o $@ targets/x86/iso
	

clean:
	rm -rf build/x86
	find . -name "*x86.iso" -type f -delete
	find targets/x86 -name "*.bin" -type f -delete

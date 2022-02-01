unsigned short* const VIDEO_MEMORY = (unsigned short*)0xb8000;

void kprintf(const char* str) {
    for(int i {0}; str[i] != '\0'; ++i){
        VIDEO_MEMORY[i] = (str[i] | (unsigned short)0x2f00);
    }
}

extern "C" void kmain(){
    kprintf("Hello World!");
}
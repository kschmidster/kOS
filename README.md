# kOS
Hello everybody! With this project I am getting myself into OS development. And I will do this by writing a small OS. kOS (spoken like chaos) stands for kschmidster OS. Yeah, I know very creativ. The OS will not have many features. For at most it will have a terminal like 'GUI' if you will, and you will only be able to do the most basic things. We will see where it leads me, but my goal here is just to learn more about OS development.

**Discaimer:** The code I am writting here might not be optimal or even correct. So if you run this code on your machine it could potentially harm your hardware. I do not take any responsibilities if your hardware breaks.

## Build kOS
I use Visual Studio Code on Windows 10. There I use WSL (Windows Subsystem for Linux) with Ubuntu 20.04 LTS to compile the OS. On Ubuntu I had to install a few programms to make it work.

```
sudo apt-get install -y make grub-common grub-pc build-essential xorriso nasm
```

Since WSL runs a very basic Ubuntu you have to install make. We also use the bootloader GRUB to boot the OS. For that we need grub-common and grub-pc. The build-essentioal for the compiler and also nasm to build the assembler files. xorriso is used to together with GRUB to build a bootable ISO file.

To build the OS run the following command in WSL Ubuntu

```
make 
```
This will build the OS for 32bit. If you want to build for 64bit you would have to override the TARGET
```
make TARGET=x86_64
```

Also if you would run
```
make clean
```
it would clean the 32bit version by default. Run
```
make clean TARGET=x86_64
```
to clean the 64bit version.

## Run kOS
I use VirtualBox to run my OS. Simply create a VM with no hard disk (at the moment we do not need one) and 64MB of RAM (which at this poit is way enough). Select the built ISO file and boot the VM. If you see a 'Hello World!' on a green background everything worked.

To start my VM after the setup I use git-bash 

```
/c/and/wherever/VirtualBoxVM.exe --startvm kOS_x86
```
to launch the OS
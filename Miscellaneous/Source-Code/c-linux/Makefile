# Using x64? $ sudo apt instlal -y libc6-dev-i386

all: x64 x86

create:
	mkdir -p bin/

x64: create
	gcc -m64 -static -o bin/root-shellx64 root-shell.c

x86: create
	gcc -m32 -static -o bin/root-shellx86 root-shell.c

strip:
	strip bin/*

result:
	file bin/*

clean:
	rm -rf bin/

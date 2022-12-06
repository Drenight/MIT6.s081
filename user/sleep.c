#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
    if(argc < 2){
        fprintf(2, "args is not enough\n");
        exit(0);
    }
    int tick = atoi(argv[1]);
    sleep(tick);

    exit(0);
}

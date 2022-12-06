#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
    int p_Ping[2];
    int p_Pong[2];
    pipe(p_Ping);
    pipe(p_Pong);

    int pid=fork();
    if(pid==0){ //son, read and send
        close(0);
        dup(p_Ping[0]);
        char s[30];
        read(0,s,30);
        fprintf(1, "%d: received ping\n",getpid());
        write(p_Pong[1],"ww",sizeof("ww"));
        close(p_Pong[1]);
    }else if(pid>0){
        close(0);
        dup(p_Pong[0]);
        write(p_Ping[1], "ww", sizeof("ww"));
        close(p_Ping[1]);
        char s[30];
        read(0,s,30);
        fprintf(1, "%d: received pong\n",getpid());
    }else{
        fprintf(2, "fork error");
        exit(1);
    }
    
    exit(0);
}

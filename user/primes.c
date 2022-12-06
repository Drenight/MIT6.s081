#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

void sieve(int p){
    int x;
    int xx;
    fprintf(1,"read port %d\n",p);
    if(read(p,&x,4)==0){
        close(p);
        return;
    }else{
        fprintf(1,"prime %d\n",x);
    }

    if(read(p,&xx,4)!=0){
        int pp[2];
        pipe(pp);

        fprintf(1,"new pipe %d, %d\n",pp[0],pp[1]);
        int pid = fork();
        if(pid == 0){
            close(pp[1]);
            sieve(pp[0]);
        }else if(pid > 0){
            close(pp[0]);
            if(xx%x != 0){
                write(pp[1],&xx,4);
            }
            while(read(p,&xx,4)!=0){
                if(xx%x != 0){
                    write(pp[1],&xx,4);
                }
            }
            close(p);
            close(pp[1]);
            wait(0);
        }else{
            fprintf(2,"fork error");
            exit(1);
        }
    }else{
        close(p);
    }
    exit(0);
}

int
main(int argc, char *argv[])
{
    int p[2];
    pipe(p);

    int pid = fork();
    if(pid>0){
        close(p[0]);
        for(int i=2;i<=35;i++){
            write(p[1],&i,4);
        }
        close(p[1]);
        wait(0);
    }else if(pid==0){
        close(p[1]);
        sieve(p[0]);
    }else{
        fprintf(2, "fork error");
        exit(1);
    }
    exit(0);
}

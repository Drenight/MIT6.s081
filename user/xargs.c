#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int main(int argc, char* argv[]){
    char ch;
    char* op[10];
    for(int i=0;i<argc;i++){
        op[i] = malloc(128);
    }

    for(int i=1;i<argc;i++){
        strcpy(op[i-1],argv[i]);
        //fprintf(1, "argv %d is %s\n",i,op[i-1]);
    }
    
    int cnt=0; 
    while(read(0, &ch, 1) != 0){
        //printf("%c",ch);
        op[argc-1][cnt++]=ch;
        if(ch == '\n'){
            op[argc-1][cnt-1]='\0';
            int pid = fork();
            if(pid == 0){
                if(exec(op[0], op) < 0){
                    fprintf(2,"exec error\n");
                }               
            }else{
                wait(0);
            }
        }
    }
    exit(0);
}
#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"

char*
fmtname(char *path)
{
  //static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
    ;
  p++;

    /*
  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
    return p;
  memmove(buf, p, strlen(p));
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  return buf;
  */
 return p;
}

void find(char* path, char* target){    //find path target->find path/subpath target

    //printf("path: %s, target: %s\n",path, target);

    int fd;
    struct stat st;
    struct dirent de;
    char buf[512], *p;

    if((fd = open(path, 0)) < 0){
        fprintf(2, "find: cannot open %s\n", path);
        return;
    }
    if(fstat(fd, &st) < 0){
        fprintf(2, "ls: cannot stat %s\n", path);
        close(fd);
        return;
    }

    switch(st.type){
    case T_FILE:
        char *sTMP = fmtname(path);
        if(strcmp(sTMP, target)==0){
            //printf("%s %d %d %l\n", fmtname(path), st.type, st.ino, st.size);
            printf("%s\n", path);
        }
        break;
    case T_DIR:
        if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
            printf("find: path too long\n");
            break;
        }
        strcpy(buf, path);
        p = buf+strlen(buf);
        *p++ = '/';
        while(read(fd, &de, sizeof(de)) == sizeof(de)){
            if(de.inum == 0)
                continue;
            memmove(p, de.name, DIRSIZ);
            p[DIRSIZ] = 0;
            if(stat(buf, &st) < 0){
                printf("ls: cannot stat %s\n", buf);
                continue;
            }

            //printf("iter: %s %d %d %d, fmtname is %s, fmt_target %s\n", buf, st.type, st.ino, st.size, fmtname(buf), fmtname(target));
            if(strcmp(de.name,".")==0 || strcmp(de.name,"..")==0){
                continue;
            }else{
                find(buf, target);
            }
        }
        break;
    }
  close(fd);
}

int main(int argc, char* argv[]){
    if(argc<2){
        fprintf(2,"lack args\n");
        exit(1);
    }
    find(argv[1],argv[2]);
    exit(0);
}
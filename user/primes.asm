
user/_primes:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <sieve>:
#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

void sieve(int p){
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	1800                	addi	s0,sp,48
   a:	84aa                	mv	s1,a0
    int x;
    int xx;
    fprintf(1,"read port %d\n",p);
   c:	862a                	mv	a2,a0
   e:	00001597          	auipc	a1,0x1
  12:	98a58593          	addi	a1,a1,-1654 # 998 <malloc+0xe6>
  16:	4505                	li	a0,1
  18:	00000097          	auipc	ra,0x0
  1c:	7b4080e7          	jalr	1972(ra) # 7cc <fprintf>
    if(read(p,&x,4)==0){
  20:	4611                	li	a2,4
  22:	fdc40593          	addi	a1,s0,-36
  26:	8526                	mv	a0,s1
  28:	00000097          	auipc	ra,0x0
  2c:	482080e7          	jalr	1154(ra) # 4aa <read>
  30:	c55d                	beqz	a0,de <sieve+0xde>
        close(p);
        return;
    }else{
        fprintf(1,"prime %d\n",x);
  32:	fdc42603          	lw	a2,-36(s0)
  36:	00001597          	auipc	a1,0x1
  3a:	97258593          	addi	a1,a1,-1678 # 9a8 <malloc+0xf6>
  3e:	4505                	li	a0,1
  40:	00000097          	auipc	ra,0x0
  44:	78c080e7          	jalr	1932(ra) # 7cc <fprintf>
    }

    if(read(p,&xx,4)!=0){
  48:	4611                	li	a2,4
  4a:	fd840593          	addi	a1,s0,-40
  4e:	8526                	mv	a0,s1
  50:	00000097          	auipc	ra,0x0
  54:	45a080e7          	jalr	1114(ra) # 4aa <read>
  58:	10050763          	beqz	a0,166 <sieve+0x166>
        int pp[2];
        pipe(pp);
  5c:	fd040513          	addi	a0,s0,-48
  60:	00000097          	auipc	ra,0x0
  64:	442080e7          	jalr	1090(ra) # 4a2 <pipe>

        fprintf(1,"new pipe %d, %d\n",pp[0],pp[1]);
  68:	fd442683          	lw	a3,-44(s0)
  6c:	fd042603          	lw	a2,-48(s0)
  70:	00001597          	auipc	a1,0x1
  74:	94858593          	addi	a1,a1,-1720 # 9b8 <malloc+0x106>
  78:	4505                	li	a0,1
  7a:	00000097          	auipc	ra,0x0
  7e:	752080e7          	jalr	1874(ra) # 7cc <fprintf>
        int pid = fork();
  82:	00000097          	auipc	ra,0x0
  86:	408080e7          	jalr	1032(ra) # 48a <fork>
        if(pid == 0){
  8a:	c525                	beqz	a0,f2 <sieve+0xf2>
            close(pp[1]);
            sieve(pp[0]);
        }else if(pid > 0){
  8c:	0aa05f63          	blez	a0,14a <sieve+0x14a>
            close(pp[0]);
  90:	fd042503          	lw	a0,-48(s0)
  94:	00000097          	auipc	ra,0x0
  98:	426080e7          	jalr	1062(ra) # 4ba <close>
            if(xx%x != 0){
  9c:	fd842783          	lw	a5,-40(s0)
  a0:	fdc42703          	lw	a4,-36(s0)
  a4:	02e7e7bb          	remw	a5,a5,a4
  a8:	e3b5                	bnez	a5,10c <sieve+0x10c>
                write(pp[1],&xx,4);
            }
            while(read(p,&xx,4)!=0){
  aa:	4611                	li	a2,4
  ac:	fd840593          	addi	a1,s0,-40
  b0:	8526                	mv	a0,s1
  b2:	00000097          	auipc	ra,0x0
  b6:	3f8080e7          	jalr	1016(ra) # 4aa <read>
  ba:	c13d                	beqz	a0,120 <sieve+0x120>
                if(xx%x != 0){
  bc:	fd842783          	lw	a5,-40(s0)
  c0:	fdc42703          	lw	a4,-36(s0)
  c4:	02e7e7bb          	remw	a5,a5,a4
  c8:	d3ed                	beqz	a5,aa <sieve+0xaa>
                    write(pp[1],&xx,4);
  ca:	4611                	li	a2,4
  cc:	fd840593          	addi	a1,s0,-40
  d0:	fd442503          	lw	a0,-44(s0)
  d4:	00000097          	auipc	ra,0x0
  d8:	3de080e7          	jalr	990(ra) # 4b2 <write>
  dc:	b7f9                	j	aa <sieve+0xaa>
        close(p);
  de:	8526                	mv	a0,s1
  e0:	00000097          	auipc	ra,0x0
  e4:	3da080e7          	jalr	986(ra) # 4ba <close>
        }
    }else{
        close(p);
    }
    exit(0);
}
  e8:	70a2                	ld	ra,40(sp)
  ea:	7402                	ld	s0,32(sp)
  ec:	64e2                	ld	s1,24(sp)
  ee:	6145                	addi	sp,sp,48
  f0:	8082                	ret
            close(pp[1]);
  f2:	fd442503          	lw	a0,-44(s0)
  f6:	00000097          	auipc	ra,0x0
  fa:	3c4080e7          	jalr	964(ra) # 4ba <close>
            sieve(pp[0]);
  fe:	fd042503          	lw	a0,-48(s0)
 102:	00000097          	auipc	ra,0x0
 106:	efe080e7          	jalr	-258(ra) # 0 <sieve>
 10a:	a81d                	j	140 <sieve+0x140>
                write(pp[1],&xx,4);
 10c:	4611                	li	a2,4
 10e:	fd840593          	addi	a1,s0,-40
 112:	fd442503          	lw	a0,-44(s0)
 116:	00000097          	auipc	ra,0x0
 11a:	39c080e7          	jalr	924(ra) # 4b2 <write>
 11e:	b771                	j	aa <sieve+0xaa>
            close(p);
 120:	8526                	mv	a0,s1
 122:	00000097          	auipc	ra,0x0
 126:	398080e7          	jalr	920(ra) # 4ba <close>
            close(pp[1]);
 12a:	fd442503          	lw	a0,-44(s0)
 12e:	00000097          	auipc	ra,0x0
 132:	38c080e7          	jalr	908(ra) # 4ba <close>
            wait(0);
 136:	4501                	li	a0,0
 138:	00000097          	auipc	ra,0x0
 13c:	362080e7          	jalr	866(ra) # 49a <wait>
    exit(0);
 140:	4501                	li	a0,0
 142:	00000097          	auipc	ra,0x0
 146:	350080e7          	jalr	848(ra) # 492 <exit>
            fprintf(2,"fork error");
 14a:	00001597          	auipc	a1,0x1
 14e:	88658593          	addi	a1,a1,-1914 # 9d0 <malloc+0x11e>
 152:	4509                	li	a0,2
 154:	00000097          	auipc	ra,0x0
 158:	678080e7          	jalr	1656(ra) # 7cc <fprintf>
            exit(1);
 15c:	4505                	li	a0,1
 15e:	00000097          	auipc	ra,0x0
 162:	334080e7          	jalr	820(ra) # 492 <exit>
        close(p);
 166:	8526                	mv	a0,s1
 168:	00000097          	auipc	ra,0x0
 16c:	352080e7          	jalr	850(ra) # 4ba <close>
 170:	bfc1                	j	140 <sieve+0x140>

0000000000000172 <main>:

int
main(int argc, char *argv[])
{
 172:	7179                	addi	sp,sp,-48
 174:	f406                	sd	ra,40(sp)
 176:	f022                	sd	s0,32(sp)
 178:	ec26                	sd	s1,24(sp)
 17a:	1800                	addi	s0,sp,48
    int p[2];
    pipe(p);
 17c:	fd840513          	addi	a0,s0,-40
 180:	00000097          	auipc	ra,0x0
 184:	322080e7          	jalr	802(ra) # 4a2 <pipe>

    int pid = fork();
 188:	00000097          	auipc	ra,0x0
 18c:	302080e7          	jalr	770(ra) # 48a <fork>
    if(pid>0){
 190:	02a04063          	bgtz	a0,1b0 <main+0x3e>
        for(int i=2;i<=35;i++){
            write(p[1],&i,4);
        }
        close(p[1]);
        wait(0);
    }else if(pid==0){
 194:	e93d                	bnez	a0,20a <main+0x98>
        close(p[1]);
 196:	fdc42503          	lw	a0,-36(s0)
 19a:	00000097          	auipc	ra,0x0
 19e:	320080e7          	jalr	800(ra) # 4ba <close>
        sieve(p[0]);
 1a2:	fd842503          	lw	a0,-40(s0)
 1a6:	00000097          	auipc	ra,0x0
 1aa:	e5a080e7          	jalr	-422(ra) # 0 <sieve>
 1ae:	a889                	j	200 <main+0x8e>
        close(p[0]);
 1b0:	fd842503          	lw	a0,-40(s0)
 1b4:	00000097          	auipc	ra,0x0
 1b8:	306080e7          	jalr	774(ra) # 4ba <close>
        for(int i=2;i<=35;i++){
 1bc:	4789                	li	a5,2
 1be:	fcf42a23          	sw	a5,-44(s0)
 1c2:	02300493          	li	s1,35
            write(p[1],&i,4);
 1c6:	4611                	li	a2,4
 1c8:	fd440593          	addi	a1,s0,-44
 1cc:	fdc42503          	lw	a0,-36(s0)
 1d0:	00000097          	auipc	ra,0x0
 1d4:	2e2080e7          	jalr	738(ra) # 4b2 <write>
        for(int i=2;i<=35;i++){
 1d8:	fd442783          	lw	a5,-44(s0)
 1dc:	2785                	addiw	a5,a5,1
 1de:	0007871b          	sext.w	a4,a5
 1e2:	fcf42a23          	sw	a5,-44(s0)
 1e6:	fee4d0e3          	bge	s1,a4,1c6 <main+0x54>
        close(p[1]);
 1ea:	fdc42503          	lw	a0,-36(s0)
 1ee:	00000097          	auipc	ra,0x0
 1f2:	2cc080e7          	jalr	716(ra) # 4ba <close>
        wait(0);
 1f6:	4501                	li	a0,0
 1f8:	00000097          	auipc	ra,0x0
 1fc:	2a2080e7          	jalr	674(ra) # 49a <wait>
    }else{
        fprintf(2, "fork error");
        exit(1);
    }
    exit(0);
 200:	4501                	li	a0,0
 202:	00000097          	auipc	ra,0x0
 206:	290080e7          	jalr	656(ra) # 492 <exit>
        fprintf(2, "fork error");
 20a:	00000597          	auipc	a1,0x0
 20e:	7c658593          	addi	a1,a1,1990 # 9d0 <malloc+0x11e>
 212:	4509                	li	a0,2
 214:	00000097          	auipc	ra,0x0
 218:	5b8080e7          	jalr	1464(ra) # 7cc <fprintf>
        exit(1);
 21c:	4505                	li	a0,1
 21e:	00000097          	auipc	ra,0x0
 222:	274080e7          	jalr	628(ra) # 492 <exit>

0000000000000226 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 226:	1141                	addi	sp,sp,-16
 228:	e422                	sd	s0,8(sp)
 22a:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 22c:	87aa                	mv	a5,a0
 22e:	0585                	addi	a1,a1,1
 230:	0785                	addi	a5,a5,1
 232:	fff5c703          	lbu	a4,-1(a1)
 236:	fee78fa3          	sb	a4,-1(a5)
 23a:	fb75                	bnez	a4,22e <strcpy+0x8>
    ;
  return os;
}
 23c:	6422                	ld	s0,8(sp)
 23e:	0141                	addi	sp,sp,16
 240:	8082                	ret

0000000000000242 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 242:	1141                	addi	sp,sp,-16
 244:	e422                	sd	s0,8(sp)
 246:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 248:	00054783          	lbu	a5,0(a0)
 24c:	cb91                	beqz	a5,260 <strcmp+0x1e>
 24e:	0005c703          	lbu	a4,0(a1)
 252:	00f71763          	bne	a4,a5,260 <strcmp+0x1e>
    p++, q++;
 256:	0505                	addi	a0,a0,1
 258:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 25a:	00054783          	lbu	a5,0(a0)
 25e:	fbe5                	bnez	a5,24e <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 260:	0005c503          	lbu	a0,0(a1)
}
 264:	40a7853b          	subw	a0,a5,a0
 268:	6422                	ld	s0,8(sp)
 26a:	0141                	addi	sp,sp,16
 26c:	8082                	ret

000000000000026e <strlen>:

uint
strlen(const char *s)
{
 26e:	1141                	addi	sp,sp,-16
 270:	e422                	sd	s0,8(sp)
 272:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 274:	00054783          	lbu	a5,0(a0)
 278:	cf91                	beqz	a5,294 <strlen+0x26>
 27a:	0505                	addi	a0,a0,1
 27c:	87aa                	mv	a5,a0
 27e:	86be                	mv	a3,a5
 280:	0785                	addi	a5,a5,1
 282:	fff7c703          	lbu	a4,-1(a5)
 286:	ff65                	bnez	a4,27e <strlen+0x10>
 288:	40a6853b          	subw	a0,a3,a0
 28c:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 28e:	6422                	ld	s0,8(sp)
 290:	0141                	addi	sp,sp,16
 292:	8082                	ret
  for(n = 0; s[n]; n++)
 294:	4501                	li	a0,0
 296:	bfe5                	j	28e <strlen+0x20>

0000000000000298 <memset>:

void*
memset(void *dst, int c, uint n)
{
 298:	1141                	addi	sp,sp,-16
 29a:	e422                	sd	s0,8(sp)
 29c:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 29e:	ca19                	beqz	a2,2b4 <memset+0x1c>
 2a0:	87aa                	mv	a5,a0
 2a2:	1602                	slli	a2,a2,0x20
 2a4:	9201                	srli	a2,a2,0x20
 2a6:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 2aa:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 2ae:	0785                	addi	a5,a5,1
 2b0:	fee79de3          	bne	a5,a4,2aa <memset+0x12>
  }
  return dst;
}
 2b4:	6422                	ld	s0,8(sp)
 2b6:	0141                	addi	sp,sp,16
 2b8:	8082                	ret

00000000000002ba <strchr>:

char*
strchr(const char *s, char c)
{
 2ba:	1141                	addi	sp,sp,-16
 2bc:	e422                	sd	s0,8(sp)
 2be:	0800                	addi	s0,sp,16
  for(; *s; s++)
 2c0:	00054783          	lbu	a5,0(a0)
 2c4:	cb99                	beqz	a5,2da <strchr+0x20>
    if(*s == c)
 2c6:	00f58763          	beq	a1,a5,2d4 <strchr+0x1a>
  for(; *s; s++)
 2ca:	0505                	addi	a0,a0,1
 2cc:	00054783          	lbu	a5,0(a0)
 2d0:	fbfd                	bnez	a5,2c6 <strchr+0xc>
      return (char*)s;
  return 0;
 2d2:	4501                	li	a0,0
}
 2d4:	6422                	ld	s0,8(sp)
 2d6:	0141                	addi	sp,sp,16
 2d8:	8082                	ret
  return 0;
 2da:	4501                	li	a0,0
 2dc:	bfe5                	j	2d4 <strchr+0x1a>

00000000000002de <gets>:

char*
gets(char *buf, int max)
{
 2de:	711d                	addi	sp,sp,-96
 2e0:	ec86                	sd	ra,88(sp)
 2e2:	e8a2                	sd	s0,80(sp)
 2e4:	e4a6                	sd	s1,72(sp)
 2e6:	e0ca                	sd	s2,64(sp)
 2e8:	fc4e                	sd	s3,56(sp)
 2ea:	f852                	sd	s4,48(sp)
 2ec:	f456                	sd	s5,40(sp)
 2ee:	f05a                	sd	s6,32(sp)
 2f0:	ec5e                	sd	s7,24(sp)
 2f2:	1080                	addi	s0,sp,96
 2f4:	8baa                	mv	s7,a0
 2f6:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2f8:	892a                	mv	s2,a0
 2fa:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 2fc:	4aa9                	li	s5,10
 2fe:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 300:	89a6                	mv	s3,s1
 302:	2485                	addiw	s1,s1,1
 304:	0344d863          	bge	s1,s4,334 <gets+0x56>
    cc = read(0, &c, 1);
 308:	4605                	li	a2,1
 30a:	faf40593          	addi	a1,s0,-81
 30e:	4501                	li	a0,0
 310:	00000097          	auipc	ra,0x0
 314:	19a080e7          	jalr	410(ra) # 4aa <read>
    if(cc < 1)
 318:	00a05e63          	blez	a0,334 <gets+0x56>
    buf[i++] = c;
 31c:	faf44783          	lbu	a5,-81(s0)
 320:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 324:	01578763          	beq	a5,s5,332 <gets+0x54>
 328:	0905                	addi	s2,s2,1
 32a:	fd679be3          	bne	a5,s6,300 <gets+0x22>
  for(i=0; i+1 < max; ){
 32e:	89a6                	mv	s3,s1
 330:	a011                	j	334 <gets+0x56>
 332:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 334:	99de                	add	s3,s3,s7
 336:	00098023          	sb	zero,0(s3)
  return buf;
}
 33a:	855e                	mv	a0,s7
 33c:	60e6                	ld	ra,88(sp)
 33e:	6446                	ld	s0,80(sp)
 340:	64a6                	ld	s1,72(sp)
 342:	6906                	ld	s2,64(sp)
 344:	79e2                	ld	s3,56(sp)
 346:	7a42                	ld	s4,48(sp)
 348:	7aa2                	ld	s5,40(sp)
 34a:	7b02                	ld	s6,32(sp)
 34c:	6be2                	ld	s7,24(sp)
 34e:	6125                	addi	sp,sp,96
 350:	8082                	ret

0000000000000352 <stat>:

int
stat(const char *n, struct stat *st)
{
 352:	1101                	addi	sp,sp,-32
 354:	ec06                	sd	ra,24(sp)
 356:	e822                	sd	s0,16(sp)
 358:	e426                	sd	s1,8(sp)
 35a:	e04a                	sd	s2,0(sp)
 35c:	1000                	addi	s0,sp,32
 35e:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 360:	4581                	li	a1,0
 362:	00000097          	auipc	ra,0x0
 366:	170080e7          	jalr	368(ra) # 4d2 <open>
  if(fd < 0)
 36a:	02054563          	bltz	a0,394 <stat+0x42>
 36e:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 370:	85ca                	mv	a1,s2
 372:	00000097          	auipc	ra,0x0
 376:	178080e7          	jalr	376(ra) # 4ea <fstat>
 37a:	892a                	mv	s2,a0
  close(fd);
 37c:	8526                	mv	a0,s1
 37e:	00000097          	auipc	ra,0x0
 382:	13c080e7          	jalr	316(ra) # 4ba <close>
  return r;
}
 386:	854a                	mv	a0,s2
 388:	60e2                	ld	ra,24(sp)
 38a:	6442                	ld	s0,16(sp)
 38c:	64a2                	ld	s1,8(sp)
 38e:	6902                	ld	s2,0(sp)
 390:	6105                	addi	sp,sp,32
 392:	8082                	ret
    return -1;
 394:	597d                	li	s2,-1
 396:	bfc5                	j	386 <stat+0x34>

0000000000000398 <atoi>:

int
atoi(const char *s)
{
 398:	1141                	addi	sp,sp,-16
 39a:	e422                	sd	s0,8(sp)
 39c:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 39e:	00054683          	lbu	a3,0(a0)
 3a2:	fd06879b          	addiw	a5,a3,-48
 3a6:	0ff7f793          	zext.b	a5,a5
 3aa:	4625                	li	a2,9
 3ac:	02f66863          	bltu	a2,a5,3dc <atoi+0x44>
 3b0:	872a                	mv	a4,a0
  n = 0;
 3b2:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 3b4:	0705                	addi	a4,a4,1
 3b6:	0025179b          	slliw	a5,a0,0x2
 3ba:	9fa9                	addw	a5,a5,a0
 3bc:	0017979b          	slliw	a5,a5,0x1
 3c0:	9fb5                	addw	a5,a5,a3
 3c2:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 3c6:	00074683          	lbu	a3,0(a4)
 3ca:	fd06879b          	addiw	a5,a3,-48
 3ce:	0ff7f793          	zext.b	a5,a5
 3d2:	fef671e3          	bgeu	a2,a5,3b4 <atoi+0x1c>
  return n;
}
 3d6:	6422                	ld	s0,8(sp)
 3d8:	0141                	addi	sp,sp,16
 3da:	8082                	ret
  n = 0;
 3dc:	4501                	li	a0,0
 3de:	bfe5                	j	3d6 <atoi+0x3e>

00000000000003e0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3e0:	1141                	addi	sp,sp,-16
 3e2:	e422                	sd	s0,8(sp)
 3e4:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 3e6:	02b57463          	bgeu	a0,a1,40e <memmove+0x2e>
    while(n-- > 0)
 3ea:	00c05f63          	blez	a2,408 <memmove+0x28>
 3ee:	1602                	slli	a2,a2,0x20
 3f0:	9201                	srli	a2,a2,0x20
 3f2:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 3f6:	872a                	mv	a4,a0
      *dst++ = *src++;
 3f8:	0585                	addi	a1,a1,1
 3fa:	0705                	addi	a4,a4,1
 3fc:	fff5c683          	lbu	a3,-1(a1)
 400:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 404:	fee79ae3          	bne	a5,a4,3f8 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 408:	6422                	ld	s0,8(sp)
 40a:	0141                	addi	sp,sp,16
 40c:	8082                	ret
    dst += n;
 40e:	00c50733          	add	a4,a0,a2
    src += n;
 412:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 414:	fec05ae3          	blez	a2,408 <memmove+0x28>
 418:	fff6079b          	addiw	a5,a2,-1
 41c:	1782                	slli	a5,a5,0x20
 41e:	9381                	srli	a5,a5,0x20
 420:	fff7c793          	not	a5,a5
 424:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 426:	15fd                	addi	a1,a1,-1
 428:	177d                	addi	a4,a4,-1
 42a:	0005c683          	lbu	a3,0(a1)
 42e:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 432:	fee79ae3          	bne	a5,a4,426 <memmove+0x46>
 436:	bfc9                	j	408 <memmove+0x28>

0000000000000438 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 438:	1141                	addi	sp,sp,-16
 43a:	e422                	sd	s0,8(sp)
 43c:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 43e:	ca05                	beqz	a2,46e <memcmp+0x36>
 440:	fff6069b          	addiw	a3,a2,-1
 444:	1682                	slli	a3,a3,0x20
 446:	9281                	srli	a3,a3,0x20
 448:	0685                	addi	a3,a3,1
 44a:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 44c:	00054783          	lbu	a5,0(a0)
 450:	0005c703          	lbu	a4,0(a1)
 454:	00e79863          	bne	a5,a4,464 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 458:	0505                	addi	a0,a0,1
    p2++;
 45a:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 45c:	fed518e3          	bne	a0,a3,44c <memcmp+0x14>
  }
  return 0;
 460:	4501                	li	a0,0
 462:	a019                	j	468 <memcmp+0x30>
      return *p1 - *p2;
 464:	40e7853b          	subw	a0,a5,a4
}
 468:	6422                	ld	s0,8(sp)
 46a:	0141                	addi	sp,sp,16
 46c:	8082                	ret
  return 0;
 46e:	4501                	li	a0,0
 470:	bfe5                	j	468 <memcmp+0x30>

0000000000000472 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 472:	1141                	addi	sp,sp,-16
 474:	e406                	sd	ra,8(sp)
 476:	e022                	sd	s0,0(sp)
 478:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 47a:	00000097          	auipc	ra,0x0
 47e:	f66080e7          	jalr	-154(ra) # 3e0 <memmove>
}
 482:	60a2                	ld	ra,8(sp)
 484:	6402                	ld	s0,0(sp)
 486:	0141                	addi	sp,sp,16
 488:	8082                	ret

000000000000048a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 48a:	4885                	li	a7,1
 ecall
 48c:	00000073          	ecall
 ret
 490:	8082                	ret

0000000000000492 <exit>:
.global exit
exit:
 li a7, SYS_exit
 492:	4889                	li	a7,2
 ecall
 494:	00000073          	ecall
 ret
 498:	8082                	ret

000000000000049a <wait>:
.global wait
wait:
 li a7, SYS_wait
 49a:	488d                	li	a7,3
 ecall
 49c:	00000073          	ecall
 ret
 4a0:	8082                	ret

00000000000004a2 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 4a2:	4891                	li	a7,4
 ecall
 4a4:	00000073          	ecall
 ret
 4a8:	8082                	ret

00000000000004aa <read>:
.global read
read:
 li a7, SYS_read
 4aa:	4895                	li	a7,5
 ecall
 4ac:	00000073          	ecall
 ret
 4b0:	8082                	ret

00000000000004b2 <write>:
.global write
write:
 li a7, SYS_write
 4b2:	48c1                	li	a7,16
 ecall
 4b4:	00000073          	ecall
 ret
 4b8:	8082                	ret

00000000000004ba <close>:
.global close
close:
 li a7, SYS_close
 4ba:	48d5                	li	a7,21
 ecall
 4bc:	00000073          	ecall
 ret
 4c0:	8082                	ret

00000000000004c2 <kill>:
.global kill
kill:
 li a7, SYS_kill
 4c2:	4899                	li	a7,6
 ecall
 4c4:	00000073          	ecall
 ret
 4c8:	8082                	ret

00000000000004ca <exec>:
.global exec
exec:
 li a7, SYS_exec
 4ca:	489d                	li	a7,7
 ecall
 4cc:	00000073          	ecall
 ret
 4d0:	8082                	ret

00000000000004d2 <open>:
.global open
open:
 li a7, SYS_open
 4d2:	48bd                	li	a7,15
 ecall
 4d4:	00000073          	ecall
 ret
 4d8:	8082                	ret

00000000000004da <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 4da:	48c5                	li	a7,17
 ecall
 4dc:	00000073          	ecall
 ret
 4e0:	8082                	ret

00000000000004e2 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 4e2:	48c9                	li	a7,18
 ecall
 4e4:	00000073          	ecall
 ret
 4e8:	8082                	ret

00000000000004ea <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 4ea:	48a1                	li	a7,8
 ecall
 4ec:	00000073          	ecall
 ret
 4f0:	8082                	ret

00000000000004f2 <link>:
.global link
link:
 li a7, SYS_link
 4f2:	48cd                	li	a7,19
 ecall
 4f4:	00000073          	ecall
 ret
 4f8:	8082                	ret

00000000000004fa <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 4fa:	48d1                	li	a7,20
 ecall
 4fc:	00000073          	ecall
 ret
 500:	8082                	ret

0000000000000502 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 502:	48a5                	li	a7,9
 ecall
 504:	00000073          	ecall
 ret
 508:	8082                	ret

000000000000050a <dup>:
.global dup
dup:
 li a7, SYS_dup
 50a:	48a9                	li	a7,10
 ecall
 50c:	00000073          	ecall
 ret
 510:	8082                	ret

0000000000000512 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 512:	48ad                	li	a7,11
 ecall
 514:	00000073          	ecall
 ret
 518:	8082                	ret

000000000000051a <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 51a:	48b1                	li	a7,12
 ecall
 51c:	00000073          	ecall
 ret
 520:	8082                	ret

0000000000000522 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 522:	48b5                	li	a7,13
 ecall
 524:	00000073          	ecall
 ret
 528:	8082                	ret

000000000000052a <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 52a:	48b9                	li	a7,14
 ecall
 52c:	00000073          	ecall
 ret
 530:	8082                	ret

0000000000000532 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 532:	1101                	addi	sp,sp,-32
 534:	ec06                	sd	ra,24(sp)
 536:	e822                	sd	s0,16(sp)
 538:	1000                	addi	s0,sp,32
 53a:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 53e:	4605                	li	a2,1
 540:	fef40593          	addi	a1,s0,-17
 544:	00000097          	auipc	ra,0x0
 548:	f6e080e7          	jalr	-146(ra) # 4b2 <write>
}
 54c:	60e2                	ld	ra,24(sp)
 54e:	6442                	ld	s0,16(sp)
 550:	6105                	addi	sp,sp,32
 552:	8082                	ret

0000000000000554 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 554:	7139                	addi	sp,sp,-64
 556:	fc06                	sd	ra,56(sp)
 558:	f822                	sd	s0,48(sp)
 55a:	f426                	sd	s1,40(sp)
 55c:	f04a                	sd	s2,32(sp)
 55e:	ec4e                	sd	s3,24(sp)
 560:	0080                	addi	s0,sp,64
 562:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 564:	c299                	beqz	a3,56a <printint+0x16>
 566:	0805c963          	bltz	a1,5f8 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 56a:	2581                	sext.w	a1,a1
  neg = 0;
 56c:	4881                	li	a7,0
 56e:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 572:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 574:	2601                	sext.w	a2,a2
 576:	00000517          	auipc	a0,0x0
 57a:	4ca50513          	addi	a0,a0,1226 # a40 <digits>
 57e:	883a                	mv	a6,a4
 580:	2705                	addiw	a4,a4,1
 582:	02c5f7bb          	remuw	a5,a1,a2
 586:	1782                	slli	a5,a5,0x20
 588:	9381                	srli	a5,a5,0x20
 58a:	97aa                	add	a5,a5,a0
 58c:	0007c783          	lbu	a5,0(a5)
 590:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 594:	0005879b          	sext.w	a5,a1
 598:	02c5d5bb          	divuw	a1,a1,a2
 59c:	0685                	addi	a3,a3,1
 59e:	fec7f0e3          	bgeu	a5,a2,57e <printint+0x2a>
  if(neg)
 5a2:	00088c63          	beqz	a7,5ba <printint+0x66>
    buf[i++] = '-';
 5a6:	fd070793          	addi	a5,a4,-48
 5aa:	00878733          	add	a4,a5,s0
 5ae:	02d00793          	li	a5,45
 5b2:	fef70823          	sb	a5,-16(a4)
 5b6:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 5ba:	02e05863          	blez	a4,5ea <printint+0x96>
 5be:	fc040793          	addi	a5,s0,-64
 5c2:	00e78933          	add	s2,a5,a4
 5c6:	fff78993          	addi	s3,a5,-1
 5ca:	99ba                	add	s3,s3,a4
 5cc:	377d                	addiw	a4,a4,-1
 5ce:	1702                	slli	a4,a4,0x20
 5d0:	9301                	srli	a4,a4,0x20
 5d2:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 5d6:	fff94583          	lbu	a1,-1(s2)
 5da:	8526                	mv	a0,s1
 5dc:	00000097          	auipc	ra,0x0
 5e0:	f56080e7          	jalr	-170(ra) # 532 <putc>
  while(--i >= 0)
 5e4:	197d                	addi	s2,s2,-1
 5e6:	ff3918e3          	bne	s2,s3,5d6 <printint+0x82>
}
 5ea:	70e2                	ld	ra,56(sp)
 5ec:	7442                	ld	s0,48(sp)
 5ee:	74a2                	ld	s1,40(sp)
 5f0:	7902                	ld	s2,32(sp)
 5f2:	69e2                	ld	s3,24(sp)
 5f4:	6121                	addi	sp,sp,64
 5f6:	8082                	ret
    x = -xx;
 5f8:	40b005bb          	negw	a1,a1
    neg = 1;
 5fc:	4885                	li	a7,1
    x = -xx;
 5fe:	bf85                	j	56e <printint+0x1a>

0000000000000600 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 600:	715d                	addi	sp,sp,-80
 602:	e486                	sd	ra,72(sp)
 604:	e0a2                	sd	s0,64(sp)
 606:	fc26                	sd	s1,56(sp)
 608:	f84a                	sd	s2,48(sp)
 60a:	f44e                	sd	s3,40(sp)
 60c:	f052                	sd	s4,32(sp)
 60e:	ec56                	sd	s5,24(sp)
 610:	e85a                	sd	s6,16(sp)
 612:	e45e                	sd	s7,8(sp)
 614:	e062                	sd	s8,0(sp)
 616:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 618:	0005c903          	lbu	s2,0(a1)
 61c:	18090c63          	beqz	s2,7b4 <vprintf+0x1b4>
 620:	8aaa                	mv	s5,a0
 622:	8bb2                	mv	s7,a2
 624:	00158493          	addi	s1,a1,1
  state = 0;
 628:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 62a:	02500a13          	li	s4,37
 62e:	4b55                	li	s6,21
 630:	a839                	j	64e <vprintf+0x4e>
        putc(fd, c);
 632:	85ca                	mv	a1,s2
 634:	8556                	mv	a0,s5
 636:	00000097          	auipc	ra,0x0
 63a:	efc080e7          	jalr	-260(ra) # 532 <putc>
 63e:	a019                	j	644 <vprintf+0x44>
    } else if(state == '%'){
 640:	01498d63          	beq	s3,s4,65a <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 644:	0485                	addi	s1,s1,1
 646:	fff4c903          	lbu	s2,-1(s1)
 64a:	16090563          	beqz	s2,7b4 <vprintf+0x1b4>
    if(state == 0){
 64e:	fe0999e3          	bnez	s3,640 <vprintf+0x40>
      if(c == '%'){
 652:	ff4910e3          	bne	s2,s4,632 <vprintf+0x32>
        state = '%';
 656:	89d2                	mv	s3,s4
 658:	b7f5                	j	644 <vprintf+0x44>
      if(c == 'd'){
 65a:	13490263          	beq	s2,s4,77e <vprintf+0x17e>
 65e:	f9d9079b          	addiw	a5,s2,-99
 662:	0ff7f793          	zext.b	a5,a5
 666:	12fb6563          	bltu	s6,a5,790 <vprintf+0x190>
 66a:	f9d9079b          	addiw	a5,s2,-99
 66e:	0ff7f713          	zext.b	a4,a5
 672:	10eb6f63          	bltu	s6,a4,790 <vprintf+0x190>
 676:	00271793          	slli	a5,a4,0x2
 67a:	00000717          	auipc	a4,0x0
 67e:	36e70713          	addi	a4,a4,878 # 9e8 <malloc+0x136>
 682:	97ba                	add	a5,a5,a4
 684:	439c                	lw	a5,0(a5)
 686:	97ba                	add	a5,a5,a4
 688:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 68a:	008b8913          	addi	s2,s7,8
 68e:	4685                	li	a3,1
 690:	4629                	li	a2,10
 692:	000ba583          	lw	a1,0(s7)
 696:	8556                	mv	a0,s5
 698:	00000097          	auipc	ra,0x0
 69c:	ebc080e7          	jalr	-324(ra) # 554 <printint>
 6a0:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 6a2:	4981                	li	s3,0
 6a4:	b745                	j	644 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6a6:	008b8913          	addi	s2,s7,8
 6aa:	4681                	li	a3,0
 6ac:	4629                	li	a2,10
 6ae:	000ba583          	lw	a1,0(s7)
 6b2:	8556                	mv	a0,s5
 6b4:	00000097          	auipc	ra,0x0
 6b8:	ea0080e7          	jalr	-352(ra) # 554 <printint>
 6bc:	8bca                	mv	s7,s2
      state = 0;
 6be:	4981                	li	s3,0
 6c0:	b751                	j	644 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 6c2:	008b8913          	addi	s2,s7,8
 6c6:	4681                	li	a3,0
 6c8:	4641                	li	a2,16
 6ca:	000ba583          	lw	a1,0(s7)
 6ce:	8556                	mv	a0,s5
 6d0:	00000097          	auipc	ra,0x0
 6d4:	e84080e7          	jalr	-380(ra) # 554 <printint>
 6d8:	8bca                	mv	s7,s2
      state = 0;
 6da:	4981                	li	s3,0
 6dc:	b7a5                	j	644 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 6de:	008b8c13          	addi	s8,s7,8
 6e2:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 6e6:	03000593          	li	a1,48
 6ea:	8556                	mv	a0,s5
 6ec:	00000097          	auipc	ra,0x0
 6f0:	e46080e7          	jalr	-442(ra) # 532 <putc>
  putc(fd, 'x');
 6f4:	07800593          	li	a1,120
 6f8:	8556                	mv	a0,s5
 6fa:	00000097          	auipc	ra,0x0
 6fe:	e38080e7          	jalr	-456(ra) # 532 <putc>
 702:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 704:	00000b97          	auipc	s7,0x0
 708:	33cb8b93          	addi	s7,s7,828 # a40 <digits>
 70c:	03c9d793          	srli	a5,s3,0x3c
 710:	97de                	add	a5,a5,s7
 712:	0007c583          	lbu	a1,0(a5)
 716:	8556                	mv	a0,s5
 718:	00000097          	auipc	ra,0x0
 71c:	e1a080e7          	jalr	-486(ra) # 532 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 720:	0992                	slli	s3,s3,0x4
 722:	397d                	addiw	s2,s2,-1
 724:	fe0914e3          	bnez	s2,70c <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 728:	8be2                	mv	s7,s8
      state = 0;
 72a:	4981                	li	s3,0
 72c:	bf21                	j	644 <vprintf+0x44>
        s = va_arg(ap, char*);
 72e:	008b8993          	addi	s3,s7,8
 732:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 736:	02090163          	beqz	s2,758 <vprintf+0x158>
        while(*s != 0){
 73a:	00094583          	lbu	a1,0(s2)
 73e:	c9a5                	beqz	a1,7ae <vprintf+0x1ae>
          putc(fd, *s);
 740:	8556                	mv	a0,s5
 742:	00000097          	auipc	ra,0x0
 746:	df0080e7          	jalr	-528(ra) # 532 <putc>
          s++;
 74a:	0905                	addi	s2,s2,1
        while(*s != 0){
 74c:	00094583          	lbu	a1,0(s2)
 750:	f9e5                	bnez	a1,740 <vprintf+0x140>
        s = va_arg(ap, char*);
 752:	8bce                	mv	s7,s3
      state = 0;
 754:	4981                	li	s3,0
 756:	b5fd                	j	644 <vprintf+0x44>
          s = "(null)";
 758:	00000917          	auipc	s2,0x0
 75c:	28890913          	addi	s2,s2,648 # 9e0 <malloc+0x12e>
        while(*s != 0){
 760:	02800593          	li	a1,40
 764:	bff1                	j	740 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 766:	008b8913          	addi	s2,s7,8
 76a:	000bc583          	lbu	a1,0(s7)
 76e:	8556                	mv	a0,s5
 770:	00000097          	auipc	ra,0x0
 774:	dc2080e7          	jalr	-574(ra) # 532 <putc>
 778:	8bca                	mv	s7,s2
      state = 0;
 77a:	4981                	li	s3,0
 77c:	b5e1                	j	644 <vprintf+0x44>
        putc(fd, c);
 77e:	02500593          	li	a1,37
 782:	8556                	mv	a0,s5
 784:	00000097          	auipc	ra,0x0
 788:	dae080e7          	jalr	-594(ra) # 532 <putc>
      state = 0;
 78c:	4981                	li	s3,0
 78e:	bd5d                	j	644 <vprintf+0x44>
        putc(fd, '%');
 790:	02500593          	li	a1,37
 794:	8556                	mv	a0,s5
 796:	00000097          	auipc	ra,0x0
 79a:	d9c080e7          	jalr	-612(ra) # 532 <putc>
        putc(fd, c);
 79e:	85ca                	mv	a1,s2
 7a0:	8556                	mv	a0,s5
 7a2:	00000097          	auipc	ra,0x0
 7a6:	d90080e7          	jalr	-624(ra) # 532 <putc>
      state = 0;
 7aa:	4981                	li	s3,0
 7ac:	bd61                	j	644 <vprintf+0x44>
        s = va_arg(ap, char*);
 7ae:	8bce                	mv	s7,s3
      state = 0;
 7b0:	4981                	li	s3,0
 7b2:	bd49                	j	644 <vprintf+0x44>
    }
  }
}
 7b4:	60a6                	ld	ra,72(sp)
 7b6:	6406                	ld	s0,64(sp)
 7b8:	74e2                	ld	s1,56(sp)
 7ba:	7942                	ld	s2,48(sp)
 7bc:	79a2                	ld	s3,40(sp)
 7be:	7a02                	ld	s4,32(sp)
 7c0:	6ae2                	ld	s5,24(sp)
 7c2:	6b42                	ld	s6,16(sp)
 7c4:	6ba2                	ld	s7,8(sp)
 7c6:	6c02                	ld	s8,0(sp)
 7c8:	6161                	addi	sp,sp,80
 7ca:	8082                	ret

00000000000007cc <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7cc:	715d                	addi	sp,sp,-80
 7ce:	ec06                	sd	ra,24(sp)
 7d0:	e822                	sd	s0,16(sp)
 7d2:	1000                	addi	s0,sp,32
 7d4:	e010                	sd	a2,0(s0)
 7d6:	e414                	sd	a3,8(s0)
 7d8:	e818                	sd	a4,16(s0)
 7da:	ec1c                	sd	a5,24(s0)
 7dc:	03043023          	sd	a6,32(s0)
 7e0:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 7e4:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7e8:	8622                	mv	a2,s0
 7ea:	00000097          	auipc	ra,0x0
 7ee:	e16080e7          	jalr	-490(ra) # 600 <vprintf>
}
 7f2:	60e2                	ld	ra,24(sp)
 7f4:	6442                	ld	s0,16(sp)
 7f6:	6161                	addi	sp,sp,80
 7f8:	8082                	ret

00000000000007fa <printf>:

void
printf(const char *fmt, ...)
{
 7fa:	711d                	addi	sp,sp,-96
 7fc:	ec06                	sd	ra,24(sp)
 7fe:	e822                	sd	s0,16(sp)
 800:	1000                	addi	s0,sp,32
 802:	e40c                	sd	a1,8(s0)
 804:	e810                	sd	a2,16(s0)
 806:	ec14                	sd	a3,24(s0)
 808:	f018                	sd	a4,32(s0)
 80a:	f41c                	sd	a5,40(s0)
 80c:	03043823          	sd	a6,48(s0)
 810:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 814:	00840613          	addi	a2,s0,8
 818:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 81c:	85aa                	mv	a1,a0
 81e:	4505                	li	a0,1
 820:	00000097          	auipc	ra,0x0
 824:	de0080e7          	jalr	-544(ra) # 600 <vprintf>
}
 828:	60e2                	ld	ra,24(sp)
 82a:	6442                	ld	s0,16(sp)
 82c:	6125                	addi	sp,sp,96
 82e:	8082                	ret

0000000000000830 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 830:	1141                	addi	sp,sp,-16
 832:	e422                	sd	s0,8(sp)
 834:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 836:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 83a:	00000797          	auipc	a5,0x0
 83e:	21e7b783          	ld	a5,542(a5) # a58 <freep>
 842:	a02d                	j	86c <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 844:	4618                	lw	a4,8(a2)
 846:	9f2d                	addw	a4,a4,a1
 848:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 84c:	6398                	ld	a4,0(a5)
 84e:	6310                	ld	a2,0(a4)
 850:	a83d                	j	88e <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 852:	ff852703          	lw	a4,-8(a0)
 856:	9f31                	addw	a4,a4,a2
 858:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 85a:	ff053683          	ld	a3,-16(a0)
 85e:	a091                	j	8a2 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 860:	6398                	ld	a4,0(a5)
 862:	00e7e463          	bltu	a5,a4,86a <free+0x3a>
 866:	00e6ea63          	bltu	a3,a4,87a <free+0x4a>
{
 86a:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 86c:	fed7fae3          	bgeu	a5,a3,860 <free+0x30>
 870:	6398                	ld	a4,0(a5)
 872:	00e6e463          	bltu	a3,a4,87a <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 876:	fee7eae3          	bltu	a5,a4,86a <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 87a:	ff852583          	lw	a1,-8(a0)
 87e:	6390                	ld	a2,0(a5)
 880:	02059813          	slli	a6,a1,0x20
 884:	01c85713          	srli	a4,a6,0x1c
 888:	9736                	add	a4,a4,a3
 88a:	fae60de3          	beq	a2,a4,844 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 88e:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 892:	4790                	lw	a2,8(a5)
 894:	02061593          	slli	a1,a2,0x20
 898:	01c5d713          	srli	a4,a1,0x1c
 89c:	973e                	add	a4,a4,a5
 89e:	fae68ae3          	beq	a3,a4,852 <free+0x22>
    p->s.ptr = bp->s.ptr;
 8a2:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 8a4:	00000717          	auipc	a4,0x0
 8a8:	1af73a23          	sd	a5,436(a4) # a58 <freep>
}
 8ac:	6422                	ld	s0,8(sp)
 8ae:	0141                	addi	sp,sp,16
 8b0:	8082                	ret

00000000000008b2 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8b2:	7139                	addi	sp,sp,-64
 8b4:	fc06                	sd	ra,56(sp)
 8b6:	f822                	sd	s0,48(sp)
 8b8:	f426                	sd	s1,40(sp)
 8ba:	f04a                	sd	s2,32(sp)
 8bc:	ec4e                	sd	s3,24(sp)
 8be:	e852                	sd	s4,16(sp)
 8c0:	e456                	sd	s5,8(sp)
 8c2:	e05a                	sd	s6,0(sp)
 8c4:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8c6:	02051493          	slli	s1,a0,0x20
 8ca:	9081                	srli	s1,s1,0x20
 8cc:	04bd                	addi	s1,s1,15
 8ce:	8091                	srli	s1,s1,0x4
 8d0:	0014899b          	addiw	s3,s1,1
 8d4:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 8d6:	00000517          	auipc	a0,0x0
 8da:	18253503          	ld	a0,386(a0) # a58 <freep>
 8de:	c515                	beqz	a0,90a <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8e0:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8e2:	4798                	lw	a4,8(a5)
 8e4:	02977f63          	bgeu	a4,s1,922 <malloc+0x70>
  if(nu < 4096)
 8e8:	8a4e                	mv	s4,s3
 8ea:	0009871b          	sext.w	a4,s3
 8ee:	6685                	lui	a3,0x1
 8f0:	00d77363          	bgeu	a4,a3,8f6 <malloc+0x44>
 8f4:	6a05                	lui	s4,0x1
 8f6:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 8fa:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8fe:	00000917          	auipc	s2,0x0
 902:	15a90913          	addi	s2,s2,346 # a58 <freep>
  if(p == (char*)-1)
 906:	5afd                	li	s5,-1
 908:	a895                	j	97c <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 90a:	00000797          	auipc	a5,0x0
 90e:	15678793          	addi	a5,a5,342 # a60 <base>
 912:	00000717          	auipc	a4,0x0
 916:	14f73323          	sd	a5,326(a4) # a58 <freep>
 91a:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 91c:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 920:	b7e1                	j	8e8 <malloc+0x36>
      if(p->s.size == nunits)
 922:	02e48c63          	beq	s1,a4,95a <malloc+0xa8>
        p->s.size -= nunits;
 926:	4137073b          	subw	a4,a4,s3
 92a:	c798                	sw	a4,8(a5)
        p += p->s.size;
 92c:	02071693          	slli	a3,a4,0x20
 930:	01c6d713          	srli	a4,a3,0x1c
 934:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 936:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 93a:	00000717          	auipc	a4,0x0
 93e:	10a73f23          	sd	a0,286(a4) # a58 <freep>
      return (void*)(p + 1);
 942:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 946:	70e2                	ld	ra,56(sp)
 948:	7442                	ld	s0,48(sp)
 94a:	74a2                	ld	s1,40(sp)
 94c:	7902                	ld	s2,32(sp)
 94e:	69e2                	ld	s3,24(sp)
 950:	6a42                	ld	s4,16(sp)
 952:	6aa2                	ld	s5,8(sp)
 954:	6b02                	ld	s6,0(sp)
 956:	6121                	addi	sp,sp,64
 958:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 95a:	6398                	ld	a4,0(a5)
 95c:	e118                	sd	a4,0(a0)
 95e:	bff1                	j	93a <malloc+0x88>
  hp->s.size = nu;
 960:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 964:	0541                	addi	a0,a0,16
 966:	00000097          	auipc	ra,0x0
 96a:	eca080e7          	jalr	-310(ra) # 830 <free>
  return freep;
 96e:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 972:	d971                	beqz	a0,946 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 974:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 976:	4798                	lw	a4,8(a5)
 978:	fa9775e3          	bgeu	a4,s1,922 <malloc+0x70>
    if(p == freep)
 97c:	00093703          	ld	a4,0(s2)
 980:	853e                	mv	a0,a5
 982:	fef719e3          	bne	a4,a5,974 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 986:	8552                	mv	a0,s4
 988:	00000097          	auipc	ra,0x0
 98c:	b92080e7          	jalr	-1134(ra) # 51a <sbrk>
  if(p == (char*)-1)
 990:	fd5518e3          	bne	a0,s5,960 <malloc+0xae>
        return 0;
 994:	4501                	li	a0,0
 996:	bf45                	j	946 <malloc+0x94>

/*  Walk v1.2                           */
/*  Copyright (c) 1992 by James Delaney */
/*  This is the control program for the */
/*  data in file:  walk.ike             */
/*  The other part of the program is    */
/*  walkoth.c                           */

#include <sgstat.h>
#include <stdio.h>
#include <os9.h>
#include <utime.h>
#define _button (reg.rg_a)
#define REST        1
#define WALKRO      2
#define WALKLO      8
#define WALKDO      14
#define WALKUO      18
#define TAPLO       22
#define TAPRO       26
#define WAVEO       30
#define BLOATO      32
extern long time();
extern struct tm *localtime();
extern char *asctime();
char block[2049];
FILE *path;
int wpath;
int lopx,lopy;
int pid;
char ins;
int x,y;
int NIKE;
int manx,many;
int ofset;
char says[41];
main(argc,argv)
int argc;
char *argv[];
{
     char c;  int wtd;  int Error();
     intercept(Error);
     pid=getpid();
     wpath=_iob[1]._fd;
     NIKE=0;
     ofset=0;
     KilBuf(wpath,pid,0);
     setbuf(stdout,NULL);
     setbuf(stdin,NULL);
     srand(10);
     Setup();
     FColor(wpath,0);
     manx=320;
     many=(rand(75)%75)+50;
     for (;;) {
          if (manx/2) {manx=(manx/2)*2;}
          PutBlk(wpath,pid,REST,manx,many);
          sleep((rand(3)%3)+1);
          wtd=(rand(16)%16)+1;
          if (wtd>12) wtd=5;
          if (_gs_rdy(0)>0) {
               read(0,&c,1);
               wtd=KeyHit(c);
               }
          switch (wtd) {
               case 1:
               case 2: {
                    Talk();
                    break;}
               case 3:
               case 4:
               case 5:
               case 6:{
                    Walk();
                    break;}
               case 7:
               case 8:{
                    Tap(1);
                    break;}
               case 9:
               case 10:{
                    Tap(0);
                    break;}
               case 11: {
                    Wave();
                    break;}
               case 12: {
                    Bloat();
                    break;}
               }
          }
}
/*Here*/
Bloat()
{
     ofset=BLOATO;
     PutBlk(wpath,pid,ofset,manx,many);
     for (lopy=0; lopy<2; lopy++) {
          PutBlk(wpath,pid,REST,manx,many);
          tsleep(8);
          PutBlk(wpath,pid,ofset,manx,many);
          tsleep(5);
          }
}

Wave()
{
     ofset=WAVEO;
     for (lopy=0; lopy<3; lopy++) {
          for (lopx=0; lopx<2; lopx++) {
               PutBlk(wpath,pid,lopx+ofset,manx,many);
               tsleep(5);
               }
          }
}

KeyHit(hit)
char hit;
{
     switch(hit) {
          case 'm':  {return 6; break;}
          case 't':  {return 2; break;}
          case 'r':  {return 8; break;}
          case 'l':  {return 10; break;}
          case 'h':  {return 6; break;}
          case 'w':  {return 11; break;}
          case 'b':  {return 12; break;}
          }
     Error();
}

Talk()
{
     int cury,curx,say,paus=2;
     FColor(wpath,15);
     if (many>90) {cury=(many/8)-3;}
       else       {cury=(many/8)+7;}
     say=(rand(8)%8)+1;
     switch(say) {
          case 1: {
               strcpy(says,"What are you looking at?");
               break;}
          case 2: {
               strcpy(says,"Go away from me!");
               break;}
          case 3: {
               strcpy(says,"I want to be alone.");
               break;}
          case 4: {
               strcpy(says,"Quit staring at me!");
               break;}
          case 5: {
               strcpy(says,"Why me?");
               paus=1;
               break;}
          case 6: {
               Thetime();
               paus=3;
               break;}
          case 7: {
               strcpy(says,"Who are you anyway?");
               break;}
          case 8: {
               strcpy(says,"I don't like people staring at me.");
               paus=3;
               break;}
          }
     curx=20-((strlen(says))/2);
     CurXY(wpath,curx,cury);
     printf("%s\n",says);
     sleep(paus);
     CurXY(wpath,0,cury);
     printf("                                        \n");
     FColor(wpath,0);
}
Thetime()
{
     long systime;
     struct tm *utimeptr;
     systime=time((char *)0);
     utimeptr=localtime(&systime);
     strcpy(says,"It is ");
     strcat(says,(asctime(utimeptr)));
}

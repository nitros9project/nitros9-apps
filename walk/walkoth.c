/*  Walk v1.2                           */
/*  Copyright (c) 1992 by James Delaney */
/*  This is the control program for the */
/*  data in file:  walk.ike             */
/*  The other part of the program is    */
/*  walkoth.c                           */

#include <sgstat.h>
#include <stdio.h>
#include <os9.h>
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
extern char block[2049];
extern FILE *path;
extern wpath;
extern lopx,lopy;
extern pid;
extern char ins;
extern x,y;
extern NIKE;
extern manx,many;
extern ofset;
/*Here*/
Tap(wtd)
int wtd;
{
     int durat;
     int ofset;
     if (wtd==1) ofset=TAPRO;
       else      ofset=TAPLO;
     durat=(rand(5)%5)+2;
     for (lopy=0; lopy<durat; lopy++) {
          for (lopx=0; lopx<4; lopx++) {
               PutBlk(wpath,pid,lopx+ofset,manx,many);
               tsleep(10);
               }
          }
}

Walk()
{
     int dir,durat;
     int ncyc;
     dir=(rand(8)%8)+1;
     if ((dir==8)||(dir==4)) ncyc=4;
       else ncyc=6;
     durat=(rand(5)%5)+1;
     CalOfset(dir);
     PutBlk(wpath,pid,ofset,manx,many);
     for (lopy=0; lopy<durat; lopy++) {
          for (lopx=0; lopx<ncyc; lopx++) {
               if (Move(dir))  {
                    Clear(wpath);
                    return;}
               SetDPtr(wpath,manx-4,many-1);
               Box(wpath,manx+66,many+32);
               SetDPtr(wpath,manx-2,many-1);
               Box(wpath,manx+64,many+32);
               PutBlk(wpath,pid,lopx+ofset,manx,many);
               }
          }

}
Move(dir)
int dir;
{


     switch(dir) {
          case 1: {
               manx+=4;
               many-=1;
               break;}
          case 2: {
               manx+=4;
               break;}
          case 3: {
               manx+=4;
               many+=1;
               break;}
          case 4: {
               many+=1;
               break;}
          case 5: {
               manx-=4;
               many+=1;
               break;}
          case 6: {
               manx-=4;
               break;}
          case 7: {
               manx-=4;
               many-=1;
               break;
               }
          case 8: {
               many-=1;
               break;
               }
          }
     if (manx>564) {manx=564; return 1;}
     if (manx<16)   {manx=16;   return 1;}
     if (many>152) {many=152; return 1;}
     if (many<8)   {many=8;   return 1;}
     return 0;
}

CalOfset(dir)
int dir;
{
     switch(dir){
          case 1:
          case 2:
          case 3: {
               ofset=WALKRO;
               break;}
          case 4: {
               ofset=WALKDO;
               break;}
          case 5:
          case 6:
          case 7: {
               ofset=WALKLO;
               break;}
          case 8: {
               ofset=WALKUO;
               break;}
          }
}

Error()
{
     KilBuf(wpath,pid,0);
     ScrStat(1);
     CurOn(wpath);
     EchoOn(wpath);
     FColor(wpath,3);
     printf("End of Program\n");
     exit(0);
}

Setup()
{
     char c,ins;
     int dx=-1,dy=0;
     int hsiz,vsiz,x1,x2,x3;
     static int palet[16]={0x00,0x02,0x34,0x09,
                           0x21,0x3f,0x38,0x07,
                           0x37,0x0f,0x22,0x15,
                           0x24,0x3b,0x3c,0x3f };
     /* These palet values should be in the same file   */
     /* as the icons.  i.e.  icons.dat should be:       */
     /*    16 chars representing the palettes           */
     /*    icon data                                    */
     lopx=0;
     if ((path=fopen("walk.ike","r")) == NULL) {
          if ((path=fopen("/dd/gfx/walk.ike","r")) == NULL) {
               if ((path=fopen("/dd/sys/walk.ike","r")) == NULL) {
                    fprintf(stderr,"Cannot find icons.\n");
                    exit(16);
                    }
               }
          }
     while(fread(block,sizeof(char),1,path)) {
          fread(block,sizeof(char),1,path);
          NIKE++; lopx++;
          GPLoad(wpath,pid,lopx,8,32,32,512);
          fread(block,sizeof(char)*512,1,path);
          write(wpath,block,512);
          }
     fclose(path);
     ScrStat(0);
     DWEnd(wpath);
     DWSet(wpath,8,0,0,40,24,15,0,0);
     Select(wpath);
     Clear(wpath);
     CurOff(wpath);
     EchoOff(wpath);
     for (lopx=0; lopx<16; lopx++) {
          Palette(wpath,lopx,palet[lopx]);
          }
}

ScrStat(wtd)
int wtd;
{
     static int  horisiz,vertsiz;
     static char palbuf[16];
     static int  scrtype;
     static int  fore,back,bord;
     if (wtd==1) {
          DWEnd(wpath);
          DWSet(wpath,scrtype,0,0,horisiz,vertsiz,fore,back,bord);
          Select(wpath);
          DefColr(wpath);
          /*for (lopx=0; lopx<16; lopx++) {
               Palette(wpath,(int)(palbuf[lopx]));
               }*/
          }
       else {
          _gs_styp(wpath,&scrtype);
          _gs_scsz(wpath,&horisiz,&vertsiz);
          _gs_fbrg(wpath,&fore,&back,&bord);
          _gs_palt(wpath,palbuf);
          }
}

EchoOff(path)
int path;
{
     char scrn[32];
     getstat(0,path,scrn);
     scrn[4]=0;
     setstat(0,path,scrn);
}

EchoOn(path)
int path;
{
     char scrn[32];
     getstat(0,path,scrn);
     scrn[4]=1;
     setstat(0,path,scrn);
}

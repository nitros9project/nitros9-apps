/* SetMap - Palette creator for ViewGIF 2.0 */
/* These routines are the heart of the color analysis.  They take the */
/* Global bitmap and, based on the dithering factor, produce a CoCo color */
/* palette. */
#include "port.h"

typedef char bool;
#undef FALSE
#undef TRUE
#define FALSE 0
#define TRUE (!FALSE)

extern int cmsize,cmsize2,globbits,dfactor,greytype,britefac;
extern vg_byte cococolr[16],cococol2[16],cocomap[16][3],cocomap2[16][3],
            coloruse[256],globmap[256][3];
extern struct trantype transtab[256][4];

int setmap(void)
{
  int redval,
      grnval,
      blueval,
      globred,
      globgrn,
      globblue,
      numtrans,
      tolrnce,
      x,
      y,
      add,
      uplim,
      lowlim,
      thisent,
      tv,
      mintoler;
  bool found;

  cmsize=0;
  lowlim=42-(dfactor>0 ? dfactor : 0);
  uplim=43+(dfactor>0 ? dfactor : 0);
  tolrnce=(dfactor<0 ? -dfactor : 0);
  for (x=0;x<(1<<globbits);++x) {
    if (coloruse[x]) {
      numtrans=0;
      for (add=lowlim;add<uplim;add=minadd(globmap[x],add)) {
        globred=(globmap[x][0] & 0xff)+add;
        globgrn=(globmap[x][1] & 0xff)+add;
        globblue=(globmap[x][2] & 0xff)+add;
        redval=globred/85;
        grnval=globgrn/85;
        blueval=globblue/85;
        found=FALSE;
        mintoler=tolrnce+1;
        for (y=0;y<cmsize;++y) {
          tv=tolerval(cocomap[y],globred,globgrn,globblue);
          if (tv<mintoler) {
            mintoler=tv;
            thisent=y;
            found=TRUE;
            if (mintoler==0)
              break;
          }
        }
        if (!found) {
          if (cmsize>15)
            return(1);
          cocomap[cmsize][0]=redval;
          cocomap[cmsize][1]=grnval;
          cocomap[cmsize][2]=blueval;
          thisent=cmsize;
          cococolr[cmsize++]=colorval(redval,grnval,blueval);
        }
        if (numtrans>=4) fatal("too many color transitions");
        transtab[x][numtrans].addval=add;
        VG_SET1(transtab[x][numtrans],thisent);
        ++numtrans;
      }
      if (numtrans>4)
        fatal("BUG: numtrans>4");
      if (numtrans<4)
        transtab[x][numtrans].addval=85;
    }
  }
  return(0);
}

int setmap2(void)
{
  int mode,    count,
      redval,
      grnval,
      blueval,
      globred,
      globgrn,
      globblue,
      numtrans,
      tolrnce,
      x,y,z,
      add,
      uplim,
      lowlim,
      thisent, thisent2,
      tv,
      mintoler;
  bool found;

  cmsize=0;
  cmsize2=0;
  lowlim=21-(dfactor>0 ? dfactor : 0);
  uplim=22+(dfactor>1 ? dfactor : 0);
  tolrnce=(dfactor<0 ? -dfactor : 0);
  for (x=0;x<(1<<globbits);++x) {
    if (coloruse[x]) {
      numtrans=0;
      for (add=lowlim;add<uplim;add=minadd2(globmap[x],add)) {
        globred=(globmap[x][0] & 0xff)+add;
        globgrn=(globmap[x][1] & 0xff)+add;
        globblue=(globmap[x][2] & 0xff)+add;
        redval=globred/43;
        grnval=globgrn/43;
        blueval=globblue/43;
        found=FALSE;
        mintoler=tolrnce+1;
        for (z=0;z<cmsize2;++z) {
          for (y=0;y<cmsize;++y) {
            if (nearcolr(cocomap[y],cocomap2[z])) {
              if (tolrnce>0) {
                tv=toler2(cocomap[y],cocomap2[z],globred,globgrn,globblue);
                if (tv<mintoler) {
                  mintoler=tv;
                  thisent=y;
                  thisent2=z;
                  found=TRUE;
                  if (mintoler==0)
                    break;
                }
              } else {
                if (cocomap[y][0]+cocomap2[z][0]==redval &&
                    cocomap[y][1]+cocomap2[z][1]==grnval &&
                    cocomap[y][2]+cocomap2[z][2]==blueval) {
                  thisent=y;
                  thisent2=z;
                  found=TRUE;
                  break;
                }
              }
            }
          }
        }
        mode=cmsize<cmsize2;
        for (count=2;!found && count>0;--count,mode=!mode) {
          switch (mode) {
            case 0:
              if (cmsize2<=15) {
                mintoler=tolrnce+1;
                for (y=0;y<cmsize;++y) {
                  ncolor(cocomap[y],cocomap2[cmsize2],redval,grnval,blueval);
                  if (tolrnce>0) {
                    tv=toler2(cocomap[y],cocomap2[cmsize2],
                              globred,globgrn,globblue);
                    if (tv<mintoler) {
                      mintoler=tv;
                      thisent=y;
                      found=TRUE;
                      if (mintoler==0)
                        break;
                    }
                  } else {
                    if (cocomap[y][0]+cocomap2[cmsize2][0]==redval &&
                        cocomap[y][1]+cocomap2[cmsize2][1]==grnval &&
                        cocomap[y][2]+cocomap2[cmsize2][2]==blueval) {
                      thisent=y;
                      found=TRUE;
                      break;
                    }
                  }
                }
                if (found) {
                  ncolor(cocomap[thisent],cocomap2[cmsize2],
                         redval,grnval,blueval);
                  cococol2[cmsize2]=cval(cocomap2[cmsize2]);
                  thisent2=cmsize2++;
                }
              }
              break;
            case 1:
              if (cmsize<=15) {
                mintoler=tolrnce+1;
                for (y=0;y<cmsize2;++y) {
                  ncolor(cocomap2[y],cocomap[cmsize],redval,grnval,blueval);
                  if (tolrnce>0) {
                    tv=toler2(cocomap2[y],cocomap[cmsize],
                              globred,globgrn,globblue);
                    if (tv<mintoler) {
                      mintoler=tv;
                      thisent2=y;
                      found=TRUE;
                      if (mintoler==0)
                        break;
                    }
                  } else {
                    if (cocomap2[y][0]+cocomap[cmsize][0]==redval &&
                        cocomap2[y][1]+cocomap[cmsize][1]==grnval &&
                        cocomap2[y][2]+cocomap[cmsize][2]==blueval) {
                      thisent2=y;
                      found=TRUE;
                      break;
                    }
                  }
                }
                if (found) {
                  ncolor(cocomap2[thisent2],cocomap[cmsize],
                         redval,grnval,blueval);
                  cococolr[cmsize]=cval(cocomap[cmsize]);
                  thisent=cmsize++;
                }
              }
              break;
          }
        }
        if (!found) {
          if (cmsize>15 || cmsize2>15)
            return(1);
          cocomap[cmsize][0]=redval/2;
          cocomap[cmsize][1]=grnval/2;
          cocomap[cmsize][2]=blueval/2;
          cococolr[cmsize]=cval(cocomap[cmsize]);
          cocomap2[cmsize2][0]=(redval+1)/2;
          cocomap2[cmsize2][1]=(grnval+1)/2;
          cocomap2[cmsize2][2]=(blueval+1)/2;
          cococol2[cmsize2]=cval(cocomap2[cmsize2]);
          thisent=cmsize++;
          thisent2=cmsize2++;
        }
        if (numtrans>=4) fatal("too many color transitions");
        transtab[x][numtrans].addval=add;
        VG_SET1(transtab[x][numtrans],thisent);
        VG_SET2(transtab[x][numtrans],thisent2);
        ++numtrans;
      }
      if (numtrans>4)
        fatal("BUG: numtrans>4");
      if (numtrans<4)
        transtab[x][numtrans].addval=85;
    }
  }
  return(0);
}

int cval(char * cm)
{
  return(colorval(cm[0],cm[1],cm[2]));
}

int nearcolr(char * cm1, char * cm2)
{
  int dr,dg,db;

  dr=cm2[0]-cm1[0];
  dg=cm2[1]-cm1[1];
  db=cm2[2]-cm1[2];
  return(dr>=-1 && dr<=1 && dg>=-1 && dg<=1 && db>=-1 && db<=1);
}

int ncolor(char * cm1, char * cm2, int r, int g, int b)
{
  int dr,dg,db;

  cm2[0]=r-cm1[0];
  cm2[1]=g-cm1[1];
  cm2[2]=b-cm1[2];
  dr=cm2[0]-cm1[0];
  dg=cm2[1]-cm1[1];
  db=cm2[2]-cm1[2];
  if (dr<-1)
    dr= -1;
  else if (dr>1)
    dr=1;
  if (dg<-1)
    dg= -1;
  else if (dg>1)
    dg=1;
  if (db<-1)
    db= -1;
  else if (db>1)
    db=1;
  cm2[0]=cm1[0]+dr;
  cm2[1]=cm1[1]+dg;
  cm2[2]=cm1[2]+db;
  return 0;
}

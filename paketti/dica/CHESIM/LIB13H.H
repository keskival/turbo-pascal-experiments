/************************************************************************/
/* lib13h.h                                                             */
/************************************************************************/
#ifndef _chem_lib13h_h
#define _chem_lib13h_h

unsigned char *virt;


void inline flips(char *virt)
{
 int i=16000,eedeeii=0xA0000;
 int *virscr;
 virscr=(int *)virt;
 _farsetsel(_dos_ds);
 do
  {
   _farnspokel(eedeeii,*virscr);
   virscr++;
   eedeeii+=4;
  } while (--i);
}


void clear(char *virt)
{
 int i=16000;
 int *virscr;
 virscr=(int *)virt;
 while (i--) *(virscr++)=0;
}


void setcolor(unsigned char num,unsigned char r,
                                unsigned char g,
                                unsigned char b)
{
 outportb(0x3c8,num);
 outportb(0x3c9,r);
 outportb(0x3c9,g);
 outportb(0x3c9,b);
}

void init()
{
 virt=(unsigned char *)malloc(64000);
 clear(virt);
 textmode(0x13);
}


void close()
{
 free(virt);
 textmode(0x3);
}


#endif

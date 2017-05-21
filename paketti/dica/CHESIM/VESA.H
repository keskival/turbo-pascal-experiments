/************************************************************************/
/* t„m„ on tapion vesa-kirjaston header-osa.                            */
/* Copyright (c) 1997 Tapio Vuorinen aka Bull / Hubris                  */
/************************************************************************/

#include <ctype.h>
#include <stdio.h>
#include <pc.h>
#include <go32.h>
#include <sys/nearptr.h>
#include <dpmi.h>
#include <math.h>
#include <malloc.h>
#include <conio.h> //getch()

#define TRUE 1
#define FALSE 0

#define PACKED __attribute__ ((packed))
typedef unsigned char uchar;
typedef unsigned short ushort;
typedef unsigned long ulong;
typedef unsigned int uint;

#pragma pack(1)
typedef struct _VBEvInfo
{
    char signature[4] PACKED;
    unsigned short version PACKED;
    unsigned long OEMnamepointer PACKED;
    unsigned long capabilities PACKED;
    unsigned long modelistpointer PACKED;
    unsigned short memoryblocks PACKED;
    char reserved[493] PACKED;
} VBEvInfo;

#pragma pack(1)
typedef struct _VBEmInfo
{
    ushort attributes PACKED;
    uchar AttrWinA PACKED;
    uchar AttrWinB PACKED;
    ushort granularityKB PACKED;
    ushort WindowSizeKB PACKED;
    ushort WinAstartSeg PACKED;
    ushort WinBstartSeg PACKED;
    ulong FARwinPosFunc PACKED;
    ushort bpl PACKED; // bytes per line
    ushort width PACKED;
    ushort height PACKED;
    uchar CharWidth PACKED;
    uchar CharHeight PACKED;
    uchar memPlanes PACKED;
    uchar bpp PACKED; // bits per pixel.. aktiivista bitti„ per pikseli.
    uchar banks PACKED;
    uchar memorymodel PACKED;
    uchar banksizeKB PACKED;
    uchar imagepages PACKED;
    uchar reserved1 PACKED;
    uchar RedMaskSize PACKED; // montako bitti„ punaista per pixel
    uchar RedFieldPos PACKED;
    uchar GreenMaskSize PACKED; // montako bitti„ vihre„„ per pixel
    uchar GreenFieldSize PACKED;
    uchar BlueMaskSize PACKED; // montako sinist„ punaista per pixel
    uchar BlueFieldSize PACKED;
    uchar ResMaskSize PACKED; // montako bitti„ varattua per pixel
    uchar ResMaskPos PACKED;
    uchar DirColMInfo PACKED;
    ulong PhyAddrLFB PACKED;
    ulong offscreenmem PACKED;
    ushort offscreenKB PACKED;
    uchar reserved2[206] PACKED;
} VBEmInfo;

typedef struct _VBE32BitColor
{
    uchar b PACKED;
    uchar g PACKED;
    uchar r PACKED;
    uchar reserved PACKED;
} VBE32BitColor;

typedef struct _VBE24BitColor
{
    uchar b PACKED;
    uchar g PACKED;
    uchar r PACKED;
} VBE24BitColor;

typedef struct _VBE16BitColor
{
    unsigned b:5;
    unsigned g:6;
    unsigned r:5;
} VBE16BitColor;

typedef struct _VBE15BitColor
{
    unsigned b:5;
    unsigned g:5;
    unsigned r:5;
    unsigned reserved:1;
} VBE15BitColor;

#pragma pack()

struct
{
    int wingran;
    uint linearaddress;
    ushort linearselector,bytesperline,bytesperpixel;
    ushort width,height;
    uchar *LFBptr;
} VBECurrentMode;

VBEvInfo VBEinfo;
VBEmInfo VBEmodeinfo;
unsigned char *VESAvirscr;

/* ******************************************************************** */
/* ********************************************************************
 Common VESA functions begin...
 ******************************************************************** */
/* ******************************************************************** */

void VESAgetinfo(VBEvInfo *vbeinfo);
void VESAgetmodeinfo(ushort mode, VBEmInfo *vbemodeinfo);
void VESAsetmode(ushort mode, int LFB);
void VESAswitchbank(short bank);
void VESAgetwingran();
void VESAgetlinearaddress();
void VESAinitmode(ushort mode);
void VESAdeinitmode();
int VESAcheckVBE2();
int VESAcheckmode(int mode);

// user functions:
void setVESAmode(int mode);
void VESAflip(void *ptr);
void VESAclear(void *ptr);


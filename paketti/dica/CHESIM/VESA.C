/************************************************************************/
/* t„„ll„ on tapion vesa-kirjaston koodi.                               */
/* Copyright (c) 1997 Tapio Vuorinen aka Bull / Hubris.                 */
/* some minor modifications by Chem.                                    */
/************************************************************************/

#include "vesa.h"

unsigned char *VESAvidseg=(unsigned char *)0x0A0000;

/* ******************************************************************** */
/* ********************************************************************
 Common functions begin...
 ******************************************************************** */
/* ******************************************************************** */

void VESAgetinfo(VBEvInfo *vbeinfo)
{
    __dpmi_regs r;

    vbeinfo->signature[0]='V';
    vbeinfo->signature[1]='B';
    vbeinfo->signature[2]='E';
    vbeinfo->signature[3]='2';
    
    r.x.ax = 0x4F00;
    r.x.di = __tb & 0x0F;
    r.x.es = (__tb >> 4) & 0xFFFF;
    dosmemput(vbeinfo, sizeof(*vbeinfo), __tb);
    __dpmi_int(0x10, &r);
    dosmemget(__tb, sizeof(*vbeinfo), vbeinfo);
}

/* ******************************************************************** */

void VESAgetmodeinfo(ushort mode, VBEmInfo *vbemodeinfo)
{
    __dpmi_regs r;
    
    r.x.ax = 0x4F01;
    r.x.cx = mode;
    r.x.di = __tb & 0x0F;
    r.x.es = (__tb >> 4) & 0xFFFF;
    
    dosmemput(vbemodeinfo, sizeof(*vbemodeinfo), __tb);
    __dpmi_int(0x10, &r);
    dosmemget(__tb, sizeof(*vbemodeinfo), vbemodeinfo);
}

/* ******************************************************************** */

void VESAsetmode(ushort mode, int LFB)
{
    __dpmi_regs r;

    r.x.ax=0x4F02;
    if (LFB)
    {
        r.x.bx=(mode | 0x4000);
    } else {
        r.x.bx=mode;
    }
    __dpmi_int(0x10,&r);
}

/* ******************************************************************** */

inline void VESAswitchbank(short bank)
{
    __dpmi_regs r;

    r.x.ax=0x4F05;
    r.x.bx=0x0000;
    r.x.dx=bank;
    __dpmi_int(0x10, &r);
}

/* ******************************************************************** */

void VESAgetwingran()
{
    VBECurrentMode.wingran=0;
    while ((unsigned)(64 >> VBECurrentMode.wingran) != VBEmodeinfo.granularityKB)
        VBECurrentMode.wingran++;
}

/* ******************************************************************** */

void VESAgetlinearaddress()
{
    __dpmi_meminfo mi;
    int buffersize;

    buffersize=((int)VBEmodeinfo.bpl * (int)VBEmodeinfo.height);
    mi.size=(ulong)buffersize;
    mi.address=VBEmodeinfo.PhyAddrLFB;
    __dpmi_physical_address_mapping(&mi);
    __dpmi_lock_linear_region(&mi);
    VBECurrentMode.linearaddress=mi.address;

    VBECurrentMode.linearselector=__dpmi_allocate_ldt_descriptors(1);
    __dpmi_set_segment_base_address(VBECurrentMode.linearselector, VBECurrentMode.linearaddress);
    __dpmi_set_segment_limit(VBECurrentMode.linearselector, buffersize-1);

    VBECurrentMode.LFBptr=(uchar *)0x0;
}

/* ******************************************************************** */

void VESAinitmode(ushort mode)
{
    int virscrsize=0;

    if (!VESAcheckmode(mode))
    {
        VESAgetmodeinfo(mode,&VBEmodeinfo);

        printf("memPlanes %u\n", VBEmodeinfo.memPlanes);
        printf("banks %u\n", VBEmodeinfo.banks);
        printf("granularityKB %u\n", VBEmodeinfo.granularityKB);
        printf("banksizeKB %u\n", VBEmodeinfo.banksizeKB);
        printf("imagepages %u\n", VBEmodeinfo.imagepages);
        printf("reserved1 %u\n", VBEmodeinfo.reserved1);
        printf("bpp %u\n",VBEmodeinfo.bpp);
        printf("bpl %u\n",VBEmodeinfo.bpl);
        printf("width %u\n",VBEmodeinfo.width);
        printf("height %u\n",VBEmodeinfo.height);
        printf("RedMaskSize %u\n",VBEmodeinfo.RedMaskSize);
        printf("GreenMaskSize %u\n",VBEmodeinfo.GreenMaskSize);
        printf("BlueMaskSize %u\n",VBEmodeinfo.BlueMaskSize);
        printf("ResMaskSize %u\n",VBEmodeinfo.ResMaskSize);
        printf("DirColMInfo %u\n",VBEmodeinfo.DirColMInfo);

        getch();

//        VBEmodeinfo.attributes&=(~128L); //remove LFB support.
        if ((VBEmodeinfo.attributes & 128) == 128)
        {
            VESAsetmode(mode,TRUE);
        } else {
            VESAsetmode(mode,FALSE);
        }

        VBECurrentMode.bytesperline=VBEmodeinfo.bpl;

// i think this method is a bit unsecure; for example, my cirrus 5430's
// bpl for mode 640x480x24b is 2048; sure, it truncates down to 3 bytes per
// pixel, but that probably won't happen with all mode and bpl combinations.
//        VBECurrentMode.bytesperpixel=VBEmodeinfo.bpl / VBEmodeinfo.width;

// i suggest this:
        VBECurrentMode.bytesperpixel=(VBEmodeinfo.RedMaskSize +
                                      VBEmodeinfo.GreenMaskSize +
                                      VBEmodeinfo.BlueMaskSize +
                                      VBEmodeinfo.ResMaskSize) >> 3;
// unfortunately my cirrus has 3 bytes per pixel in the both 24 bit modes it
// supports, so i can't be absolutely sure whether the Res(erved)MaskSize
// actually is 8 on the cards, which have 4 bytes per pixel. (32 bit modes)

        VBECurrentMode.width=VBEmodeinfo.width;
        VBECurrentMode.height=VBEmodeinfo.height;

        VESAgetwingran();
        if ((VBEmodeinfo.attributes & 128) == 128)
        {
            VESAgetlinearaddress();
        } else {
            VBECurrentMode.linearaddress=0;
        }

        virscrsize=(int)VBEmodeinfo.bpl * (int)VBEmodeinfo.height;
        VESAvirscr=(unsigned char *)malloc(virscrsize);
    }
}

/* ******************************************************************** */

void VESAdeinitmode()
{
    free(VESAvirscr);
    VBECurrentMode.wingran=0;
    VBECurrentMode.linearaddress=0;
    VBECurrentMode.linearselector=0;
    VBECurrentMode.bytesperline=0;
    VBECurrentMode.bytesperpixel=0;
    VBECurrentMode.width=0;
    VBECurrentMode.height=0;
}

/* ******************************************************************** */

int VESAcheckVBE2()
{
    VESAgetinfo(&VBEinfo);
    if (VBEinfo.version == 512)
        return 0;
    else
        return -1;
}

/* ******************************************************************** */

int VESAcheckmode(int mode)
{
    VESAgetmodeinfo(mode, &VBEmodeinfo);
    if ((VBEmodeinfo.attributes & 1) == 1)
    {
        return 0;
    } else {
        return -1;
    }
}

/* ******************************************************************** */

void setVESAmode(int mode)
{
 if ( VESAcheckVBE2() == -1 )
  {
   printf("VBE 2.0 not supported! (install univbe)\n");
   exit(1);
  }

 if ( VESAcheckmode(mode) == -1 )
  {
   printf("Requested mode (0x%X) not supported!\n",mode);
   exit(1);
  }

 VESAinitmode(mode);
 VESAclear(VESAvirscr);
}

/* ******************************************************************** */
/* ******************************************************************** */

/* Header files for different modes */

#include "0x10f.h"

/* ******************************************************************** */
/* ********************************************************************
 Multi-mode functions begin...
 ******************************************************************** */
/* ******************************************************************** */

void VESAflip(void *ptr)
{
    VESAflip10F((VBE24BitColor *)ptr);
}

/* ******************************************************************** */

void VESAclear(void *ptr)
{
    VESAclear10F((VBE24BitColor *)ptr);
}

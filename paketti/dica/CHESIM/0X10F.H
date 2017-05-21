/* ******************************************************************** */
/* ********************************************************************
 Mode 0x10F functions begin...
update:
 general 24-bit mode functions begin..
 ******************************************************************** */
/* ******************************************************************** */

void inline VESAclear10F(VBE24BitColor *dest)
{
    int *point=(int *)dest, count,
        size = (int)VBECurrentMode.bytesperline * (int)VBECurrentMode.height;

    size /= 4;

    for (count=0;count<size;count++)
        point[count]=0;
}

/* ******************************************************************** */

void inline VESALFBflip10F(VBE24BitColor *source)
{
    int size = VBECurrentMode.bytesperline * VBECurrentMode.height;
    movedata(_my_ds(), (uint)source,
             VBECurrentMode.linearselector, (uint)VBECurrentMode.LFBptr,
             size);
    /*dosmemput(source, (64000*sizeof(VBE24BitColor)), linaddr);*/
}

/* ******************************************************************** */

void inline VESAbankflip10F(VBE24BitColor *source)
{ // banksize has to be 64kB.
    char *dest,*src;
    int i,size = (int)VBECurrentMode.bytesperline * (int)VBECurrentMode.height;
    
    src=(char *)source;
    dest=VESAvidseg + __djgpp_conventional_base;
    
    __djgpp_nearptr_enable();
    
    i = 0;
    while (size > 0) {
     VESAswitchbank(i << VBECurrentMode.wingran);
     i++;
     if (size > 65535L) memcpy(dest,src,65536L);
      else memcpy(dest,src,size);
     size -= 65536L;
     src += 65536L;
    }
    
    __djgpp_nearptr_disable();
}

/* ******************************************************************** */

void VESAflip10F(VBE24BitColor *source)
{
    if (VBECurrentMode.linearaddress)
    {
        VESALFBflip10F(source);
    } else {
        VESAbankflip10F(source);
    }
}

/************************************************************************/
/* pcx.h                                                                */
/************************************************************************/
/* taitaa olla alunperin ilkan k„sialaa. min„ rip'n'rollaan t„mm”set :) */
/************************************************************************/
#ifndef _pcx_h
#define _pcx_h

#define byte unsigned char
#define word unsigned short
#define dword unsigned long

int loadpcx(kuva pic)
{

  typedef struct
  {
    byte manufacturer,version,encoding,bitsperpixel;
    word xmin,ymin,xmax,ymax,hres,vres;
    byte palette[48];
    byte reserved;
    byte colorplanes;
    word bytesperline;
    word palettetype;
    byte filler[58];
  } pcxheadertype;

  pcxheadertype header;
  FILE *pcxfile;
  char fname[50]="";
  word ofs,x,y;
  byte k,c,loop;
  word y_size,x_size,ofs_inc;


 /************************************************************************/
 /* lukee paletin tiedoston lopusta                                      */
 /************************************************************************/
 void setpal(void)
 {
  fseek(pcxfile,filelength(fileno(pcxfile))-768,SEEK_SET);
  fread(pic.palette,1,768,pcxfile);
 }


 /************************************************************************/
 /* itse lukurutiini.                                                    */
 /************************************************************************/

  strcat(fname,pic.filename);
  pcxfile=fopen(fname,"rb");
  if (pcxfile==NULL) return -1;
  fread(&header,sizeof(header),1,pcxfile);
  if (header.reserved!=0)
    return -1;
  setpal();
  fseek(pcxfile,128,SEEK_SET);
  y_size=header.ymax-header.ymin;//if (ySize>199)ySize=199;
  x_size=header.bytesperline*header.colorplanes;//header.xmax-header.xmin;
  pic.ykoko=y_size;
  pic.xkoko=x_size;
  ofs=0;
  if (x_size<256) ofs_inc=256-x_size;
   else ofs_inc=0;
  for (y=0;y<=y_size;y++)
  {
    x=0;
    while (x<x_size)
    {
      fread(&c,1,1,pcxfile);
      if ((c&192)==192)
      {
        loop=c&63;
        fread(&c,1,1,pcxfile);
        for (k=0;k<loop;k++)
          pic.data[ofs+k]=c;
        ofs+=loop;
        x+=loop;
      }
      else
      {
        pic.data[ofs]=c;
        ofs++;
        x++;
      }
    }
    ofs+=ofs_inc;
  }
  fclose(pcxfile);
  return 0;
}

#endif


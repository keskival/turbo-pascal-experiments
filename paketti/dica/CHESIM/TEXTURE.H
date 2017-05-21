/************************************************************************/
/* texture.h, texture loader.                                           */
/************************************************************************/
#ifndef _chem_texture_h
#define _chem_texture_h


/************************************************************************/
/* lataa texturemapin.                                                  */
/************************************************************************/
int load_textmap(scene_type *scene, int texturenro, char *fn)
{
 printf("loading texturemap..(%s)\n", fn);

 scene->textm[texturenro].filename = fn;
 scene->textm[texturenro].palette = (byte *)malloc(768);
 scene->textm[texturenro].data = (byte *)malloc(65536);

 if (loadpcx(scene->textm[texturenro]) == -1)
  {
   printf("file (%s) not found.\n", fn);
   return -1;
  }
 return 0;
}


/************************************************************************/
/* vapauttaa texturemapin.                                              */
/************************************************************************/
void free_textmap(scene_type *scene, int texturenro)
{
 if (scene->textm[texturenro].palette != NULL) free(scene->textm[texturenro].palette);
 if (scene->textm[texturenro].data != NULL) free(scene->textm[texturenro].data);
}

#endif


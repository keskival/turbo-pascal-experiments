/************************************************************************/
/* loadasc.h, 3d studion .asc-filejen lataaja.                          */
/************************************************************************/

#ifndef _chem_load_asc_h
#define _chem_load_asc_h


/************************************************************************/
/* includes:                                                            */
/************************************************************************/
#include "bstructs.h"


/************************************************************************/
/* varaa objektille sen tarvitseman muistin.                            */
/* HUOMIO: objektilla TŽYTYY olla jo verteksien ja facejen m„„r„        */
/* m„„riteltyn„!!                                                       */
/************************************************************************/
int allocate_object(objtype *obje)
{// allocate memory:

 // for vertices:
 obje->vertex = (vertextype *)malloc(obje->vertices * sizeof(vertextype));
 if (obje->vertex == NULL) return -1; /* out of memory */
 memset(obje->vertex, 0, obje->vertices * sizeof(vertextype));

 // for faces:
 obje->face = (facetype *)malloc(obje->faces * sizeof(facetype));
 if (obje->face == NULL) return -1; /* out of memory */
 memset(obje->face, 0, obje->faces * sizeof(facetype));

 // for vertexnormals:
 obje->normal = (vertextype *)malloc(obje->vertices * sizeof(vertextype));
 if (obje->normal == NULL) return -1; /* out of memory */
 memset(obje->normal, 0, obje->vertices * sizeof(vertextype));

 // for texture co-ordinates:
 obje->uv = (uv_type *)malloc(obje->vertices * sizeof(uv_type));
 if (obje->uv == NULL) return -1; /* out of memory */
 memset(obje->uv, 0, obje->vertices * sizeof(uv_type));

 return 0; // ok, done.
}


/************************************************************************/
/* lataa 3dstudion .asc-filen.                                          */
/************************************************************************/
signed int lataa_asc(char *filename, objtype *obje, float mul) /* -1 failed, 0 ok */
{
 FILE *f;
 char gotline[160];

 /************************************************************************/
 /* lukua helpottavia pikkufunkkareita.                                  */
 /************************************************************************/

 float vall(char *str)
  {
   return atof(str);
  }

 void getline()
 {
  memset(&gotline[0], 0, 160);
  fgets(gotline, 160, f);
  gotline[159] = 0;
  strupr(gotline);
 }

 float get_a_number_from_gotline(char *key)
 {
  char tmp2[160];
  char *rivi;
  unsigned int p1, p2;

  p1 = (unsigned int)strstr(gotline, key) - (unsigned int)gotline;
  memset(&tmp2[0], 0, 160);
  rivi = gotline;
  rivi += p1 + strlen(key);
  p2 = 0;
  /* update rivi until a -,+ or a number is found */
  while ( (*rivi != '-') && (*rivi != '+') && ((*rivi < 48)||(*rivi > 57)) ) rivi++;
  strncpy(tmp2, rivi, 30);
  tmp2[159] = 0;
  return vall(tmp2);
 }

 signed int find_key(char *key)
 {
  do {
   getline();
  } while ( (!strstr(gotline, key)) && (!feof(f)) );
  if (feof(f)) return -1; /* not an ASC file */
  return 0; /* key found */
 }

 /************************************************************************/
 /* itse lukurutiini.                                                    */
 /************************************************************************/

 signed int getobj()
 {
  int i, index;

  /* seek to the beginning of the file */
  fseek(f, 0, SEEK_SET);


  /* check the number of vertices and faces */
  if (-1 == find_key("VERTICES:")) return -1; /* not an ASC file */
  obje->vertices = (unsigned int)get_a_number_from_gotline("VERTICES:");
  obje->faces = (unsigned int)get_a_number_from_gotline("FACES:");


  if (allocate_object(obje) != 0) return -1; // objektin varaus


  /* search vertex list */
  if (-1 == find_key("VERTEX LIST")) return -1; /* vertex list not found */


  /* read the correct number of vertices */
  for (i = 0; i < obje->vertices; i++)
   {
    if (-1 == find_key("VERTEX")) return -1; /* vertex list not found */

    index = (int)get_a_number_from_gotline("VERTEX ");

    if ((index < 0) || (index >= obje->vertices))
     return -1; /* invalid asc file */

    // store vertex multiplied with mul (size change):
    obje->vertex[index].x = mul * get_a_number_from_gotline("X:");
    obje->vertex[index].y = mul * get_a_number_from_gotline("Y:");
    obje->vertex[index].z = mul * get_a_number_from_gotline("Z:");
   }


  /* search face list */
  if (-1 == find_key("FACE LIST")) return -1; /* face list not found */


  /* read the correct number of vertices */
  for (i = 0; i < obje->faces; i++)
   {
    if (-1 == find_key("FACE")) return -1; /* vertex list not found */

    index = (int)get_a_number_from_gotline("FACE ");

    if ((index < 0) || (index >= obje->faces)) return -1; /* invalid asc file */

    // store face:
    obje->face[index].a = get_a_number_from_gotline("A:");
    obje->face[index].b = get_a_number_from_gotline("B:");
    obje->face[index].c = get_a_number_from_gotline("C:");
   }
  return 0; // everything ok
 }

 printf("3DS ASC reader: loading %s..", filename);
 fflush(stdout);

 memset(obje, 0, sizeof(objtype)); // clear object

 f = fopen(filename,"rt"); /* read, text */
 if (f == NULL) return -1;  /* file not found */


 if (getobj() != 0)
  {
   return -1;
  }


 printf("ok! vertices: %u, faces: %u \n", obje->vertices, obje->faces);

 fclose(f);
 return 0;
}

#endif

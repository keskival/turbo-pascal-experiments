/************************************************************************/
/* zbuffer.c, 13h zbuffer example.                                      */
/************************************************************************/
/* pikkuohjelma, joka demonstroi z-bufferointia 13h-tilassa.            */
/************************************************************************/

#include "ialot.h"    // IncludeALOTofstuff
#include "lib13h.h"   // 13h tilan rutskut.
#include "bstructs.h" // perusstruktuurit
#include "loadasc.h"  // asc-laturi.
#include "polyg13h.h" // 13h zbuffer flat polygon.

void putobj(objtype obj1, int colstart, float zadd)
{
 int i;
 mcga_pol_vertex_type v1, v2, v3;

 for (i = 0; i < obj1.faces; i++)
  {
   v1.c = colstart + (i&3);

   v1.z = obj1.vertex[obj1.face[i].a].z + 256 + zadd;
   v1.x = obj1.vertex[obj1.face[i].a].x * 256 / v1.z + 160;
   v1.y = obj1.vertex[obj1.face[i].a].y * 256 / v1.z  + 100;

   v2.z = obj1.vertex[obj1.face[i].b].z + 256 + zadd;
   v2.x = obj1.vertex[obj1.face[i].b].x * 256 / v2.z  + 160;
   v2.y = obj1.vertex[obj1.face[i].b].y * 256 / v2.z  + 100;

   v3.z = obj1.vertex[obj1.face[i].c].z + 256 + zadd;
   v3.x = obj1.vertex[obj1.face[i].c].x * 256 / v3.z  + 160;
   v3.y = obj1.vertex[obj1.face[i].c].y * 256 / v3.z  + 100;

   v1.z += 256;
   v2.z += 256;
   v3.z += 256;

   mcga_kol(&v1, &v2, &v3);
  }
}

void main(void)
{
 objtype obj1, obj2;
 int a;
 float count = 1;
 lataa_asc("toorus.asc", &obj1, 0.8);
 lataa_asc("3torus.asc", &obj2, 0.3);

 init();
 while (!kbhit())
  {
   clear(virt);
   for (a = 0; a < 320*200; a++)
    zbuffer[a] = -1;

   putobj(obj1, 100, count * 50);
   putobj(obj2, 90, 0);
   count -= 0.05;
   if (count < -1.5) count = 1.0;

   flips(virt);
  }
 getch();
 close();
 exit(0);
}


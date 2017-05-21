/************************************************************************/
/* scene.h, "scene" rutiinit.                                           */
/************************************************************************/

#ifndef _chem_scene_h
#define _chem_scene_h

#define ever (;;)

/************************************************************************/
/* valmistelee framen piirt„mist„.                                      */
/************************************************************************/
void prepare_frame(scene_type *scene)
{
 int a;

 for (a = 0; a < scene->total_objects; a++) scene->obut[a].hidden = 1;
 scene->total_rot_vertices = 0;
}

/************************************************************************/
/* mallintaa objektit virtual skriiniin.                                */
/************************************************************************/
void draw(scene_type *scene, kamera_type *kamera)
{
 int i, a, ii;
 int faceA, faceB, faceC;
 signed int rlim, llim, ulim, dlim, zlim;
 pol_vertex_type ver1, ver2, ver3;
 float inten;

 /************************************************************************/
 /* varataan muistia z-sortille. t„ss„ on hienosti alloca k„yt”ss„,      */
 /* jonka varaama muisti vapautuu hienosti automaagisesti funkkarista    */
 /* poistuttaessa. (my theory: memory is allocated from stack)           */
 /************************************************************************/
 order_struct *order =
  (order_struct *) alloca(scene->faces_in_scene * sizeof(order_struct));

 float *zval=
  (float *) alloca(scene->faces_in_scene * sizeof(float));


 /************************************************************************/
 /* q-sort rutiini.                                                      */
 /************************************************************************/

 inline int partition(int left, int righ) // qsort-rutiinin k„ytt””n
  {
   int i, j;
   order_struct t;
   float x = zval[order[left].order];

   i = left - 1;
   j = righ + 1;

   for ever
   {
     do j--; while (zval[order[j].order] < x);
     do i++; while (zval[order[i].order] > x);
     if (i < j) {
       t        = order[i];
       order[i] = order[j];
       order[j] = t;
     } else
        return j;
   }

  }

 void qsort(int lef, int rig)
 {
  int gap;
  if (lef < rig)
   {
    gap = partition(lef, rig);
    qsort(lef, gap);
    qsort(gap + 1, rig);
   }
 }


 /************************************************************************/
 /* asetetaan piirtorajat.                                               */
 /************************************************************************/
   c_left  = kamera->screen_left;
   c_right = kamera->screen_right - 1;
   c_up    = kamera->screen_up;
   c_down  = kamera->screen_down - 1;

   rlim = (c_right + 5); // right limit, oikea reuna
   llim = (c_left - 5);  // left limit, vasen reuna
   dlim = (c_down + 5);  // down limit, alaraja
   ulim = (c_up - 5);    // up limit, yl„raja
   zlim = 0;             // z limit, eturaja

 /************************************************************************/
 /* jatketaan sorttaamalla facet                                         */
 /************************************************************************/
 /* ollaan ovelia ja poistetaan n„kym„tt”m„t facet jo ennen piirtoa,     */
 /* sorttauksen yhteydess„. piirto-osasta tulee selke„mpi.               */
 /************************************************************************/

  // sorttauksen valmistelu:
  scene->total_faces = 0;
  for (a = 0; a < scene->total_objects; a++) if (scene->obut[a].hidden == 0)
   {
    scene->obut[a].face_index = scene->total_faces;

    for (i = 0; i < scene->obut[a].objekti.faces; i++)
     {

      ver1.x = (scene->rot[scene->obut[a].objekti.face[i].a + scene->obut[a].vertex_index].x);
      ver1.y = (scene->rot[scene->obut[a].objekti.face[i].a + scene->obut[a].vertex_index].y);
      ver1.z = (scene->rot[scene->obut[a].objekti.face[i].a + scene->obut[a].vertex_index].z);

      ver2.x = (scene->rot[scene->obut[a].objekti.face[i].b + scene->obut[a].vertex_index].x);
      ver2.y = (scene->rot[scene->obut[a].objekti.face[i].b + scene->obut[a].vertex_index].y);
      ver2.z = (scene->rot[scene->obut[a].objekti.face[i].b + scene->obut[a].vertex_index].z);

      ver3.x = (scene->rot[scene->obut[a].objekti.face[i].c + scene->obut[a].vertex_index].x);
      ver3.y = (scene->rot[scene->obut[a].objekti.face[i].c + scene->obut[a].vertex_index].y);
      ver3.z = (scene->rot[scene->obut[a].objekti.face[i].c + scene->obut[a].vertex_index].z);

 // jos facesta on hidden face removal pois p„„lt„ TAI face on n„kyv„
 // sek„
 // KAIKKIEN verteksien z:t positiiviset
 // sek„
 // JONKIN verteksin x positiivinen ja pienempi kuin MAX_X
 // sek„
 // JONKIN verteksin y positiivinen ja pienempi kuin MAX_Y
 // niin piirr„.
      if ( (
             ((scene->obut[a].objekti.face[i].flags & 16) == 0) ||
             (visable(ver1.x, ver1.y, ver2.x, ver2.y, ver3.x, ver3.y))
           )
            &&
           (
            (ver1.z > zlim)&&(ver2.z > zlim)&&(ver3.z > zlim)
           )
            &&
           (
             ((ver1.x > llim) && (ver1.x < rlim)) ||
             ((ver2.x > llim) && (ver2.x < rlim)) ||
             ((ver3.x > llim) && (ver3.x < rlim))
           )
             &&
           (
             ((ver1.y > ulim) && (ver1.y < dlim)) ||
             ((ver2.y > ulim) && (ver2.y < dlim)) ||
             ((ver3.y > ulim) && (ver3.y < dlim))
           )
        ) // then add face to the drawing list.
         {
          order[scene->total_faces].order  = scene->total_faces;
          order[scene->total_faces].object = a;
          order[scene->total_faces].face   = i;

          // sortataan zetojen keskiarvon mukaan.
          // jakolasku on tietenkin turha, koska jos a>b niin my”s 3a>3b jne.
          zval[scene->total_faces] = ver1.z + ver2.z + ver3.z;

          scene->total_faces++;
         }
     }
   }
  qsort(0, scene->total_faces - 1); /* hoida the sorttaus */


 /************************************************************************/
 /* ..ja lopuksi itse piirt„minen.                                       */
 /************************************************************************/
   for (a = 0; a < scene->total_faces; a++)
   {
     ii = order[a].object; // mille objektille piirrett„v„ face kuuluu?
     i = order[a].face; // ja itse facen numero

     // s„il”t„„n indeksit face?-muuttujiin selvyyden vuoksi:
     faceA = scene->obut[ii].objekti.face[i].a + scene->obut[ii].vertex_index;
     faceB = scene->obut[ii].objekti.face[i].b + scene->obut[ii].vertex_index;
     faceC = scene->obut[ii].objekti.face[i].c + scene->obut[ii].vertex_index;
     // eli faceA on facen A-verteksi, faceB B-verteksi ja faceC C-vertex.

     ver1.x = scene->rot[faceA].x; // fetsataan verteksit rot-taulukosta
     ver1.y = scene->rot[faceA].y;
     ver1.z = scene->rot[faceA].z;

     ver2.x = scene->rot[faceB].x;
     ver2.y = scene->rot[faceB].y;
     ver2.z = scene->rot[faceB].z;

     ver3.x = scene->rot[faceC].x;
     ver3.y = scene->rot[faceC].y;
     ver3.z = scene->rot[faceC].z;

     switch (scene->obut[ii].objekti.face[i].flags & 15) // mik„ filleri?
     {
       case 0: // flat
         inten = get_flat_inten(ver1, ver2, ver3, scene->valo);

         ver1.r = inten * (( scene->obut[ii].objekti.face[i].flags >> 8 ) & 0xFF);
         ver1.g = inten * (( scene->obut[ii].objekti.face[i].flags >> 16 ) & 0xFF);
         ver1.b = inten * (( scene->obut[ii].objekti.face[i].flags >> 24 ) & 0xFF);

         kol(&ver1, &ver2, &ver3);
         break;

       case 1: // gouraud
         ver1.r = ( scene->obut[ii].objekti.face[i].flags >> 8 ) & 0xFF;
         ver1.g = ( scene->obut[ii].objekti.face[i].flags >> 16 ) & 0xFF;
         ver1.b = ( scene->obut[ii].objekti.face[i].flags >> 24 ) & 0xFF;

         ver1.c = light_intensity(scene->nor[faceA], scene->valo, 255);
         ver2.c = light_intensity(scene->nor[faceB], scene->valo, 255);
         ver3.c = light_intensity(scene->nor[faceC], scene->valo, 255);

         gkol(&ver1, &ver2, &ver3);
         break;

       case 2: // texture
         ver1.u = scene->obut[ii].objekti.uv[scene->obut[ii].objekti.face[i].a].u * 120 + 120;
         ver1.v = scene->obut[ii].objekti.uv[scene->obut[ii].objekti.face[i].a].v * 120 + 120;

         ver2.u = scene->obut[ii].objekti.uv[scene->obut[ii].objekti.face[i].b].u * 120 + 120;
         ver2.v = scene->obut[ii].objekti.uv[scene->obut[ii].objekti.face[i].b].v * 120 + 120;

         ver3.u = scene->obut[ii].objekti.uv[scene->obut[ii].objekti.face[i].c].u * 120 + 120;
         ver3.v = scene->obut[ii].objekti.uv[scene->obut[ii].objekti.face[i].c].v * 120 + 120;

         if (scene->perspektiivi_korjaus_paalla)
           ptkol(&ver1, &ver2, &ver3,
                 scene->textm[(scene->obut[ii].objekti.face[i].flags >> 8)].data,
                 scene->textm[(scene->obut[ii].objekti.face[i].flags >> 8)].palette);
         else
           ltkol(&ver1, &ver2, &ver3,
                 scene->textm[(scene->obut[ii].objekti.face[i].flags >> 8)].data,
                 scene->textm[(scene->obut[ii].objekti.face[i].flags >> 8)].palette);
         break;

       case 3: // gouraudtexture
         ver1.u = scene->obut[ii].objekti.uv[scene->obut[ii].objekti.face[i].a].u * 120 + 120;
         ver1.v = scene->obut[ii].objekti.uv[scene->obut[ii].objekti.face[i].a].v * 120 + 120;

         ver2.u = scene->obut[ii].objekti.uv[scene->obut[ii].objekti.face[i].b].u * 120 + 120;
         ver2.v = scene->obut[ii].objekti.uv[scene->obut[ii].objekti.face[i].b].v * 120 + 120;

         ver3.u = scene->obut[ii].objekti.uv[scene->obut[ii].objekti.face[i].c].u * 120 + 120;
         ver3.v = scene->obut[ii].objekti.uv[scene->obut[ii].objekti.face[i].c].v * 120 + 120;

         ver1.c = light_intensity(scene->nor[faceA], scene->valo, 255);
         ver2.c = light_intensity(scene->nor[faceB], scene->valo, 255);
         ver3.c = light_intensity(scene->nor[faceC], scene->valo, 255);

         lgtkol(&ver1, &ver2, &ver3,
                scene->textm[(scene->obut[ii].objekti.face[i].flags >> 8)].data,
                scene->textm[(scene->obut[ii].objekti.face[i].flags >> 8)].palette);
         break;

       case 4: // phong
         ver1.r = ( scene->obut[ii].objekti.face[i].flags >> 8 ) & 0xFF;
         ver1.g = ( scene->obut[ii].objekti.face[i].flags >> 16 ) & 0xFF;
         ver1.b = ( scene->obut[ii].objekti.face[i].flags >> 24 ) & 0xFF;

         ver1.nx = scene->nor[faceA].x;
         ver1.ny = scene->nor[faceA].y;
         ver1.nz = scene->nor[faceA].z;

         ver2.nx = scene->nor[faceB].x;
         ver2.ny = scene->nor[faceB].y;
         ver2.nz = scene->nor[faceB].z;

         ver3.nx = scene->nor[faceC].x;
         ver3.ny = scene->nor[faceC].y;
         ver3.nz = scene->nor[faceC].z;

         pkol(&ver1, &ver2, &ver3, scene->valo);
         break;

       case 5: // envmap
         ver1.u = scene->nor[faceA].x * 120 + 127;
         ver1.v = scene->nor[faceA].y * 120 + 127;

         ver2.u = scene->nor[faceB].x * 120 + 127;
         ver2.v = scene->nor[faceB].y * 120 + 127;

         ver3.u = scene->nor[faceC].x * 120 + 127;
         ver3.v = scene->nor[faceC].y * 120 + 127;

         ltkol(&ver1, &ver2, &ver3,
               scene->textm[(scene->obut[ii].objekti.face[i].flags >> 8)].data,
               scene->textm[(scene->obut[ii].objekti.face[i].flags >> 8)].palette);
         break;

       default:
         //
         break;
     }
   }
}


#endif

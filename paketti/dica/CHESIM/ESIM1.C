/************************************************************************/
/* esim1.c. finglish.                                                   */
/* a slow simple 3d-engine for djgpp v2, Copyright (c) 1997 Chem/Hubris */
/* ideat ja kommentit voi e-mailata kaj.bjorklund@mbnet.fi:hin.         */
/************************************************************************/
/* this is not the engine Hubris will use in its future productions,    */
/* we'll use ica's instead (it's better you see :). this is only an     */
/* example "collection" to be distributed with and ONLY with 3Dica.txt  */
/************************************************************************/
/* erityiskiitokset Ilkka Pelkoselle, h„nest„ on ollut suurta hy”ty„ :) */
/* erityiskiitokset Tapio Vuoriselle, jonka VESA-unitti on k„yt”ss„.    */
/************************************************************************/
/* kommentteja on jonkun verran, mutta *parhaiten* asiat *selvi„v„t*    */
/* 3dicasta lukemalla, siell„ kun on selostettu kaikki t„m„n ohjelman   */
/* k„ytt„m„t tekniikat plus more, selv„ll„ suomella, turhia             */
/* tiivistelem„tt„. (mainosmainos)                                      */
/************************************************************************/
/* kuinka kameraa ohjataan:                                             */
/*  a,z=yl”s, alas                                                      */
/*  x,c=py”rit„ vasemmalle, py”rit„ oikealle                            */
/*  r,f=py”rit„ yl”s, py”rit„ alas                                      */
/*  t,y=kallista vasemmalle, kallista oikealle                          */
/*  q,w=vasemmalle, oikealle                                            */
/*  e,d=eteen, taakse                                                   */
/*  +,-=perspektiivikorjaus p„„lle, pois                                */
/************************************************************************/

#include "ialot.h"    // IncludeALOTofstuff
#include "bstructs.h" // perusstruktuurit
#include "vesa.h"     // VESA 2.0-rutiinit. suuret kiitokset Bull!
#include "loadasc.h"  // 3d-studion .asc-filejen lataaja
#include "vector.h"   // vektoriapur”ytinet
#include "matrix.h"   // matriisi r”ytinet
#include "objects.h"  // objektien perusroinat
#include "polygon.h"  // polygoninpiirtorutiinit
#include "pcx.h"      // pcx-kuvan lataus
#include "light.h"    // valohommat
#include "scene.h"    // scenen k„sittely
#include "camera.h"   // kamerarutiinit
#include "texture.h"  // texturen latausrutiinit

#define mypi 3.14159265358979323846264338327950288419716939937511

/************************************************************************/
/* HUOMIO! gfx_mode voi olla *mik„* *tahansa* 24- (tai 32-) bittinen    */
/* grafiikkatila, ja sen pit„isi toimia suoraan (kunhan n„ytt”muistia   */
/* on tarpeeksi).                                                       */
/* tila   koko       v„rit   testattu?                                  */
/* 0x10F, 320x200,   16.8M   kyll„, toimi testatessa.                   */
/* 0x112, 640x480,   16.8M   kyll„, toimi testatessa.                   */
/* 0x115, 800x600,   16.8M   kyll„, mutta EI toiminut! (t„hti)          */
/* 0x118, 1024x768,  16.8M   kyll„, toimi testatessa.                   */
/* 0x11B, 1280x1024, 16.8M   ei testattu.                               */
/* (t„hti) ken bugin l”yt„„, sen kertokoot.                             */
/************************************************************************/
int gfx_mode = 0x10F; // default


/************************************************************************/
/* main                                                                 */
/************************************************************************/
void main(int paramcount,char *paramstr[])
{
 float krx, kry, krz, right = 0, down = 0, forward = 0; // kameran ohjaukselle
 int readkey = 0;
 scene_type scene;   // scenen m„„rittely
 kamera_type kamera; // kameran m„„rittely
 int toorus_rykelma, rocket_chase_mainos, // objektien 'handlet'
     iso_pallo, ar, toorus, toorus2;

 printf("esim1.c by Chem/Hubris.\n"); // commercial presentation

 if (paramcount > 1) // grafiikkatilan voi antaa parametrina.
  gfx_mode = (int)strtol(paramstr[1], NULL, 0);

 scene.perspektiivi_korjaus_paalla = 0; // oletuksena ei perspektiivikorjausta

 // ladataan texturemapit:
 load_textmap(&scene, 0, "metal.pcx");
 load_textmap(&scene, 1, "s_ashsen.pcx");
 load_textmap(&scene, 2, "altaqua.pcx");

 // alustetaan objektien lataaja:
 obj_loader_init(&scene, 8); // laitetaan max 8:lle objektille tilaa

 // ladataan objektit:
 toorus_rykelma=
  new_obj(&scene, "3torus.asc", 0.5, 250.0, 0.0, 0.0,
          p_gouraudtexture + p_hfre, 1, 0, 0, 0);

 rocket_chase_mainos=
  new_obj(&scene, "arcee.asc", 0.4, 0.0, 0.0, -500.0,
          p_flat + p_hfre, 0, 0, 0, 255);

 iso_pallo=
  new_obj(&scene, "pallero.asc", 4.0, 0.2, 0.1, 0.1,
          p_texture, 1, 0, 0, 0);

 ar=
  new_obj(&scene, "ar2.asc", 0.4, -120.0 , 0.1, 0.1,
          p_envmap + p_hfre, 0, 0, 0, 0);

 toorus=  // ylempi torus on phongia,
  new_obj(&scene, "toorus.asc", 0.4, 0.0 , 0.0, 0.0,
          p_phong + p_hfre, 0, 255, 15, 15);

 toorus2= // alempi gouraudia. ero on n„kyv„.
  new_obj(&scene, "toorus.asc", 0.4, 0.0 , 100.0, 0.0,
           p_gouraud + p_hfre, 0, 255, 15, 15);

 // kaikki objektit on ladattu:
 all_objects_loaded(&scene);

 printf("press any key..");
 fflush(stdout);
 getch();

 // laitetaan graffatila p„„lle.
 setVESAmode(gfx_mode);

// debug(&scene);

 // valmistellaan valo
 valo_set(&scene.valo, 0, 0, -1);

 // valmistellaan kamera:
 init_camera(&kamera, // mik„ kamera
             256.0, 159.0, 99.0, // perspektiivi, x ja y keskikohdat
             (float)VBECurrentMode.width / 320.0f,  // x_suhde
             (float)VBECurrentMode.height / 200.0f, // y_suhde
             0, VBECurrentMode.width,  // klippausrajat
             0, VBECurrentMode.height);
 // t„m„n "mahtavan" systeemin ansiosta voimme tukea mit„ tahansa
 // (24 bittist„) graffatilaa ilman sen suurempia muutoksia.

 while (readkey != 27)
 {
  right = down = forward = krx = kry = krz = 0;

  if (kbhit()) readkey = getch();
  switch (readkey)
   {
    case 'z':down += 14;break;
    case 'a':down -= 14;break;
    case 'c':kry -= 2 * mypi / 150;break;
    case 'x':kry += 2 * mypi / 150;break;
    case 'f':krx += 2 * mypi / 150;break;
    case 'r':krx -= 2 * mypi / 150;break;
    case 't':krz += 2 * mypi / 150;break;
    case 'y':krz -= 2 * mypi / 150;break;
    case 'q':right -= 10;break;
    case 'w':right += 10;break;
    case 'e':forward += 20;break;
    case 'd':forward -= 20;break;
    case '+':scene.perspektiivi_korjaus_paalla = 1;break;
    case '-':scene.perspektiivi_korjaus_paalla = 0;break;
    default:break;
   }
  if (readkey != 27) readkey = 0;

  // liikutetaan kameraa
  camera_liikuta(&kamera, krx, kry, krz, right, down, forward);

  // valmistellaan frame:
  prepare_frame(&scene);

  // pyoritellaan joitain objekteja:
  object_liikuta(&scene, toorus_rykelma, 0, 2 * mypi / 100, 0, 0, 0, 0);
  object_liikuta(&scene, rocket_chase_mainos, 2 * mypi / 150, 0, 0, 0, 0, 0);
  object_liikuta(&scene, ar, 0, 2 * mypi / 130, 2 * mypi / 150, 0, 0, 0);
  object_liikuta(&scene, toorus, 2 * mypi / 200, 2 * mypi / 200, 2 * mypi / 200, 0, 0, 0);
  object_liikuta(&scene, toorus2, 2 * mypi / 200, 2 * mypi / 200, 2 * mypi / 200, 0, 0, 0);

  // laitetaan kaikki objektit skeneen:
  putobject(&scene, toorus_rykelma, &kamera);
  putobject(&scene, rocket_chase_mainos, &kamera);
  putobject(&scene, iso_pallo, &kamera);
  putobject(&scene, ar, &kamera);
  putobject(&scene, toorus, &kamera);
  putobject(&scene, toorus2, &kamera);

  // render view
  draw(&scene, &kamera);

  // display output
  VESAflip(VESAvirscr);

  // clear virtual screen
  VESAclear(VESAvirscr);
 }

 textmode(0x3);
 VESAdeinitmode();

 // vapautetaan texturemapit:
 free_textmap(&scene, 0);
 free_textmap(&scene, 1);
 free_textmap(&scene, 2);

 // vapautetaan objektit
 dispose_object(&scene, ar);
 dispose_object(&scene, toorus);
 dispose_object(&scene, toorus2);
 dispose_object(&scene, iso_pallo);
 dispose_object(&scene, rocket_chase_mainos);
 dispose_object(&scene, toorus_rykelma);

 // vapautetaan objektistruktuurit
 free_object_structs(&scene);

 // printataan v„h„n ohjeita:
 printf("k„ytt”: esim1.exe [tila] \n\n");

 printf("tila   resoluutio\n");
 printf("0x10F  320x200\n");
 printf("0x112  640x480\n");
 printf("0x115  800x600\n");
 printf("0x118  1024x768\n");
 printf("0x11B  1280x1024\n");
 printf("\nesim1.exe 0x112\n");
 printf("ajaisi ohjelman 640x480 resoluutiossa.\n\n");
 printf("kuinka kameraa ohjataan:\n");
 printf(" a,z=yl”s, alas\n");
 printf(" x,c=py”rit„ vasemmalle, py”rit„ oikealle\n");
 printf(" r,f=py”rit„ yl”s, py”rit„ alas\n");
 printf(" t,y=kallista vasemmalle, kallista oikealle\n");
 printf(" q,w=vasemmalle, oikealle\n");
 printf(" e,d=eteen, taakse\n");
 printf(" +,-=perspektiivikorjaus p„„lle, pois\n");

 // ja lopetetaan
 exit(0);
}

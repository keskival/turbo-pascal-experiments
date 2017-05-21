/************************************************************************/
/* objects.h, objektink„sittely-tauhkat.                                */
/************************************************************************/

#ifndef _chem_objects_h
#define _chem_objects_h


/************************************************************************/
/* defines:                                                             */
/************************************************************************/
#define p_flat 0
#define p_gouraud 1
#define p_texture 2
#define p_texturegouraud 3
#define p_gouraudtexture 3
#define p_phong 4
#define p_envmap 5
// hidden face removal enabled:
#define p_hfre 16
// see bstructs.h and scene.h for more inphormatzion.


/************************************************************************/
/* vapauttaa objektille varatun muistin.                                */
/************************************************************************/
void dispose_object(scene_type *scene, int nro)
{
 if (scene->obut[nro].objekti.vertex != NULL)
   free(scene->obut[nro].objekti.vertex);

 if (scene->obut[nro].objekti.face != NULL)
   free(scene->obut[nro].objekti.face);

 if (scene->obut[nro].objekti.normal != NULL)
   free(scene->obut[nro].objekti.normal);

 if (scene->obut[nro].objekti.uv != NULL)
   free(scene->obut[nro].objekti.uv);

 memset(&scene->obut[nro].objekti, 0, sizeof(objtype));

 while ( (scene->total_objects > 0) &&
         (scene->obut[scene->total_objects - 1].objekti.vertex == NULL) )
   scene->total_objects--;
}


/************************************************************************/
/* alustaa objektien latausrutiinit ja varaa objektien struktuureille   */
/* tilaa.                                                               */
/************************************************************************/
void obj_loader_init(scene_type *scene, int max_objects)
{
 scene->total_objects = 0;
 scene->obut = (opjtaip *)malloc(max_objects * sizeof(opjtaip));
}


/************************************************************************/
/* vapauttaa objektien varaaman strukture-tilan.                        */
/************************************************************************/
void free_object_structs(scene_type *scene)
{
 if (scene->obut != NULL) free(scene->obut);
}


/************************************************************************/
/* t„t„ kutsutaan kun kaikki objektit on ladattu                        */
/************************************************************************/
void all_objects_loaded(scene_type *scene)
{
 int i;

 scene->vertices_in_scene = 0;
 scene->faces_in_scene = 0;
 for (i = 0; i < scene->total_objects; i++)
  {
   scene->vertices_in_scene += scene->obut[i].objekti.vertices;
   scene->faces_in_scene += scene->obut[i].objekti.faces;
  }

 // varataan skenelle sopiva m„„r„ tilaa rotatoiduille vertekseille:
 scene->rot = (vertextype *)malloc(scene->vertices_in_scene * sizeof(vertextype));
 scene->nor = (vertextype *)malloc(scene->vertices_in_scene * sizeof(vertextype));
}

/************************************************************************/
/* laskee objektille verteksinormaalit. t„rke„ funkkari.                */
/* IN: scene=scene, nro=objektin numero (handle)                        */
/************************************************************************/

/* 3dica 2.1 -tyyliin:
void calc_vertex_normals(scene_type *scene, unsigned int nro)
{
 int i, a, b;
 float len, ox, oy, oz, cx, cy, cz, cn;

 for (i = 0; i < scene->obut[nro].objekti.vertices; i++)
  {
   cx = cy = cz = cn = 0;

   for (a = 0; a < scene->obut[nro].objekti.faces; a++)
    if ( (scene->obut[nro].objekti.face[a].a == i) ||  // jos face k„ytt„„
         (scene->obut[nro].objekti.face[a].b == i) ||  // verteksi„
         (scene->obut[nro].objekti.face[a].c == i) )
     {
      calcnormal(scene->obut[nro].objekti.vertex[scene->obut[nro].objekti.face[a].a].x,
                 scene->obut[nro].objekti.vertex[scene->obut[nro].objekti.face[a].a].y,
                 scene->obut[nro].objekti.vertex[scene->obut[nro].objekti.face[a].a].z,
                 scene->obut[nro].objekti.vertex[scene->obut[nro].objekti.face[a].b].x,
                 scene->obut[nro].objekti.vertex[scene->obut[nro].objekti.face[a].b].y,
                 scene->obut[nro].objekti.vertex[scene->obut[nro].objekti.face[a].b].z,
                 scene->obut[nro].objekti.vertex[scene->obut[nro].objekti.face[a].c].x,
                 scene->obut[nro].objekti.vertex[scene->obut[nro].objekti.face[a].c].y,
                 scene->obut[nro].objekti.vertex[scene->obut[nro].objekti.face[a].c].z,
                 &ox, &oy, &oz); //lasketaan facelle normaali

      len=sqrt(ox * ox + oy * oy + oz * oz); // pit„„ normalisoida jo t„ss„ ettei tule
      if (len == 0.0) len = -1.0;          // eri tavalla painottuneita facenormaaleita
                                         // verteksinormaaliin
      cx += ox / len; //lis„t„„n facenormaali normalisoituna
      cy += oy / len; //verteksille laskettavaan normaaliin
      cz += oz / len;
      cn += 1.0;
     }

   if (cn > 0) // jos joku face on k„ytt„nyt t„t„ verteksi„
    {
     // keskiarvoa on turha laskea, vektori kuitenkin normalisoidaan
     // jolloin pituudeksi tulee joka tapauksessa 1.
     len = sqrt(cx * cx + cy * cy + cz * cz); // lasketaan pituus
     if (len == 0.0) len = -1.0;
     scene->obut[nro].objekti.normal[i].x = (cx / len); // ja normalisoidaan
     scene->obut[nro].objekti.normal[i].y = (cy / len);
     scene->obut[nro].objekti.normal[i].z = (cz / len);

     scene->obut[nro].objekti.uv[i].u = (cx / len);
     scene->obut[nro].objekti.uv[i].v = (cy / len);
    } else  // jaahas, kukaan ei t„t„ verteksi„ k„yt„
     { // laitetaan vaan "tyhj„t" vektorit
      scene->obut[nro].objekti.normal[i].x = 0;
      scene->obut[nro].objekti.normal[i].y = 0;
      scene->obut[nro].objekti.normal[i].z = 0;

      scene->obut[nro].objekti.uv[i].u = 0;
      scene->obut[nro].objekti.uv[i].v = 0;
     }

  }
}
*/

// t„m„ tuottaa saman tuloksen kuin yll„oleva, mutta koodi
// on hieman erilainen:
// 1. nollaa kaikki verteksinormaalit
// 2. laske jokaiselle facelle normaali ja lis„„ se facen
//    jokaiseen verteksiin
// 3. normalisoi kaikki verteksinormaalit
void calc_object_data(scene_type *scene, unsigned int nro)
{
 int a, faceA, faceB, faceC;
 float len, ox, oy, oz;

 for (a = 0; a < scene->obut[nro].objekti.vertices; a++)
  {
    scene->obut[nro].objekti.normal[a].x = 0;
    scene->obut[nro].objekti.normal[a].y = 0;
    scene->obut[nro].objekti.normal[a].z = 0;
    scene->obut[nro].objekti.uv[a].u = 0;
    scene->obut[nro].objekti.uv[a].v = 0;
  }

 for (a = 0; a < scene->obut[nro].objekti.faces; a++)
  {
   faceA = scene->obut[nro].objekti.face[a].a; // vertex 1 of face
   faceB = scene->obut[nro].objekti.face[a].b; // vertex 2 of face
   faceC = scene->obut[nro].objekti.face[a].c; // vertex 3 of face

   calcnormal(scene->obut[nro].objekti.vertex[faceA].x,
              scene->obut[nro].objekti.vertex[faceA].y,
              scene->obut[nro].objekti.vertex[faceA].z,
              scene->obut[nro].objekti.vertex[faceB].x,
              scene->obut[nro].objekti.vertex[faceB].y,
              scene->obut[nro].objekti.vertex[faceB].z,
              scene->obut[nro].objekti.vertex[faceC].x,
              scene->obut[nro].objekti.vertex[faceC].y,
              scene->obut[nro].objekti.vertex[faceC].z,
              &ox, &oy, &oz); //lasketaan facelle normaali

   len=sqrt(ox * ox + oy * oy + oz * oz); // pit„„ normalisoida jo t„ss„ ettei tule
   if (len == 0.0) len = -1.0;          // eri tavalla painottuneita facenormaaleita
                                      // verteksinormaaliin
   ox /= len;
   oy /= len;
   oz /= len;

   //lis„t„„n facenormaali normalisoituna
   //verteksille laskettavaan normaaliin
   scene->obut[nro].objekti.normal[faceA].x += ox;
   scene->obut[nro].objekti.normal[faceA].y += oy;
   scene->obut[nro].objekti.normal[faceA].z += oz;

   scene->obut[nro].objekti.normal[faceB].x += ox;
   scene->obut[nro].objekti.normal[faceB].y += oy;
   scene->obut[nro].objekti.normal[faceB].z += oz;

   scene->obut[nro].objekti.normal[faceC].x += ox;
   scene->obut[nro].objekti.normal[faceC].y += oy;
   scene->obut[nro].objekti.normal[faceC].z += oz;
  }

 for (a = 0; a < scene->obut[nro].objekti.vertices; a++)
  {
    len = sqrt(pow(scene->obut[nro].objekti.normal[a].x,2) +
               pow(scene->obut[nro].objekti.normal[a].y,2) +
               pow(scene->obut[nro].objekti.normal[a].z,2));

    if (len == 0.0) len = -1.0;

    scene->obut[nro].objekti.normal[a].x /= len;
    scene->obut[nro].objekti.normal[a].y /= len;
    scene->obut[nro].objekti.normal[a].z /= len;

    scene->obut[nro].objekti.uv[a].u =
     scene->obut[nro].objekti.normal[a].x;
    scene->obut[nro].objekti.uv[a].v =
     scene->obut[nro].objekti.normal[a].y;
   }

}

/************************************************************************/
/* asettaa objektin kaikkien facejen liput.                             */
/************************************************************************/
void set_flags(objtype *obu, unsigned int flgs, unsigned char textnro,
               unsigned char r, unsigned char g, unsigned char b)
{
 int a;

 switch (flgs & 15)
 {
  case p_gouraud:
  case p_flat:
  case p_phong:
   flgs += (r << 8) + (g << 16) + (b << 24); // flat or gouraud, save rgb
   break;

  case p_texture:
  case p_texturegouraud:
  case p_envmap:
   flgs += ( (int)textnro << 8 ); // texture, save texturenro
   break;

  default:
   break;
 }

 for (a = 0; a < obu->faces; a++)
  {
   obu->face[a].flags = flgs;
  }
}


/************************************************************************/
/* lataa 3D Studion .ASC-filen ja ottaa sen ohjelman k„ytt””n.          */
/************************************************************************/
/* IN:                                                                  */
/*  scene=mihin sceneen objekti ladataan                                */
/*  filename=ladattan ASC:n filename                                    */
/*  mul=objektin kokokerroin. esim 0.5 puolittaa objektin koon jne.     */
/*  (xpos,ypos,zpos)=objektin origo                                     */
/*  flags=objektin facejen attribuutit                                  */
/*  textnro: jos texturemappaus, niin mit„ texturea k„ytet„„n.          */
/*  r,g,b: jos ei tm, niin mik„ on objektin v„ri                        */
/* OUT:                                                                 */
/*  -1  error                                                           */
/*  >=0 a handle for the object                                         */
/************************************************************************/
signed int new_obj(scene_type *scene, char *filename,float mul,
                   float xpos, float ypos, float zpos,
                   unsigned int flags, unsigned char textnro,
                   unsigned char r, unsigned char g, unsigned char b)
{
 if (lataa_asc(filename, &scene->obut[scene->total_objects].objekti, mul) != 0)
  {
   dispose_object(scene, scene->total_objects);
   return -1;
  }

 calc_object_data(scene, scene->total_objects);
 set_flags(&scene->obut[scene->total_objects].objekti, flags, textnro, r, g, b);

 scene->obut[scene->total_objects].xpos = xpos;
 scene->obut[scene->total_objects].ypos = ypos;
 scene->obut[scene->total_objects].zpos = zpos;
 teetyhjamatriisi(scene->obut[scene->total_objects].obj_matrix);

 scene->total_objects++;
 return (scene->total_objects - 1);
} /* returns a handle */


/************************************************************************/
/* liikuttaa objektia:                                                  */
/************************************************************************/
void object_liikuta(scene_type *scene, unsigned int nro,
                    float xa, float ya, float za,
                    float s_rt, float s_dn, float s_fw)
{
  matriisi chg;
  teepyoritysmatriisi(chg,         // prepare rotation matrix
                      sin(xa), sin(ya), sin(za),
                      cos(xa), cos(ya), cos(za));

  matriisi_kerro(scene->obut[nro].obj_matrix, chg); // rotate object

  // move object:
  scene->obut[nro].xpos +=
   s_rt * scene->obut[nro].obj_matrix[0][0]+
   s_dn * scene->obut[nro].obj_matrix[0][1]+
   s_fw * scene->obut[nro].obj_matrix[0][2];

  scene->obut[nro].ypos +=
   s_rt * scene->obut[nro].obj_matrix[1][0]+
   s_dn * scene->obut[nro].obj_matrix[1][1]+
   s_fw * scene->obut[nro].obj_matrix[1][2];

  scene->obut[nro].zpos +=
   s_rt * scene->obut[nro].obj_matrix[2][0]+
   s_dn * scene->obut[nro].obj_matrix[2][1]+
   s_fw * scene->obut[nro].obj_matrix[2][2];
}


/************************************************************************/
/* lis„t„„n objekti piirrett„v„ksi.                                     */
/************************************************************************/
void putobject(scene_type *scene, unsigned int nro, kamera_type *kamera)
{
 matriisi emat, nmat;

 int i;
 float zed;

 teetyhjamatriisi(emat);          // prepare eye space matrix
 teetyhjamatriisi(nmat);          // prepare matrix for normals

 // kerrotaan objektimatriisilla, jossa on objektin asento:
 matriisi_kerro(emat, scene->obut[nro].obj_matrix);

 matriisi_kerro(nmat, emat);           // ei kameran vaikutusta
 matriisi_kerro(emat, kamera->kam);    // camera

 // laitetaan objektin origo origin-verteksiin kameran vaikutuksella
 // h”ystettyn„
 scene->obut[nro].origin.x = scene->obut[nro].xpos - kamera->xpos;
 scene->obut[nro].origin.y = scene->obut[nro].ypos - kamera->ypos;
 scene->obut[nro].origin.z = scene->obut[nro].zpos - kamera->zpos;

 // liikuta objektia (tai l„hinn„ sen keskipistett„) kameran mukaan:
 vektori_kertaa_matriisi(scene->obut[nro].origin, &scene->obut[nro].origin, kamera->kam);

 scene->obut[nro].hidden = 0;

 for (i = 0; i < scene->obut[nro].objekti.vertices; i++)
  {
   // py”ritet„„n verteksi„
   vektori_kertaa_matriisi(scene->obut[nro].objekti.vertex[i], &scene->rot[i + scene->total_rot_vertices], emat);

   // liikutetaan
   scene->rot[i + scene->total_rot_vertices].x += scene->obut[nro].origin.x;
   scene->rot[i + scene->total_rot_vertices].y += scene->obut[nro].origin.y;
   scene->rot[i + scene->total_rot_vertices].z += scene->obut[nro].origin.z;

   // py”ritet„„n verteksinormaalia:
   vektori_kertaa_matriisi(scene->obut[nro].objekti.normal[i], &scene->nor[i + scene->total_rot_vertices], nmat);
   // mik„ on sik„li turhaa ett„ riitt„isi kun
   // valoa py”ritt„isi toiseen suuntaan

   zed = scene->rot[i + scene->total_rot_vertices].z;
   if (zed == 0.0) zed = -1.0; // emme halua jakaa nollalla

   zed = kamera->perspective / zed;

   // noniin ilkka, kelpaako..
   scene->rot[i + scene->total_rot_vertices].x *= zed;
   scene->rot[i + scene->total_rot_vertices].x += kamera->center_x;
   scene->rot[i + scene->total_rot_vertices].x *= kamera->x_suhde;

   // ..t„m„ perspektiivi-malli?-)
   scene->rot[i + scene->total_rot_vertices].y *= zed;
   scene->rot[i + scene->total_rot_vertices].y += kamera->center_y;
   scene->rot[i + scene->total_rot_vertices].y *= kamera->y_suhde;

/* 3dica:
      X_SCREEN = X0 * PERSPECTIVE / Z0
      Y_SCREEN = Y0 * PERSPECTIVE / Z0

 t„ss„ on k„ytetty perspektiivikorjatusta texturemappauksesta tuttua
 temppua a/b=a*(1/b) ja lis„ksi yhdistetty perspective tuohon, eli

      temp = PERSPECTIVE / Z0
      X_SCREEN = X0 * temp
      Y_SCREEN = Y0 * temp

 kannattaa, koska jakolasku vie penalla about 40 tikki„, kertolasku
 noin 3. (teoriassa, reaaliluvuilla)
*/
  }

 scene->obut[nro].vertex_index = scene->total_rot_vertices;
 scene->total_rot_vertices += scene->obut[nro].objekti.vertices;
}

#endif

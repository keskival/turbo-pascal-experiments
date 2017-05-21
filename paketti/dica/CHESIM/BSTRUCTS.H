/************************************************************************/
/* bstructs.h, basic structures.                                        */
/************************************************************************/

#ifndef _chem_bstructs_h
#define _chem_bstructs_h


/************************************************************************/
/* defines                                                              */
/************************************************************************/
#define maxtextures 8


/************************************************************************/
/* vertextype, verteksin x, y ja z -koordinaatit.                       */
/************************************************************************/
typedef struct
{
 float x, y, z;
} vertextype;


/************************************************************************/
/* matriisi, matriisin tyyppi. k„yt„mme 3x3 matriiseja.                 */
/************************************************************************/
typedef float matriisi[3][3];


/************************************************************************/
/* uv_type, verteksin u ja v -koordinaatit (texturelle).                */
/************************************************************************/
typedef struct
{
 float u, v; // texture u, texture v
} uv_type;


/************************************************************************/
/* facetype, facen k„ytt„m„t verteksit (a,b ja c) ja flags, facen       */
/* k„ytt„m„ pinnoitusmenetelm„ plus muut attribuutit.                   */
/************************************************************************/
typedef struct
{
 int a, b, c;
 unsigned int flags;
} facetype;

/************************************************************************/
/* flags:                                                               */
/*  bitit 0-3: (eli 4-bittinen numero)                                  */
/*   switch (flags&15) {                                                */
/*    case 0:flat                                                       */
/*    case 1:gouraud                                                    */
/*    case 2:texture                                                    */
/*    case 3:gouraud+texture                                            */
/*    case 4:phong                                                      */
/*    case 5:envmap                                                     */
/*    default:reserved for future expansions                            */
/*   }                                                                  */
/*  bitit 4-7:                                                          */
/*   bitti 4 p„„ll„: hidden face removal enabled                        */
/*  bitit 8-31:                                                         */
/*    flat: polygonin v„ri, 8-bittiset r,g ja b.                        */
/*    gouraud: polygonin v„ri, 8-bittiset r,g ja b.                     */
/*    texture: mit„ texturea k„ytet„„n                                  */
/************************************************************************/


/************************************************************************/
/* valon tyyppim„„rittely.                                              */
/************************************************************************/
/* paremmat valot tulevat hamassa tulevaisuudessa.                      */
/************************************************************************/
typedef struct
{
 vertextype direction; // suuntavektori
} valo_type;


/************************************************************************/
/* kuvan tyyppim„„rittely.                                              */
/************************************************************************/
typedef struct
{
 char *filename;
 unsigned char *palette;
 unsigned char *data;
 unsigned short xkoko, ykoko;
} kuva;


/************************************************************************/
/* z-sortin k„ytt””n.                                                   */
/************************************************************************/
typedef struct
{
 int order, face; // mik„ face piirret„„n
 unsigned short object; // mille objektille face kuuluu
} order_struct; // piirtoj„rjestys


/************************************************************************/
/* kameran tyyppim„„rittely.                                            */
/************************************************************************/
typedef struct
{
 float xpos, ypos, zpos, perspective, center_x, center_y, x_suhde, y_suhde;
 int screen_left,screen_right,screen_up,screen_down;
 matriisi kam;
} kamera_type;


/************************************************************************/
/* objektin perusta, verteksit, normaalit, facet, texturekoordinaatit,  */
/* tiedot verteksien ja facejen lukum„„r„st„.                           */
/************************************************************************/
typedef struct
{
 vertextype *vertex;
 vertextype *normal;
 uv_type *uv;
 facetype *face;
 unsigned int vertices, faces;
} objtype;


/************************************************************************/
/* objektin "linkki" muuhun engineen.                                   */
/************************************************************************/
typedef struct
{
 objtype objekti; /* vertices, faces, normals */
 unsigned int vertex_index; /* index to rot */
 unsigned int face_index; /* index to order */
 float xpos, ypos, zpos; /* object's position */
 matriisi obj_matrix;
 vertextype origin; /* object's position presented as a vertex */
 int hidden; // 1 yes, 0 no
} opjtaip;


/************************************************************************/
/* scenen p„„osaset.                                                    */
/************************************************************************/
typedef struct
{
 opjtaip *obut;   // objektit
 valo_type valo;  // valo
 vertextype *rot; // rotatoidut verteksit
 vertextype *nor; // rotatoidut normaalit (turha)
 unsigned int total_objects;      // objektien m„„r„
 unsigned int faces_in_scene;     // facejen m„„r„
 unsigned int vertices_in_scene;  // verteksien m„„r„
 kuva textm[maxtextures];         // texturemapit
 int perspektiivi_korjaus_paalla;

 unsigned int total_rot_vertices; // enginen sis„ll„
 unsigned int total_faces;        // enginen sis„ll„
} scene_type;

#endif

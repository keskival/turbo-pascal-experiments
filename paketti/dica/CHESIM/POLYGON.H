/************************************************************************/
/* polygon.h, VESA polygoni-rutiinit. Copyright (c) Chem/Hubris.        */
/************************************************************************/
/* Kommentit l”ytyv„t 3dicasta.                                         */
/************************************************************************/

#ifndef _chem_polygon_h
#define _chem_polygon_h

/************************************************************************/
/* klippausrajat. n„it„ voipi surutta muutella.                         */
/************************************************************************/
/* huom. scene-r”ytinet muuttavat n„it„ automaagisesti kameran mukaan.  */
/************************************************************************/
int c_left = 0;
int c_right = 319;
int c_up = 0;
int c_down = 199;


/************************************************************************/
/* pol_vertex_type, sy”testruktuuri polygonirutiineille.                */
/************************************************************************/
/* hlineillekin kannattaisi olla vastaava.                              */
/************************************************************************/
typedef struct
{
 int x, y, z, u, v, c, r, g, b;  // r,g,b=c(olor)
 float nx, ny, nz; // normal x, normal y, normal z
} pol_vertex_type;

/************************************************************************/
/* yleiset apulaiset.                                                   */
/************************************************************************/

inline void xchg(int *o1, int *o2) // vaihtaa kahden intin arvot kesken„„n
{
 int o3 = *o1;
 *o1 = *o2;
 *o2 = o3;
}

inline void fxchg(float *o1, float *o2) // guess.
{
 float o3 = *o1;
 *o1 = *o2;
 *o2 = o3;
}


/************************************************************************/
/* flat polygon -rutiini.                                               */
/************************************************************************/
/* ykk”sverteksin v„ri (ver1.c) m„„r„„ polygonin v„rin.                 */
/* vaaditut verteksiparametrit: x,y,c, c vain ekassa verteksiss„        */
/************************************************************************/

inline void hline(int x1, int x2, int y, unsigned char r, unsigned char g,
                  unsigned char b)
{
 int lx;

 if (x1 == x2) return;
 if (x1 > x2) xchg(&x1, &x2);

 if ( (x1 > c_right) || (x2 < c_left) ) return;
 if (x2 > c_right) x2 = c_right;
 if (x1 < c_left) x1 = c_left;

 for (lx = (x1 * VBECurrentMode.bytesperpixel + y * VBECurrentMode.bytesperline);
      lx < (x2 * VBECurrentMode.bytesperpixel + y * VBECurrentMode.bytesperline);
      lx += VBECurrentMode.bytesperpixel)
  {
   VESAvirscr[lx + 0] = b;
   VESAvirscr[lx + 1] = g;
   VESAvirscr[lx + 2] = r;
  }
}

/************************************************************************/
/*                   v1                                                 */
/*                  /|                                                  */
/*           re2.1/  |   <-yl„osa                                       */
/*              /     |                                                 */
/*         v2 /_______|     <- huom                                     */
/*            \        |re1                                             */
/*              \      |                                                */
/*                \     |  <-alaosa                                     */
/*             re2.2\   |                                               */
/*                    \  |                                              */
/*                      \|                                              */
/*                       v3                                             */
/************************************************************************/

void kol(pol_vertex_type *v1, pol_vertex_type *v2,
         pol_vertex_type *v3)
{
 int ly, dx1, dx2, ix1, ix2, r = v1->r, g = v1->g, b = v1->b;
 pol_vertex_type *v4;

 if (v2->y > v3->y) {v4 = v2; v2 = v3; v3 = v4;}
 if (v1->y > v3->y) {v4 = v1; v1 = v3; v3 = v4;}
 if (v1->y > v2->y) {v4 = v1; v1 = v2; v2 = v4;}
 if (v3->y == v1->y) return;

 ix1 = (v3->x - v1->x) * 65536 / (v3->y - v1->y);

 if (v2->y != v1->y) {
  ix2 = (v2->x - v1->x) * 65536 / (v2->y - v1->y);

  dx1 = v1->x * 65536;
  dx2 = v1->x * 65536;

  for (ly = v1->y; ly < v2->y; ly++)
   {
    if ( (ly >= c_up) && (ly <= c_down) )
     hline(dx1 / 65536, dx2 / 65536, ly, r, g, b);
    dx1 += ix1;
    dx2 += ix2;
   }
 }


 if (v3->y != v2->y) {
  ix2 = (v3->x - v2->x) * 65536 / (v3->y - v2->y);

  dx1 = v1->x * 65536 + ((v2->y - v1->y) * ix1);
  dx2 = v2->x * 65536;

  for (ly = v2->y; ly <= v3->y; ly++)
   {
    if ( (ly >= c_up) && (ly <= c_down))
     hline(dx1 / 65536, dx2 / 65536, ly, r, g ,b);
    dx1 += ix1;
    dx2 += ix2;
   }
 }
}


/************************************************************************/
/* gouraud polygon-rutiini.                                             */
/************************************************************************/
/* vaaditut verteksiparametrit: x,y,c                                   */
/************************************************************************/

inline void ghline(int x1, int x2, int y, int c1, int c2,
                   int r, int g, int b)
{
 int lx, sc;

 if (x1 == x2) return;
 if (x1 > x2) { xchg(&c1, &c2); xchg(&x1, &x2); }

 sc = (c2 - c1) / (x2 - x1); // lasketaan delta. t„m„ olisi vakio
                             // koko kolmion ajan. lue 3dica osa 3.2
                             // (gouraud kolmio)

 if ( (x1 > c_right) || (x2 < c_left) ) return;
 if (x2 > c_right) x2 = c_right;
 if (x1 < c_left) {
  c1 += (c_left - x1) * sc; // hyp„t„„n yli my”s v„riarvossa vasemman
  x1 = c_left;              // reunan vasemmalle puolelle j„„neet pikselit.
 }

 for (lx = (x1 * VBECurrentMode.bytesperpixel + y * VBECurrentMode.bytesperline);
      lx < (x2 * VBECurrentMode.bytesperpixel + y * VBECurrentMode.bytesperline);
      lx += VBECurrentMode.bytesperpixel)
  {
   VESAvirscr[lx + 0] = ((c1 * b) >> 24);
   VESAvirscr[lx + 1] = ((c1 * g) >> 24);
   VESAvirscr[lx + 2] = ((c1 * r) >> 24);
   c1 += sc; // interpoloidaan
  }

}

void gkol(pol_vertex_type *v1, pol_vertex_type *v2,
          pol_vertex_type *v3)
{
 int ly, dx1, dx2, ix1, ix2, ic1, ic2, cc1, cc2,
     r = v1->r, g = v1->g, b = v1->b;
 pol_vertex_type *v4;

 if (v2->y > v3->y) {v4 = v2; v2 = v3; v3 = v4;}
 if (v1->y > v3->y) {v4 = v1; v1 = v3; v3 = v4;}
 if (v1->y > v2->y) {v4 = v1; v1 = v2; v2 = v4;}
 if (v3->y == v1->y) return; /* "zero" height, emme piirr„ mit„„n. */

 ix1 = (v3->x - v1->x) * 65536 / (v3->y - v1->y);
 ic1 = (v3->c - v1->c) * 65536 / (v3->y - v1->y);

 if (v2->y != v1->y) {
  ix2 = (v2->x - v1->x) * 65536 / (v2->y - v1->y);
  ic2 = (v2->c - v1->c) * 65536 / (v2->y - v1->y);

  dx1 = v1->x * 65536;
  dx2 = v1->x * 65536;

  cc1 = v1->c * 65536;
  cc2 = v1->c * 65536;

  for (ly = v1->y; ly < v2->y; ly++)
   {
    if ( (ly >= c_up) && (ly <= c_down) ) //klipklip
     ghline(dx1 / 65536, dx2 / 65536, ly, cc1, cc2, r, g, b);
    dx1 += ix1;
    dx2 += ix2;
    cc1 += ic1;
    cc2 += ic2;
   }
 } /* end of if (y2!=y1) */

 if (v3->y != v2->y) {
  ix2 = (v3->x - v2->x) * 65536 / (v3->y - v2->y);
  ic2 = (v3->c - v2->c) * 65536 / (v3->y - v2->y);

  dx1 = v1->x * 65536 + ((v2->y - v1->y) * ix1); // lis„t„„n kolmion yl„osan osuus
  dx2 = v2->x * 65536;

  cc1 = v1->c * 65536 + ((v2->y - v1->y) * ic1);
  cc2 = v2->c * 65536;

  for (ly = v2->y; ly <= v3->y; ly++)
   {
    if ( (ly >= c_up) && (ly <= c_down) )
     ghline(dx1 / 65536, dx2 / 65536, ly, cc1, cc2, r, g, b);

    dx1 += ix1;
    dx2 += ix2;

    cc1 += ic1;
    cc2 += ic2;
   }
 }
}


/************************************************************************/
/* linear texture polygon -rutiini.                                     */
/************************************************************************/
/* vaaditut verteksiparametrit: x,y,u,v                                 */
/************************************************************************/

inline void thline(int x1, int x2, int y, int tx1, int tx2, int ty1,
                   int ty2, unsigned char *from, char *palette)
{
 int itx, ity, lx, pix;

 if (x1 == x2) return;
// if (x1 > x2){ xchg(&x1, &x2); xchg(&tx1, &tx2); xchg(&ty1, &ty2);}
 if ( (x1 > c_right) || (x2 < c_left) ) return;

 itx = (tx2 - tx1) / (x2 - x1); // tx on valmiiksi 65536-kertainen,
 ity = (ty2 - ty1) / (x2 - x1); // joten kertolaskua ei tarvita

 if (x2 > c_right) x2 = c_right;
 if (x1 < c_left) {
  tx1 += itx * (c_left - x1);
  ty1 += ity * (c_left - x1);
  x1 = c_left;
 }

 for (lx = (x1 * VBECurrentMode.bytesperpixel + y * VBECurrentMode.bytesperline);
      lx < (x2 * VBECurrentMode.bytesperpixel + y * VBECurrentMode.bytesperline);
      lx += VBECurrentMode.bytesperpixel)
 {
  pix = (unsigned int) from[ (tx1 >> 16) + ( (ty1 >> 8) & 0xFF00) ];

  VESAvirscr[lx + 0] = palette[pix * 3 + 2];
  VESAvirscr[lx + 1] = palette[pix * 3 + 1];
  VESAvirscr[lx + 2] = palette[pix * 3 + 0];

  tx1 += itx;
  ty1 += ity;
 }
}


void ltkol(pol_vertex_type *v1, pol_vertex_type *v2,
           pol_vertex_type *v3, char *from,
           char *palette)
{
 int oikea, vasen, ly, ix[2], x[2], itx[2], ity[2], tx[2], ty[2];
 pol_vertex_type *v4;

 if (v2->y > v3->y) {v4 = v2; v2 = v3; v3 = v4;}
 if (v1->y > v3->y) {v4 = v1; v1 = v3; v3 = v4;}
 if (v1->y > v2->y) {v4 = v1; v1 = v2; v2 = v4;}
 if (v3->y == v1->y) return; /* "zero" height, emme piirr„ mit„„n. */

 ix[0]  = (v3->x - v1->x) * 65536 / (v3->y - v1->y);
 itx[0] = (v3->u - v1->u) * 65536 / (v3->y - v1->y);
 ity[0] = (v3->v - v1->v) * 65536 / (v3->y - v1->y);

 if (v2->y != v1->y) {
  ix[1]  = (v2->x - v1->x) * 65536 / (v2->y - v1->y);
  itx[1] = (v2->u - v1->u) * 65536 / (v2->y - v1->y);
  ity[1] = (v2->v - v1->v) * 65536 / (v2->y - v1->y);

  x[0] = v1->x * 65536;
  x[1] = v1->x * 65536;

  tx[0] = v1->u * 65536;
  tx[1] = v1->u * 65536;

  ty[0] = v1->v * 65536;
  ty[1] = v1->v * 65536;

  if (ix[0] >= ix[1])
  {
   vasen = 1;
   oikea = 0;
  }
   else
  {
   vasen = 0;
   oikea = 1;
  }

  for (ly = v1->y; ly < v2->y; ly++)
   {
    if ( (ly >= c_up) && (ly <= c_down) ) //klipklip
     thline(x[vasen] / 65536, x[oikea] / 65536, ly, tx[vasen], tx[oikea],
            ty[vasen], ty[oikea], from, palette);
    x[0] += ix[0];
    x[1] += ix[1];

    tx[0] += itx[0];
    tx[1] += itx[1];

    ty[0] += ity[0];
    ty[1] += ity[1];
   }
 }

 if (v3->y != v2->y) {
  ix[1]  = (v3->x - v2->x) * 65536 / (v3->y - v2->y);
  itx[1] = (v3->u - v2->u) * 65536 / (v3->y - v2->y);
  ity[1] = (v3->v - v2->v) * 65536 / (v3->y - v2->y);

  x[0] = v1->x * 65536 + ((v2->y - v1->y) * ix[0]);
  x[1] = v2->x * 65536;

  tx[0] = v1->u * 65536 + ((v2->y - v1->y) * itx[0]);
  tx[1] = v2->u * 65536;

  ty[0] = v1->v * 65536 + ((v2->y - v1->y) * ity[0]);
  ty[1] = v2->v * 65536;

  if (ix[0] <= ix[1])
  {
   vasen = 1;
   oikea = 0;
  }
   else
  {
   vasen = 0;
   oikea = 1;
  }

  for (ly = v2->y; ly <= v3->y; ly++)
   {
    if ( (ly >= c_up) && (ly <= c_down) ) //klipklip
     thline(x[vasen] / 65536, x[oikea] / 65536, ly, tx[vasen], tx[oikea],
            ty[vasen], ty[oikea], from, palette);

    x[0] += ix[0];
    x[1] += ix[1];

    tx[0] += itx[0];
    tx[1] += itx[1];

    ty[0] += ity[0];
    ty[1] += ity[1];
   }
 }
}


/************************************************************************/
/* perspektiivikorjattu texture polygon -rutiini.                       */
/************************************************************************/
/* korjaus joka pikselille, hilpe„n vauhdikasta.                        */
/* vaaditut verteksiparametrit: x,y,z,u,v                               */
/************************************************************************/

inline void pthline(int x1, int x2, float z1, float z2, int y, float tx1, float tx2,
                    float ty1, float ty2, unsigned char *from, char *palette)
{
 // inc texture z, one over z (1/z), u over z (u/z), v over z (v/z)
 // inc texture x, inc texture y, one over one over z (1/(1/z)):
 float itz, ooz, uoz, voz, itx, ity, ooooz;
 int lx, u, v, pix;

 if (x1 == x2) return; // emme piirr„ tynk„viivoja (vaikka se joskus voi
                       // aiheuttaa puuttuvia pisteit„)
 if (x1 > x2) {
   xchg(&x1, &x2);
   fxchg(&tx1, &tx2);
   fxchg(&ty1, &ty2);
   fxchg(&z1, &z2);
 }

 if ( (x1 > c_right) || (x2 < c_left) ) return;

 ooz = z1;
 uoz = tx1;
 voz = ty1;

 itx = (tx2 - uoz) / (x2-x1); // lasketaan adderit.
 ity = (ty2 - voz) / (x2-x1); // n„m„ olisivat vakioita koko
 itz = (z2 - ooz) / (x2-x1);  // polygonin ajan.

 if (x2 > c_right) x2 = c_right;
 if (x1 < c_left) {
  uoz += itx * (c_left - x1); // emme piirr„ ihan koko viivaa, joten
  voz += ity * (c_left - x1); // hypit„„n yli texturessakin
  ooz += itz * (c_left - x1);
  x1 = c_left;
 }

 for (lx = (x1 * VBECurrentMode.bytesperpixel + y * VBECurrentMode.bytesperline);
      lx < (x2 * VBECurrentMode.bytesperpixel + y * VBECurrentMode.bytesperline);
      lx += VBECurrentMode.bytesperpixel)
 {
  ooooz = 1.0f / ooz;
  u = uoz * ooooz; // u=(u/z)*(1/(1/z))=(u/z)/(1/z)=u
  v = voz * ooooz; // n„in saadaan uv-pari

  pix = (unsigned int) from[ u + v * 256 ];

  VESAvirscr[lx + 0] = palette[pix * 3 + 2];
  VESAvirscr[lx + 1] = palette[pix * 3 + 1];
  VESAvirscr[lx + 2] = palette[pix * 3 + 0];

  uoz += itx;
  voz += ity;
  ooz += itz;
 }

}

// ik„v„ typecastaus-sotku, mutta better safe than sorry, eli
// emme halua jakolaskuja tulkittavan kokonaislukuoperaatioiksi, vaan
// liukulukulaskuiksi.
void ptkol(pol_vertex_type *v1, pol_vertex_type *v2,
           pol_vertex_type *v3, char *from,
           char *palette)
{
 int ly, ix1, ix2, x1, x2;
 float z1, z2, iz1, iz2, itx1, itx2, ity1, ity2, tx1, tx2, ty1, ty2;
 pol_vertex_type *v4;

 if (v2->y > v3->y) {v4 = v2; v2 = v3; v3 = v4;}
 if (v1->y > v3->y) {v4 = v1; v1 = v3; v3 = v4;}
 if (v1->y > v2->y) {v4 = v1; v1 = v2; v2 = v4;}
 if (v3->y == v1->y) return; /* "zero" height, emme piirr„ mit„„n. */

 ix1 = (v3->x - v1->x) * 65536 / (v3->y - v1->y);

 iz1 = (float) ( (1.0f / v3->z) - (1.0f / v1->z) ) / (float) (v3->y - v1->y);

 // argh:
 itx1 = (float) ( ((float) v3->u / v3->z) - ((float) v1->u / v1->z) ) /
        (float) (v3->y - v1->y);

 ity1 = (float) ( ((float) v3->v / v3->z) - ((float) v1->v / v1->z) ) /
        (float) (v3->y - v1->y);

 if (v2->y != v1->y) {
  ix2 = (v2->x - v1->x) * 65536 / (v2->y - v1->y);

  iz2 = (float) ((1.0f / v2->z) - (1.0f / v1->z)) / (float) (v2->y - v1->y);
  itx2 = (float) ( ((float) v2->u / v2->z) - ((float) v1->u / v1->z)) /
         (float) (v2->y - v1->y);
  ity2 = (float) ( ((float) v2->v / v2->z) - ((float) v1->v / v1->z))/
         (float) (v2->y - v1->y);

  x1 = v1->x * 65536;
  x2 = v1->x * 65536;

  z1 = 1.0f / (float) v1->z;
  z2 = 1.0f / (float) v1->z;

  tx1 = (float) v1->u / (float) v1->z;
  tx2 = (float) v1->u / (float) v1->z;

  ty1 = (float) v1->v / (float) v1->z;
  ty2 = (float) v1->v / (float) v1->z;

  for (ly = v1->y; ly < v2->y; ly++)
   {
    if ( (ly >= c_up) && (ly <= c_down) ) //klipklip
     pthline(x1 / 65536, x2 / 65536, z1, z2, ly, tx1, tx2, ty1, ty2, from, palette);
    x1 += ix1;
    x2 += ix2;

    z1 += iz1;
    z2 += iz2;

    tx1 += itx1;
    tx2 += itx2;

    ty1 += ity1;
    ty2 += ity2;
   }
 }

 if (v3->y != v2->y) {
  ix2 = (v3->x - v2->x) * 65536 / (v3->y - v2->y);

  iz2 = (1.0f / v3->z - 1.0f / v2->z) / (float) (v3->y - v2->y);
  itx2 = ( (float) v3->u / v3->z - (float)v2->u / v2->z ) /
         (float) (v3->y - v2->y);
  ity2 = ( (float) v3->v / v3->z - (float)v2->v / v2->z ) /
         (float) (v3->y - v2->y);

  x1 = v1->x * 65536 + ((v2->y - v1->y) * ix1);
  x2 = v2->x * 65536;

  z1 = 1.0f / (float) v1->z + ((float) (v2->y - v1->y) * iz1);
  z2 = 1.0f / (float) v2->z;

  tx1 = (float) v1->u / (float) v1->z + ((float) (v2->y - v1->y) * itx1);
  tx2 = (float) v2->u / (float) v2->z;

  ty1 = (float) v1->v / (float) v1->z + ((float) (v2->y - v1->y) * ity1);
  ty2 = (float) v2->v / (float) v2->z;

  for (ly = v2->y; ly < v3->y; ly++)
   {
    if ( (ly >= c_up) && (ly <= c_down) ) //klipklip
     pthline(x1 / 65536, x2 / 65536, z1, z2, ly, tx1, tx2, ty1, ty2, from, palette);
    x1 += ix1;
    x2 += ix2;

    z1 += iz1;
    z2 += iz2;

    tx1 += itx1;
    tx2 += itx2;

    ty1 += ity1;
    ty2 += ity2;
   }
 }

}


/************************************************************************/
/* "aito" phong polygon -rutiini.                                       */
/************************************************************************/
/* vaaditut verteksiparametrit: x,y,nx,ny,nz ja rgb verteksille 1.      */
/************************************************************************/
/* T„ss„ Jukka Liimatan esitys aidosta phongista:                       */
/* valosta pintaan -vektori (xyz) ja deltat (xyz)  = 6 komponenttia     */
/* pinnan normaali - 6 komponenttia                                     */
/* kamerasta pintaan -vektori (6 komponenttia)                          */
/*                                                                      */
/* Voinemme luottaa h„nen tietojensa oikeellisuuteen :) Minun           */
/* k„sitt„„kseni noita olisi tarkoitus k„ytt„„ niin, ett„ laskettaisiin */
/* pinnan normaalin avulla valosta pintaan vektorista tulevan           */
/* 'valons„teen kimpoaminen' pinnasta, ja otettaisiin sitten            */
/* kameravektorin ja kyseisen 'kimmonneen' 's„teen' v„lisen kulman      */
/* kosini kirkkausarvoksi. T„m„ on tosin yet ankonf””rmd, mutta n„in..  */
/************************************************************************/
/* MUTU:                                                                */
/*                                                                      */
/*      valo norm kimmonnut valo                                        */
/*        \   |   /                                                     */
/*         \  |  /          ___--- kamera                               */
/*          \a|b/ c   ___---                                            */
/*           \|/___---                                                  */
/*       __-------__   <- pinta                                         */
/*                                                                      */
/* Noniin, eli t„ss„ valo tulee pintaan kulmassa a verrattuna pinnan    */
/* (huom, ei *polygonin* pinnan, vaan *OBJEKTIN* pinnan) normaaliin.    */
/* kimmonnut valo l„htee pinnasta kulmassa b normaaliin n„hden. HUOMAA, */
/* ett„ a==b. kulman c kosini on haluttu valoarvo. malliin voidaan      */
/* viel„ lis„t„ osa: "valovoimakkuus on k„„nt„en verrannollinen         */
/* et„isyyden neli””n", jos halutaan hienoja autonvalo tms efektej„.    */
/************************************************************************/
/* ..ainakin kuvittelisin. Olen hieman yksinkertaistanut hieman t„t„ ah */
/* niin kinkkist„ systeemi„ ja p„„tynyt seuraavaan tulokseen:           */
/*                                                                      */
/*  1. olettamme valon olevan „„rett”m„n kaukana. t„st„ seuraa, ett„    */
/*     valon asento ei muutu, joten valon interpolointi on turhaa.      */
/*  2. kamera j„tet„„n raa'asti pois, n„in olemme tehneet kaikissa      */
/*     muissakin varjostuksissamme. ero tuskin on suurensuuri ainakaan  */
/*     visuaalisen n„ytt„vyyden kannalta. korrektiudesta en sano mit„„n.*/
/*  3. vaikka emme teekk„„n t„t„ ihan rendaussoftana, niin t„t„ voi     */
/*     enemm„n tai v„hemm„n hyvill„ mielill„ kutsua phongiksi. esim     */
/*     surullisenkuuluisassa otmphongissa selostettu "oikea phong",     */
/*     joka on kuulemma aivan sairaan hidas (totta), on t„sm„lleen      */
/*     t„m„ (ks liite alempana :) the true demoscene way, fake where    */
/*     and whenever you can :)                                          */
/*                                                                      */
/* j„ljelle j„„ siis vain valovektorin interpolointi ja kirkkauden      */
/* etsiminen joka pikselille. enihau, nyt kun aito phongikin on         */
/* selostettu, olet aivan vapaa tekem„„n moisen itse. ei ole vaikeaa,   */
/* joskaa ei hy”dyllist„k„„n.                                           */
/************************************************************************/
/* p„tk„ otmphongista:                                                  */
/*                                                                      */
/*      1) determine a normal vector at each vertex of a polygon, the   */
/*         same normal vector used in gouraud shading.                  */
/*                                                                      */
/*      2) interpolate normal vectors along the edges of the polygon.   */
/*                                                                      */
/*      3) interpolate normal vectors across each scanline, so you have */
/*         one normal vector for each pixel in the polygon.             */
/*                                                                      */
/*      4) determine the color at each pixel using the dot product of   */
/*         the normal vector at that pixel and the light vector, the    */
/*         same method used in gouraud and lambert shading.  Since the  */
/*         interpolated normals are not of constant length, this step   */
/*         requires a square root to find the length of the normal.     */
/*                                                                      */
/************************************************************************/
/* The way this version of "real" phong works:                          */
/* Oletan t„ss„, ett„ olet jo tehnyt toimivan gouraud-sheidauksen.      */
/* Gouraudissahan otit valovektorin ja verteksinormaalin v„lisen kulman */
/* kosinin joka *verteksille* ja k„ytit sit„ kirkkausarvona             */
/* interpoloiden sit„ lineaarisesti polygonin pinnan yli. Noh, t„m„ ei  */
/* ole yht„„n monimutkaisempaa; v„riarvon sijasta interpoloimme         */
/* verteksin normaalivektoreita pinnan yli, normalisoimme ne, ja otamme */
/* interpoloidun ja normalisoidun vektorin ja valovektorin v„lisen      */
/* kulman kosinin ja k„yt„mme sit„ kirkkausarvona. N„in siis *JOKA*     */
/* *PIKSELILLE*. Piis of keik again, but slow „s hell. Mit„s t„m„       */
/* maksaakaan.. 10 kertolaskua, yksi neli”juuri ja yksi jakolasku (plus */
/* "pakolliset", joista niist„kin saisi pois) pikseli, ja paljon saisi  */
/* pois hyvin hyvin hyvin helposti. Eih„n tuo niin kamalaa ole :)       */
/* huomaa, ett„ t„m„ versio ei tuota n„kyv„„ highlaittia johtuen        */
/* lineaarisesta paletista ja siit„ johtuvien laskujen puuttumisesta.   */
/************************************************************************/


inline void phline(int x1, int x2, int y, float nx1, float ny1, float nz1,
                   float nx2, float ny2, float nz2, int r, int g, int b,
                   valo_type valo)
{
 int lx;
 float ix, iy, iz, len, col;

 if (x1 == x2) return;
 if (x1 > x2)
  {
   xchg(&x1, &x2);
   fxchg(&nx1, &nx2);
   fxchg(&ny1, &ny2);
   fxchg(&nz1, &nz2);
  }

 ix = (float) (nx2 - nx1) / (float) (x2 - x1);
 iy = (float) (ny2 - ny1) / (float) (x2 - x1);
 iz = (float) (nz2 - nz1) / (float) (x2 - x1);

 if ( (x1 > c_right) || (x2 < c_left) ) return;
 if (x2 > c_right) x2 = c_right;
 if (x1 < c_left) {
  nx1 += (c_left - x1) * ix;
  ny1 += (c_left - x1) * iy;
  nz1 += (c_left - x1) * iz;
  x1=c_left;
 }

 for (lx = (x1 * VBECurrentMode.bytesperpixel + y * VBECurrentMode.bytesperline);
      lx < (x2 * VBECurrentMode.bytesperpixel + y * VBECurrentMode.bytesperline);
      lx += VBECurrentMode.bytesperpixel)
  {
   len = sqrt(nx1 * nx1 + ny1 * ny1 + nz1 * nz1);
   col = (valo.direction.x * nx1 +       // lasketaan valovektorin
          valo.direction.y * ny1 +       // ja pintanormaalin v„lisen
          valo.direction.z * nz1) / len; // kulman kosini
   if (col < 0) col = 0; // ei negatiivisia kiitos

   VESAvirscr[lx+0] = col*b;
   VESAvirscr[lx+1] = col*g;
   VESAvirscr[lx+2] = col*r;

   nx1 += ix;
   ny1 += iy;
   nz1 += iz;
  }

}

void pkol(pol_vertex_type *v1, pol_vertex_type *v2,
          pol_vertex_type *v3, valo_type valo)
{
 int ly, dx1, dx2, ix1, ix2, r = v1->r, g = v1->g, b = v1->b;
 float inx1, iny1, inz1, inx2, iny2, inz2,
       nx1, ny1, nz1, nx2, ny2, nz2;
 pol_vertex_type *v4;

 if (v2->y > v3->y) {v4 = v2; v2 = v3; v3 = v4;}
 if (v1->y > v3->y) {v4 = v1; v1 = v3; v3 = v4;}
 if (v1->y > v2->y) {v4 = v1; v1 = v2; v2 = v4;}
 if (v3->y == v1->y) return; /* "zero" height, emme piirr„ mit„„n. */

 ix1 = (v3->x - v1->x) * 65536 / (v3->y - v1->y);

 inx1 = (float) (v3->nx - v1->nx) / (float) (v3->y - v1->y);
 iny1 = (float) (v3->ny - v1->ny) / (float) (v3->y - v1->y);
 inz1 = (float)( v3->nz - v1->nz) / (float) (v3->y - v1->y);

 if (v2->y != v1->y) {
  ix2 = (v2->x - v1->x) * 65536 / (v2->y - v1->y);

  inx2 = (float) (v2->nx - v1->nx) / (float) (v2->y - v1->y);
  iny2 = (float) (v2->ny - v1->ny) / (float) (v2->y - v1->y);
  inz2 = (float) (v2->nz - v1->nz) / (float) (v2->y - v1->y);

  dx1 = v1->x * 65536;
  dx2 = v1->x * 65536;

  nx1 = v1->nx;
  ny1 = v1->ny;
  nz1 = v1->nz;

  nx2 = v1->nx;
  ny2 = v1->ny;
  nz2 = v1->nz;

  for (ly = v1->y; ly < v2->y; ly++)
   {
    if ( (ly >= c_up) && (ly <= c_down) ) //klipklip
     phline(dx1 / 65536, dx2 / 65536, ly, nx1, ny1, nz1, nx2, ny2, nz2,
            r, g, b, valo);
    dx1 += ix1;
    dx2 += ix2;

    nx1 += inx1;
    ny1 += iny1;
    nz1 += inz1;

    nx2 += inx2;
    ny2 += iny2;
    nz2 += inz2;
   }
 } /* end of if (y2!=y1) */

 if (v3->y != v2->y) {
  ix2 = (v3->x - v2->x) * 65536 / (v3->y - v2->y);

  inx2 = (float) (v3->nx - v2->nx) / (float) (v3->y - v2->y);
  iny2 = (float) (v3->ny - v2->ny) / (float) (v3->y - v2->y);
  inz2 = (float) (v3->nz - v2->nz) / (float) (v3->y - v2->y);

  dx1 = v1->x * 65536 + ((v2->y - v1->y) * ix1);
  dx2 = v2->x * 65536;

  nx1 = v1->nx + ((v2->y - v1->y) * inx1);
  ny1 = v1->ny + ((v2->y - v1->y) * iny1);
  nz1 = v1->nz + ((v2->y - v1->y) * inz1);

  nx2 = v2->nx;
  ny2 = v2->ny;
  nz2 = v2->nz;

  for (ly = v2->y; ly <= v3->y; ly++)
   {
    if ( (ly >= c_up) && (ly <= c_down) )
     phline(dx1 / 65536, dx2 / 65536, ly, nx1, ny1, nz1, nx2, ny2, nz2,
            r, g, b, valo);

    dx1 += ix1;
    dx2 += ix2;

    nx1 += inx1;
    ny1 += iny1;
    nz1 += inz1;

    nx2 += inx2;
    ny2 += iny2;
    nz2 += inz2;
   }
 }
}

/************************************************************************/
/* linear gouraudtexture polygon -rutiini.                              */
/************************************************************************/
/* vaaditut verteksiparametrit: x,y,u,v,c                               */
/************************************************************************/

inline void gthline(int x1, int x2, int y, int tx1, int tx2, int ty1,
                   int ty2, int c1, int c2, unsigned char *from,
                   unsigned char *palette)
{
 int itx, ity, lx, pix, sc;

 if (x1 == x2) return;
 if (x1 > x2) {
  xchg(&x1, &x2);
  xchg(&tx1, &tx2);
  xchg(&ty1, &ty2);
  xchg(&c1, &c2);
 }
 if ( (x1 > c_right) || (x2 < c_left) ) return;

 itx = (tx2 - tx1) / (x2 - x1); // tx on valmiiksi 65536-kertainen,
 ity = (ty2 - ty1) / (x2 - x1); // joten kertolaskua ei tarvita
 sc = (c2 - c1) / (x2 - x1);

 if (x2 > c_right) x2 = c_right;
 if (x1 < c_left) {
  tx1 += itx * (c_left - x1);
  ty1 += ity * (c_left - x1);
  c1 += sc * (c_left - x1);
  x1 = c_left;
 }

 for (lx = (x1 * VBECurrentMode.bytesperpixel + y * VBECurrentMode.bytesperline);
      lx < (x2 * VBECurrentMode.bytesperpixel + y * VBECurrentMode.bytesperline);
      lx += VBECurrentMode.bytesperpixel)
 {
  pix = (unsigned int) from[ (tx1 >> 16) + ( (ty1 >> 8) & 0xFF00) ];

  VESAvirscr[lx + 0] = ((unsigned int)c1 * (unsigned int)palette[pix * 3 + 2]) >> 24;
  VESAvirscr[lx + 1] = ((unsigned int)c1 * (unsigned int)palette[pix * 3 + 1]) >> 24;
  VESAvirscr[lx + 2] = ((unsigned int)c1 * (unsigned int)palette[pix * 3 + 0]) >> 24;

  tx1 += itx;
  ty1 += ity;
  c1 += sc;
 }
}


void lgtkol(pol_vertex_type *v1, pol_vertex_type *v2,
           pol_vertex_type *v3, char *from,
           char *palette)
{
 int ly, ix1, ix2, x1, x2, itx1, itx2, ity1, ity2, tx1, tx2, ty1, ty2,
     cc1, cc2, ic1, ic2;
 pol_vertex_type *v4;

 if (v2->y > v3->y) {v4 = v2; v2 = v3; v3 = v4;}
 if (v1->y > v3->y) {v4 = v1; v1 = v3; v3 = v4;}
 if (v1->y > v2->y) {v4 = v1; v1 = v2; v2 = v4;}
 if (v3->y == v1->y) return; /* "zero" height, emme piirr„ mit„„n. */

 ix1 = (v3->x - v1->x) * 65536 / (v3->y - v1->y);
 ic1 = (v3->c - v1->c) * 65536 / (v3->y - v1->y);
 itx1 = (v3->u - v1->u) * 65536 / (v3->y - v1->y);
 ity1 = (v3->v - v1->v) * 65536 / (v3->y - v1->y);

 if (v2->y != v1->y) {
  ix2 = (v2->x - v1->x) * 65536 / (v2->y - v1->y);
  ic2 = (v2->c - v1->c) * 65536 / (v2->y - v1->y);

  itx2 = (v2->u - v1->u) * 65536 / (v2->y - v1->y);
  ity2 = (v2->v - v1->v) * 65536 / (v2->y - v1->y);

  x1 = v1->x * 65536;
  x2 = v1->x * 65536;

  cc1 = v1->c * 65536;
  cc2 = v1->c * 65536;

  tx1 = v1->u * 65536;
  tx2 = v1->u * 65536;

  ty1 = v1->v * 65536;
  ty2 = v1->v * 65536;

  for (ly = v1->y; ly < v2->y; ly++)
   {
    if ( (ly >= c_up) && (ly <= c_down) ) //klipklip
     gthline(x1 / 65536, x2 / 65536, ly, tx1, tx2, ty1, ty2, cc1, cc2, from, palette);
    x1 += ix1;
    x2 += ix2;

    cc1 += ic1;
    cc2 += ic2;

    tx1 += itx1;
    tx2 += itx2;

    ty1 += ity1;
    ty2 += ity2;
   }
 }

 if (v3->y != v2->y) {
  ix2 = (v3->x - v2->x) * 65536 / (v3->y - v2->y);
  ic2 = (v3->c - v2->c) * 65536 / (v3->y - v2->y);

  itx2 = (v3->u - v2->u) * 65536 / (v3->y - v2->y);
  ity2 = (v3->v - v2->v) * 65536 / (v3->y - v2->y);

  x1 = v1->x * 65536 + ((v2->y - v1->y) * ix1);
  x2 = v2->x * 65536;

  cc1 = v1->c * 65536 + ((v2->y - v1->y) * ic1);
  cc2 = v2->c * 65536;

  tx1 = v1->u * 65536 + ((v2->y - v1->y) * itx1);
  tx2 = v2->u * 65536;

  ty1 = v1->v * 65536 + ((v2->y - v1->y) * ity1);
  ty2 = v2->v * 65536;

  for (ly = v2->y; ly <= v3->y; ly++)
   {
    if ( (ly >= c_up) && (ly <= c_down) ) //klipklip
     gthline(x1 / 65536, x2 / 65536, ly, tx1, tx2, ty1, ty2, cc1, cc2, from, palette);
    x1 += ix1;
    x2 += ix2;

    cc1 += ic1;
    cc2 += ic2;

    tx1 += itx1;
    tx2 += itx2;

    ty1 += ity1;
    ty2 += ity2;
   }
 }
}


/************************************************************************/
/* luit t„nne asti? hullu mi„s.                                         */
/************************************************************************/
#endif

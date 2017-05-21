/************************************************************************/
/* polyg13h.h, polygonirutiini modeen 13h.                              */
/************************************************************************/
#ifndef _chem_polyg13h_h
#define _chem_polyg13h_h

typedef struct
{
 int x, y, z, c;  // r,g,b=c(olor)
} mcga_pol_vertex_type;

int c_left = 0;
int c_right = 319;
int c_up = 0;
int c_down = 199;

float zbuffer[320*200];

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
/* flat zbuffer polygon -rutiini.                                       */
/************************************************************************/
/* ykk”sverteksin v„ri (ver1.c) m„„r„„ polygonin v„rin.                 */
/* vaaditut verteksiparametrit: x,y,z,c                                 */
/************************************************************************/

inline void mcga_hline(int x1, int x2, float ooz1, float ooz2, int y, char c)
{
 int lx;
 float zi;

 if (x1 > x2) {xchg(&x1, &x2); fxchg(&ooz1, &ooz2);}

 if ( (x1 > c_right) || (x2 < c_left) ) return;
 if (x2 > c_right) x2 = c_right;
 if (x1 < c_left) x1 = c_left;
 if (x1 == x2) return;

 zi = (ooz2 - ooz1) / (float)(x2 - x1);

 for (lx = (x1 + y * 320); lx < (x2 +  y * 320); lx ++)
 {
  if (zbuffer[lx] < ooz1)
   {
    virt[lx] = c;
    zbuffer[lx] = ooz1;
   }
  ooz1 += zi;
 }
}

void mcga_kol(mcga_pol_vertex_type *v1, mcga_pol_vertex_type *v2,
         mcga_pol_vertex_type *v3)
{
 int ly, dx1, dx2, ix1, ix2, c = v1->c;
 float z1, z2, iz1, iz2;
 mcga_pol_vertex_type *v4;

 if (v2->y > v3->y) {v4 = v2; v2 = v3; v3 = v4;}
 if (v1->y > v3->y) {v4 = v1; v1 = v3; v3 = v4;}
 if (v1->y > v2->y) {v4 = v1; v1 = v2; v2 = v4;}
 if (v3->y == v1->y) return;

 ix1 = (v3->x - v1->x) * 65536 / (v3->y - v1->y);
 iz1 = (float) ( (1.0f / v3->z) - (1.0f / v1->z) ) / (float) (v3->y - v1->y);

 if (v2->y != v1->y) {
  ix2 = (v2->x - v1->x) * 65536 / (v2->y - v1->y);
  iz2 = (float) ((1.0f / v2->z) - (1.0f / v1->z)) / (float) (v2->y - v1->y);

  z1 = 1.0f / (float) v1->z;
  z2 = 1.0f / (float) v1->z;

  dx1 = v1->x * 65536;
  dx2 = v1->x * 65536;

  for (ly = v1->y; ly < v2->y; ly++)
   {
    if ( (ly >= c_up) && (ly <= c_down) )
     mcga_hline(dx1 / 65536, dx2 / 65536, z1, z2, ly, c);
    dx1 += ix1;
    dx2 += ix2;

    z1 += iz1;
    z2 += iz2;
   }
 }


 if (v3->y != v2->y) {
  ix2 = (v3->x - v2->x) * 65536 / (v3->y - v2->y);
  iz2 = (1.0f / v3->z - 1.0f / v2->z) / (float) (v3->y - v2->y);

  z1 = 1.0f / (float) v1->z + ((float) (v2->y - v1->y) * iz1);
  z2 = 1.0f / (float) v2->z;

  dx1 = v1->x * 65536 + ((v2->y - v1->y) * ix1);
  dx2 = v2->x * 65536;

  for (ly = v2->y; ly <= v3->y; ly++)
   {
    if ( (ly >= c_up) && (ly <= c_down))
     mcga_hline(dx1 / 65536, dx2 / 65536, z1, z2, ly, c);
    dx1 += ix1;
    dx2 += ix2;

    z1 += iz1;
    z2 += iz2;
   }
 }
}
#endif

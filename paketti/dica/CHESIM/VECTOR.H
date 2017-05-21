/************************************************************************/
/* vector.h, vektorin k„sittelyyn liittyv„„ kamaa                       */
/************************************************************************/

#ifndef _chem_vector_h
#define _chem_vector_h

/************************************************************************/
/* onko face n„kyv„?                                                    */
/************************************************************************/
inline signed int visable(int x1, int y1, int x2,
                          int y2, int x3, int y3)
{
 int rx1 = x3 - x1, ry1 = y3 - y1, rx2 = x3 - x2, ry2 = y3 - y2;
 return ( ( (ry2 - ry1) * rx1 - (rx2 - rx1) * ry1 ) <= 0 );
} /* ( 0 not visible, 1 visible ) OR ( 1 visible, 0 not visible ) */


/************************************************************************/
/* laskee facelle normaalin.                                            */
/************************************************************************/
void calcnormal(float x1, float y1, float z1, float x2, float y2,
                float z2, float x3, float y3, float z3,
                float *nx, float *ny, float *nz)
{
 float relx1 = x2 - x1, rely1 = y2 - y1, relz1 = z2 - z1,
       relx2 = x3 - x1, rely2 = y3 - y1, relz2 = z3 - z1;
 *nx = (rely1 * relz2 - relz1 * rely2);
 *ny = (relz1 * relx2 - relx1 * relz2);
 *nz = (relx1 * rely2 - rely1 * relx2);
}


#endif

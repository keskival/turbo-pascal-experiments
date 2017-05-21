/************************************************************************/
/* light.h, valohommat.                                                 */
/************************************************************************/

#ifndef _chem_light_h
#define _chem_light_h


/************************************************************************/
/* palauttaa valovektorin ja normaalin v„lisen kulman kosinin           */
/************************************************************************/
inline int light_intensity(vertextype vertexnormal, valo_type light, int scale)
{
 scale *= (light.direction.x * vertexnormal.x +  // valovektorin ja
           light.direction.y * vertexnormal.y +  // verteksinormaalin
           light.direction.z * vertexnormal.z);  // v„lisen kulman kosini
 if (scale < 1) scale = 1;
 return scale;
}

inline float get_flat_inten(pol_vertex_type v1, pol_vertex_type v2,
                            pol_vertex_type v3, valo_type light)
{
 float ox, oy, oz, len;

 calcnormal(v1.x, v1.y, v1.z, v2.x, v2.y, v2.z, v3.x, v3.y, v3.z, &ox, &oy, &oz);
 len = sqrt(ox * ox + oy * oy + oz * oz);
 if (len == 0.0) len = -0.1;
 ox = (light.direction.x * ox +
       light.direction.y * oy +
       light.direction.z * oz) / len;
 if (ox < 0) ox = 0;
 return ox;
}

/************************************************************************/
/* asettaa valovektorin tiettyyn arvoon ja normalisoi pituudeksi 1.     */
/************************************************************************/
void valo_set(valo_type *light, float x, float y, float z)
{
 float len = sqrt(x * x + y * y + z * z); // valovektorin pituus
 light->direction.x = x / len;    // normalisoidaan
 light->direction.y = y / len;    // pituudeksi
 light->direction.z = z / len;    // yksi
}


/************************************************************************/
/* py”ritt„„ valovektoria.                                              */
/************************************************************************/
void valo_pyorita(valo_type *light, float xa, float ya, float za)
{
 matriisi rota;
 teepyoritysmatriisi(rota,        // prepare light rotation matrix
                     sin(xa), sin(ya), sin(za),
                     cos(xa), cos(ya), cos(za));
 vektori_kertaa_matriisi(light->direction, &light->direction, rota); // pyorita valovekky„
}

#endif

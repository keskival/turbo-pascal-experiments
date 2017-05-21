/************************************************************************/
/* camera.h                                                             */
/* erikoiserikoiskiitokset ilkka pelkoselle. he's such a jolly good     */
/* fellow.                                                              */
/************************************************************************/
#ifndef _chem_camera_h
#define _chem_camera_h


/************************************************************************/
/* alustaa kameran:                                                     */
/************************************************************************/
void init_camera(kamera_type *kamera, float PERSPECTIVE, float CENTER_X,
                 float CENTER_Y, float x_suhde, float y_suhde,
                 int screen_left, int screen_right,
                 int screen_up, int screen_down)
{
 kamera->perspective = PERSPECTIVE;
 kamera->center_x = CENTER_X;
 kamera->center_y = CENTER_Y;
 kamera->x_suhde = x_suhde;
 kamera->y_suhde = y_suhde;
 kamera->screen_left = screen_left;
 kamera->screen_right = screen_right;
 kamera->screen_up = screen_up;
 kamera->screen_down = screen_down;

 teetyhjamatriisi(kamera->kam); // prepare camera matrix
 kamera->xpos = 0;   //alkusijainti
 kamera->ypos = 0;
 kamera->zpos = -600;
}


/************************************************************************/
/* py”rittaa ja liikuttaa kameraa.                                       */
/************************************************************************/
void camera_liikuta(kamera_type *kamera, float xa, float ya, float za,
                    float s_rt, float s_dn, float s_fw)
{
  matriisi chg;
  teepyoritysmatriisi(chg,         // prepare camera rotation matrix
                      sin(xa), sin(ya), sin(za),
                      cos(xa), cos(ya), cos(za));

  matriisi_kerro(kamera->kam, chg); // rotate camera

  // move camera:
  kamera->xpos += s_rt * kamera->kam[0][0] +
                  s_dn * kamera->kam[0][1] +
                  s_fw * kamera->kam[0][2];
  kamera->ypos += s_rt * kamera->kam[1][0] +
                  s_dn * kamera->kam[1][1] +
                  s_fw * kamera->kam[1][2];
  kamera->zpos += s_rt * kamera->kam[2][0] +
                  s_dn * kamera->kam[2][1] +
                  s_fw * kamera->kam[2][2];
}


#endif

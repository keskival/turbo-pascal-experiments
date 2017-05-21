program lippu;
uses unit3d,crt;

var
  i,j:integer;
  co,si,d,a:real;
  apunayt:array[0..319,0..199]of byte;

procedure play;

begin
  for i:=100 to 200 do for j:=50 to 120 do
  begin
       co:=cos(((i+d)*0.86)/10+64);
       si:=sin(((j+d)*0.8)/10);
       a:=apunayt[i+round(2*si),round(j+(2.2*co))];
       if a<>0 then
              putpixel(i,j,round(a-(3*((co+1)+(3*(si+1))))),vaddr)
       else putpixel(i,j,0,vaddr);
  end;
  d:=d+5;
  flip;
end;

begin
  setupvirtual;
  setmcga;
  cls(0,vaddr);
  for i:=192 to 255 do pal(i,i-192,0,0);
  for i:=128 to 191 do pal(i,i-128,i-128,i-128);
  for i:=64 to 127 do pal(i,0,0,i-64);
  for i:=0 to 63 do pal(i,i,i,0);
  for i:=0 to 319 do for j:=0 to 199 do apunayt[i,j]:=0;
  for i:=102 to 198 do for j:=52 to 118 do apunayt[i,j]:=191;
  for i:=102 to 198 do for j:=78 to 92 do apunayt[i,j]:=127;
  for i:=127 to 141 do for j:=52 to 118 do apunayt[i,j]:=127;
  for i:=127 to 141 do apunayt[i,78]:=63;
  for i:=127 to 141 do apunayt[i,92]:=63;
  for j:=78 to 92 do apunayt[127,j]:=63;
  for j:=78 to 92 do apunayt[141,j]:=63;
  for i:=128 to 140 do for j:=79 to 91 do apunayt[i,j]:=255;
  apunayt[131,80]:=191;
  apunayt[133,80]:=191;
  apunayt[132,81]:=191;
  apunayt[136,81]:=191;
  apunayt[138,81]:=191;
  apunayt[131,83]:=191;
  apunayt[137,84]:=191;
  apunayt[130,87]:=191;
  apunayt[133,87]:=191;
  apunayt[138,87]:=191;
  apunayt[134,89]:=191;
  apunayt[133,90]:=191;
  apunayt[134,90]:=191;
  apunayt[135,90]:=191;
  apunayt[136,90]:=191;

  apunayt[133,81]:=63;
  apunayt[134,81]:=63;
  apunayt[135,81]:=63;
  apunayt[132,82]:=63;
  apunayt[133,82]:=63;
  apunayt[134,82]:=63;
  apunayt[135,82]:=63;
  apunayt[132,83]:=63;
  apunayt[133,83]:=63;
  apunayt[134,83]:=63;
  apunayt[135,83]:=63;
  apunayt[137,83]:=63;
  apunayt[138,83]:=63;
  apunayt[131,84]:=63;
  apunayt[132,84]:=63;
  apunayt[133,84]:=63;
  apunayt[134,84]:=63;
  apunayt[135,84]:=63;
  apunayt[138,84]:=63;
  apunayt[131,85]:=63;
  apunayt[132,85]:=63;
  apunayt[133,85]:=63;
  apunayt[134,85]:=63;
  apunayt[135,85]:=63;
  apunayt[136,85]:=63;
  apunayt[137,85]:=63;
  apunayt[136,86]:=63;
  apunayt[137,86]:=63;
  apunayt[134,87]:=63;
  apunayt[135,87]:=63;
  apunayt[136,87]:=63;
  apunayt[137,87]:=63;
  apunayt[132,88]:=63;
  apunayt[133,88]:=63;
  apunayt[134,88]:=63;
  apunayt[137,88]:=63;
  apunayt[131,89]:=63;
  apunayt[132,89]:=63;
  apunayt[136,89]:=63;
  apunayt[137,89]:=63;
  apunayt[131,90]:=63;
  apunayt[132,90]:=63;
  apunayt[137,90]:=63;


  repeat play;
  until keypressed;
  settext;
  shutdown;
end.
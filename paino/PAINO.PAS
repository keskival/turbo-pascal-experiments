program paino;
uses unit3d,crt,tpr;

var
  x,y,deltax,deltay,kulma:real;
  vari:integer;

procedure play;
begin
  kulma:=kulma+0.3;
{  putpixel(round(x),round(y),0,vaddr);}
  if kulma>=360 then kulma:=kulma-360;
  deltax:=deltax+ddx(radiaaneiksi(kulma),0.01);
  deltay:=deltay+ddy(radiaaneiksi(kulma),0.01);
  if (x+deltax<=0) then deltax:=-(deltax/1.1);
  if (x+deltax>=319) then deltax:=-(deltax/1.1);
  if (y+deltay<=0) then deltay:=-(deltay/1.1);
  if (y+deltay>=199) then deltay:=-(deltay/1.1);
  x:=x+deltax;
  y:=y+deltay;
  vari:=round((abs(deltax+deltay))/2*50);
  if vari=255 then vari:=0;
  putpixel(round(x),round(y),vari,vaddr);
  flip;
end;

begin
  setmcga;
  setupvirtual;
  x:=100;
  y:=100;
  kulma:=10;
  cls(0,vaddr);
  for vari:=1 to 255 do pal(vari,round(vari/6)+10,round(vari/6),round(vari/6));
  repeat play;
  until keypressed;
  settext;
  shutdown;
end.


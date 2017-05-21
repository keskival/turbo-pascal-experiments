program jousi;
uses unit3d,crt;

var
  piste:array[1..10] of record
    et,x,y:real;
    xvel,yvel:real;
    xkiih,ykiih:real;
  end;
  i:integer;
  j:longint;
  dx,dy,oikeax,oikeay,korx,kory:real;

procedure play;
begin
  for j:=0 to 4999999 do;
  for i:=2 to 10 do
  begin
    piste[i].xkiih:=0;
    piste[i].ykiih:=0.2;
    dx:=piste[i-1].x-piste[i].x;
    dy:=piste[i-1].y-piste[i].y;
    oikeax:=dx/(sqrt(sqr(dx)+sqr(dy)))*piste[i].et;
    oikeay:=dy/(sqrt(sqr(dx)+sqr(dy)))*piste[i].et;
    korx:=(dx-oikeax)/5;
    kory:=(dy-oikeay)/5;
    piste[i].xvel:=korx+piste[i].xvel;
    piste[i].yvel:=kory+piste[i].yvel+0.16;
  end;
{  for i:=2 to 10 do
  begin
    piste[i].ykiih:=piste[i].ykiih+1;
  end;}
  for i:=2 to 9 do
  begin
    dx:=piste[i+1].x-piste[i].x;
    dy:=piste[i+1].y-piste[i].y;
    oikeax:=dx/(sqrt(sqr(dx)+sqr(dy)))*piste[i+1].et;
    oikeay:=dy/(sqrt(sqr(dx)+sqr(dy)))*piste[i+1].et;
    korx:=(dx-oikeax)/5;
    kory:=(dy-oikeay)/5;
    piste[i].xvel:=korx+piste[i].xvel;
    piste[i].yvel:=kory+piste[i].yvel;
  end;
{  for i:=2 to 10 do
  begin
    piste[i].ykiih:=piste[i].ykiih/(sqrt(sqr(piste[i].xkiih)+sqr(piste[i].ykiih)));
    piste[i].xkiih:=piste[i].xkiih/(sqrt(sqr(piste[i].xkiih)+sqr(piste[i].ykiih)));
  end;}
  for i:=2 to 10 do
  begin
{    piste[i].xvel:=piste[i].xvel+piste[i].xkiih;
    piste[i].yvel:=piste[i].yvel+piste[i].ykiih;
    piste[i].xvel:=piste[i].xvel/1.19;
    piste[i].yvel:=piste[i].yvel/1.19;}
  end;
  for i:=2 to 10 do
  begin
    piste[i].x:=piste[i].x+piste[i].xvel;
    piste[i].y:=piste[i].y+piste[i].yvel;
  end;
  for i:=2 to 10 do
  begin
    line(round(piste[i-1].x),round(piste[i-1].y),round(piste[i].x),round(piste[i].y),5,vaddr);
  end;
  for i:=1 to 10 do putpixel(round(piste[i].x),round(piste[i].y),4,vaddr);
  flip;
end;

procedure alusta;
begin
  piste[1].x:=159;
  piste[1].y:=1;
  piste[2].x:=156;
  piste[2].y:=7;
  piste[3].x:=154;
  piste[3].y:=15;
  piste[4].x:=149;
  piste[4].y:=20;
  piste[5].x:=146;
  piste[5].y:=28;
  piste[6].x:=140;
  piste[6].y:=34;
  piste[7].x:=137;
  piste[7].y:=40;
  piste[8].x:=134;
  piste[8].y:=45;
  piste[9].x:=130;
  piste[9].y:=50;
  piste[10].x:=127;
  piste[10].y:=53;
  for i:=1 to 10 do
  begin
    piste[i].xvel:=0;
    piste[i].yvel:=0;
    piste[i].xkiih:=0;
    piste[i].ykiih:=0;
  end;
  for i:=2 to 10 do
  begin
    piste[i].et:=sqrt(sqr(piste[i].x-piste[i-1].x)+sqr(piste[i].y-piste[i-1].y));
  end;
end;

begin
  setmcga;
  setupvirtual;
  cls(0,vaddr);
  alusta;
  repeat
    cls(0,vaddr);
    play;
  until keypressed;
  shutdown;
  settext;
end.
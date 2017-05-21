program jousi;
uses unit3d,crt;

var
  piste:array[1..15] of record
    et,x,y:real;
    xvel,yvel:real;
    xkiih,ykiih:real;
  end;
  i,vari:integer;
  a:char;
  j,k,d:longint;
  dx,dy,oikeax,oikeay,korx,kory:real;

procedure play;
begin
  for i:=2 to 15 do
  begin
    piste[i].xkiih:=0;
    piste[i].ykiih:=0.2;
    dx:=piste[i-1].x-piste[i].x;
    dy:=piste[i-1].y-piste[i].y;
    oikeax:=dx/(sqrt(sqr(dx)+sqr(dy)))*piste[i].et;
    oikeay:=dy/(sqrt(sqr(dx)+sqr(dy)))*piste[i].et;
    korx:=(dx-oikeax)/20;
    kory:=(dy-oikeay)/20;
    piste[i].xvel:=korx+piste[i].xvel;
    piste[i].yvel:=kory+piste[i].yvel+0.00082;
  end;
{  for i:=2 to 10 do
  begin
    piste[i].ykiih:=piste[i].ykiih+1;
  end;}
  for i:=2 to 14 do
  begin
    dx:=piste[i+1].x-piste[i].x;
    dy:=piste[i+1].y-piste[i].y;
    oikeax:=dx/(sqrt(sqr(dx)+sqr(dy)))*piste[i+1].et;
    oikeay:=dy/(sqrt(sqr(dx)+sqr(dy)))*piste[i+1].et;
    korx:=(dx-oikeax)/20;
    kory:=(dy-oikeay)/20;
    piste[i].xvel:=korx+piste[i].xvel;
    piste[i].yvel:=kory+piste[i].yvel;
  end;
{  for i:=2 to 10 do
  begin
    piste[i].ykiih:=piste[i].ykiih/(sqrt(sqr(piste[i].xkiih)+sqr(piste[i].ykiih)));
    piste[i].xkiih:=piste[i].xkiih/(sqrt(sqr(piste[i].xkiih)+sqr(piste[i].ykiih)));
  end;}
  for i:=2 to 15 do
  begin
    piste[i].xvel:=piste[i].xvel/1.0000;
    piste[i].yvel:=piste[i].yvel/1.0000;
  end;
  for i:=2 to 15 do
  begin
    piste[i].x:=piste[i].x+piste[i].xvel;
    piste[i].y:=piste[i].y+piste[i].yvel;
  end;
  for i:=2 to 15 do
  begin
    line(round(piste[i-1].x),round(piste[i-1].y),round(piste[i].x),round(piste[i].y),vari,vaddr);
  end;
  vari:=vari+1;
  if vari>=255 then vari:=1;
  for i:=1 to 15 do putpixel(round(piste[i].x),round(piste[i].y),4,vaddr);
  flip;
end;

procedure alusta;
begin
  piste[1].x:=160;
  piste[1].y:=1;
  piste[2].x:=150;
  piste[2].y:=1;
  piste[3].x:=140;
  piste[3].y:=1;
  piste[4].x:=130;
  piste[4].y:=1;
  piste[5].x:=120;
  piste[5].y:=1;
  piste[6].x:=110;
  piste[6].y:=1;
  piste[7].x:=100;
  piste[7].y:=1;
  piste[8].x:=90;
  piste[8].y:=1;
  piste[9].x:=80;
  piste[9].y:=1;
  piste[10].x:=70;
  piste[10].y:=1;
  piste[11].x:=60;
  piste[11].y:=1;
  piste[12].x:=50;
  piste[12].y:=1;
  piste[13].x:=40;
  piste[13].y:=1;
  piste[14].x:=30;
  piste[14].y:=1;
  piste[15].x:=20;
  piste[15].y:=1;
  for i:=1 to 15 do
  begin
    piste[i].xvel:=0;
    piste[i].yvel:=0;
    piste[i].xkiih:=0;
    piste[i].ykiih:=0;
  end;
  for i:=2 to 15 do
  begin
    piste[i].et:=sqrt(sqr(piste[i].x-piste[i-1].x)+sqr(piste[i].y-piste[i-1].y));
  end;
end;

begin
  vari:=1;
  setmcga;
  setupvirtual;
  cls(0,vaddr);
  repeat
  alusta;
  d:=0;
  repeat
    play;
    d:=d+1;
    cls(0,vaddr);
  until (keypressed);
  d:=0;
  if keypressed then a:=readkey;
  until a='q';
  shutdown;
  settext;
end.
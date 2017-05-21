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
  dx,dy,oikeax,oikeay,korx,kory,xsu:real;

procedure play;
begin
  if (piste[1].x+xsu<130)or(piste[1].x+xsu>190) then xsu:=-xsu;
  piste[1].x:=piste[1].x+xsu;
  piste[1].y:=1;
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
    piste[i].xvel:=piste[i].xvel/1.004;
    piste[i].yvel:=piste[i].yvel/1.004;
  end;
  for i:=2 to 15 do
  begin
    piste[i].x:=piste[i].x+piste[i].xvel;
    piste[i].y:=piste[i].y+piste[i].yvel;
  end;
  for i:=2 to 15 do
  begin
    line(round(piste[i-1].x),round(piste[i-1].y),round(piste[i].x),round(piste[i].y),1,vaddr);
  end;
  vari:=vari+1;
  if vari>=255 then vari:=1;
  for i:=1 to 15 do putpixel(round(piste[i].x),round(piste[i].y),4,vaddr);
  flip;
end;

procedure alusta;
begin
  xsu:=0.1;
  for i:=1 to 15 do piste[i].x:=160;
  for i:=2 to 15 do piste[i].y:=1+(i-1)*10;
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
{    cls(0,vaddr);}
  until (keypressed);
  d:=0;
  if keypressed then a:=readkey;
  until a='q';
  shutdown;
  settext;
end.
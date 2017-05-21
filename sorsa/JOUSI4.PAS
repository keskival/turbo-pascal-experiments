program jousi;
uses unit3d,crt;

var
  piste:array[1..10] of record
    et,x,y:real;
    xvel,yvel:real;
  end;
  i:integer;
  a:char;
  j,d:longint;
  dx,dy,oikeax,oikeay,korx,kory:real;

procedure play;
begin
  for i:=2 to 10 do
  begin {nopeuksien derivaatat, jotka aiheutuvat edelt„vist„ pisteist„}
    dx:=piste[i-1].x-piste[i].x;
    dy:=piste[i-1].y-piste[i].y;
    oikeax:=dx/(sqrt(sqr(dx)+sqr(dy)))*piste[i].et;
    oikeay:=dy/(sqrt(sqr(dx)+sqr(dy)))*piste[i].et;
    korx:=(dx-oikeax)/400;
    kory:=(dy-oikeay)/400;
    piste[i].xvel:=korx+piste[i].xvel;
    piste[i].yvel:=kory+piste[i].yvel+0.00062; {Painovoimaa, tai siis nopeuden derivaattaa.}
  end;
  for i:=2 to 9 do
  begin {nopeuksien derivaatat, jotka aiheutuvat "j„ljent„vist„" pisteist„}
    dx:=piste[i+1].x-piste[i].x;
    dy:=piste[i+1].y-piste[i].y;
    oikeax:=dx/(sqrt(sqr(dx)+sqr(dy)))*piste[i+1].et;
    oikeay:=dy/(sqrt(sqr(dx)+sqr(dy)))*piste[i+1].et;
    {"oikeat" et„isyydet. Opettele vektorilaskentaa nysv„.}
    korx:=(dx-oikeax)/400;
    kory:=(dy-oikeay)/400;
    {Lasketaan paljonko pisteen et„isyys oikeasta et„isyydest„ on v„„r„ ja jaetaan se sopivan kokoiseksi}
    piste[i].xvel:=korx+piste[i].xvel;
    piste[i].yvel:=kory+piste[i].yvel;
    {Lis„t„„n edellisiin nopeuksiin nyt lasketut}
  end;
  for i:=2 to 10 do
  begin
    piste[i].xvel:=piste[i].xvel/1.0005;
    piste[i].yvel:=piste[i].yvel/1.0005;
    {Kitkaa. Toimii my”s ilman n„it„, vaikkakin jokseenkin kaoottisesti}
  end;
  for i:=2 to 10 do
  begin
    piste[i].x:=piste[i].x+piste[i].xvel;
    piste[i].y:=piste[i].y+piste[i].yvel;
    {Nopeudet muuttavat pisteiden koordinaatteja}
  end;
  for i:=2 to 10 do
  begin
    line(round(piste[i-1].x),round(piste[i-1].y),round(piste[i].x),round(piste[i].y),5,vaddr);
    {Ainoa mit„ teid„n tarvitsee tiet„„ on, ett„ t„m„ piirt„„ viivan}
  end;
  for i:=1 to 10 do putpixel(round(piste[i].x),round(piste[i].y),4,vaddr);
  {Pisteet viivojen v„liin}
  flip; {Heitt„„ virtuaalin„yt”n n„ytt”muistiin, eli n„ytt„„ sen}
  {Huomaa, ett„ nopeuksia ei tietenk„„n nollata}
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
  for i:=1 to 10 do
  begin
    piste[i].xvel:=0;
    piste[i].yvel:=0;
  end;
  for i:=2 to 10 do
  begin
    piste[i].et:=sqrt(sqr(piste[i].x-piste[i-1].x)+sqr(piste[i].y-piste[i-1].y));
    {pisteen et„isyys edelt„v„„n pisteeseen}
  end;
end;

begin
  setmcga;
  setupvirtual;
  cls(0,vaddr);
  repeat
    alusta;
    d:=0;
    repeat
      cls(0,vaddr);
      play;
      d:=d+1;
    until (keypressed)or(d>7999);
    d:=0;
    if keypressed then a:=readkey;
  until a='q';
  shutdown;
  settext;
end.
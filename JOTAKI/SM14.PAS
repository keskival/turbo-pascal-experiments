program suolimato;

uses
    kamaa,crt,drivers,objects;
const
  numero=1;
  versio='1.4';
  maksaja='Tero Keski-Valkama';

type
  osoitin=^elementti;
  elementti=record
    x:integer;
    y:integer;
    link:osoitin;
  end;

var
   juuri,z:osoitin;
   vali,kanni,lapi,kuollut:boolean;
   sinimaara,lisays,x,y,ysu,xsu,edescore,pallox:integer;
   rand,palloy,temp,nykypituus,pituus,d,i:integer;
   newvar,vari:byte;
   loop,pisteet:longint;
   b:byte;
   c:char;

procedure poistavimppa;
begin
  nykypituus:=nykypituus-1;
  for temp:=1 to nykypituus do z:=z^.link;
  putpixel(z^.x,z^.y,0,vga);
end;

procedure poistaedepallo;
begin
  circle(pallox,palloy,5,0,vga);
  pallox:=random(300)+10;
  palloy:=random(100)+60;
end;

procedure uusipallo;
begin
  circle(pallox,palloy,5,random(4)+68,vga);
end;

procedure lisaapaletti;
var
  a,b,c:byte;
  e,d:integer;

begin
  waitretrace;
  for i:=66 downto 2 do
  begin
    d:=i;
    e:=d-1;
    if d=2 then e:=64;
    getpal(e,a,b,c);
    pal(d,a,b,c);
  end;
end;

procedure vasen;
begin
  xsu:=-1;
  ysu:=0;
end;

procedure oikea;
begin
  xsu:=1;
  ysu:=0;
end;

procedure ylos;
begin
  xsu:=0;
  ysu:=-1;
end;

procedure alas;
begin
  xsu:=0;
  ysu:=1;
end;

procedure kannita;
begin
  rand:=random(4);
  if (kanni=true)and(xsu<>0)and(rand=1) then y:=y-1;
  if (kanni=true)and(xsu<>0)and(rand=2) then y:=y+1;
  if (kanni=true)and(ysu<>0)and(rand=2) then x:=x+1;
  if (kanni=true)and(ysu<>0)and(rand=1) then x:=x-1;
end;

procedure alku;
begin
  clrscr;
  writeln('T„m„ on Tero Keski-Valkaman tekem„ Suoli-Mato.');
  writeln('Versio: ',versio);
  writeln('Rekister”ij„: ',maksaja,', numero: ',numero);
  writeln;
  writeln('Paina jotakin n„pp„int„...');
  readkey;
end;

begin
  juuri:=nil;
  randomize;
  edescore:=0;
  alku;
  setmcga;
  pal(68,63,0,0);
  pal(69,63,63,0);
  pal(70,0,63,0);
  pal(71,0,63,63);
  pal(72,0,0,63);
  poistaedepallo;
  uusipallo;
  pituus:=10;
  for b:=2 to 33 do pal(b+32,0,b-2,0);
  for b:=2 to 33 do pal(b,0,35-b,0);
  box(0,20,319,199,1,vga);
  x:=159;
  y:=100;
  vari:=2;
  xsu:=0;
  ysu:=1;
  repeat
    c:=' ';
    if keypressed then c:=readkey;
    vari:=vari+1;
    if vari=64 then vari:=2;
    if (c='4')and(xsu<>1) then vasen;
    if (c='6')and(xsu<>-1) then oikea;
    if (c='8')and(ysu<>1) then ylos;
    if (c='5')and(ysu<>-1) then alas;
    line(round(pisteet/(1500/319)),0,edescore,0,1,vga);
    if pisteet>750 then kanni:=true;
    edescore:=round(pisteet/(2000/319));
    newvar:=getpixel(x+xsu,y+ysu,vga);
    if pisteet>=2000 then lapi:=true;
    if newvar=1 then kuollut:=true;
    if (newvar>67)and(newvar<72) then begin
      poistaedepallo;
      uusipallo;
      if newvar=68 then lisays:=50;
      if newvar=69 then lisays:=100;
      if newvar=70 then lisays:=25;
      if newvar=71 then lisays:=10;
      pisteet:=pisteet+lisays;
      pituus:=pituus+lisays;
    end;
    if (newvar>1)and(newvar<68) then kuollut:=true;
    kannita;
    x:=x+xsu;
    y:=y+ysu;
    nykypituus:=nykypituus+1;
    if nykypituus>=pituus then poistavimppa;
    new(z);
    z^.x:=x;
    z^.y:=y;
    z^.link:=juuri;
    juuri:=z;
    lisaapaletti;
    putpixel(x,y,vari,vga);
  until (kuollut=true)or(lapi=true);
  settext;
  clrscr;
  writeln('Sait ',pisteet,' pistett„!!!');
  if lapi=true then writeln('P„„sit l„pi!!! Onneksi olkoon!!!');
  readkey;
end.
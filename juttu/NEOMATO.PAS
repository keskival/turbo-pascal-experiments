program mato;
uses unit3d,crt,dos,tpr;

type
  piste=^pistepaikka;
  pistepaikka=record
    x,y:real;
    paks:integer;
    ede,jalk:piste;
    c:byte;
  end;

const NAPPMAARA=6;
      KEYBOARDINTR = 9;
      KEYBOARDPORT = $60;

var
  viive:longint;
  pallo:record
    x,y:integer;
  end;
  alku,paate,nyky,apu:piste;
  loppuraja,pistmaara,pisteet,tavoite:integer;
  paksuus,nopeus,kkulma,kulma:real;
  nykyvari:byte;
  loppu,kuoli,lapi:boolean;

  {N„ppisk„sittelij„n muuttujat}
  BIOSKeyboardHandler : procedure;
  CallBIOSHandler : boolean;
  NAPP:ARRAY[1..NAPPMAARA]OF BOOLEAN;


{$F+}
procedure KeyboardHandler(Flags, CS, IP, AX, BX, CX, DX,
                          SI, DI, DS, ES, BP: Word);
interrupt;
var key : byte;
begin
  key := Port[KEYBOARDPORT];
  IF KEY=30 THEN NAPP[1]:=TRUE;
  IF KEY=30+128 THEN NAPP[1]:=FALSE;
  IF KEY=31 THEN NAPP[2]:=TRUE;
  IF KEY=31+128 THEN NAPP[2]:=FALSE;
  IF KEY=44 THEN NAPP[3]:=TRUE;
  IF KEY=44+128 THEN NAPP[3]:=FALSE;
  IF KEY=45 THEN NAPP[4]:=TRUE;
  IF KEY=45+128 THEN NAPP[4]:=FALSE;
  IF KEY=32 THEN NAPP[5]:=TRUE;
  IF KEY=32+128 THEN NAPP[5]:=FALSE;
  IF KEY=46 THEN NAPP[6]:=TRUE;
  IF KEY=46+128 THEN NAPP[6]:=FALSE;
  IF KEY=1 THEN LOPPU:=TRUE;
  if CallBIOSHandler then
    begin
      asm pushf end;
      BIOSKeyboardHandler;
    end
  else Port[$20] := $20;
end;
{$F-}

procedure nelio(color:byte;x,y:real;paksu:integer);
var i,j:integer;
begin
  for i:=0+round(x) to paksu+round(x) do
  for j:=0+round(y) to paksu+round(y) do putpixel(i-(paksu div 2),j-(paksu div 2),color,vaddr);
end;

procedure alusta;
var i:integer;
begin
  clrscr;
  writeln('Painappas jotain nappia aloittaaksesi.');
  writeln('Pelinaikaiset n„pp„imet:');
  writeln('A-vasen     D-oikea');
  readkey;
  CallBIOSHandler := false;
  GetIntVec(KEYBOARDINTR, @BIOSKeyboardHandler);
  SetIntVec(KEYBOARDINTR, Addr(KeyboardHandler));
  setmcga;
  setupvirtual;
  cls(0,vaddr);

      PAKSUUS:=2;
      NOPEUS:=2.0;
      kkulma:=0.13;
      LOPPURAJA:=80;

  kulma:=50;
  new(alku);
  paate:=alku;
  alku^.ede:=nil;
  alku^.jalk:=nil;
  alku^.x:=100;
  alku^.y:=100;
  alku^.c:=1;
  nykyvari:=1;
  loppu:=false;
  loppuraja:=61;
  tavoite:=10;
  for i:=1 to 63 do pal(i,i,0,50);
  for i:=64 to 127 do pal(i,63-(i-64),0,50);
  line(18,18,302,18,128,vaddr);
  line(18,18,18,182,128,vaddr);
  line(18,182,302,182,128,vaddr);
  line(302,18,302,182,128,vaddr);
  randomize;
  pal(128,63,63,63);
  pal(129,63,63,63);
  pallo.x:=random(200)+40;
  pallo.y:=random(130)+30;

end;

procedure lopeta;
begin
  SHUTDOWN;
  SETTEXT;
  SetIntVec(KEYBOARDINTR, @BIOSKeyboardHandler);
  repeat
  begin
    paate:=paate^.jalk;
    dispose(paate^.ede);
  end;
  until paate^.jalk=nil;
  dispose(paate);
end;

procedure poistavimppa;
begin
  if paate<>alku then
  begin
    apu:=paate;
    nelio(0,paate^.x,paate^.y,paate^.paks);
    paate:=apu^.jalk;
    dispose(apu);
    paate^.ede:=nil;
    nelio(paate^.c,paate^.x,paate^.y,paate^.paks);
    pistmaara:=pistmaara-1;
  end;
end;

procedure piirrauusi;
begin
  new(alku^.jalk);
  apu:=alku;
  alku:=alku^.jalk;
  alku^.jalk:=nil;
  alku^.ede:=apu;
  alku^.x:=alku^.ede^.x+ddx(kulma,nopeus);
  alku^.y:=alku^.ede^.y+ddy(kulma,nopeus);
  alku^.c:=nykyvari;
  alku^.paks:=round(paksuus);
  nelio(alku^.c,alku^.x,alku^.y,round(paksuus));
  pistmaara:=pistmaara+1;
  nykyvari:=nykyvari+1;
  if nykyvari=128 then nykyvari:=1;
end;

procedure pisteita;
begin
  pisteet:=pisteet+1;
  nelio(129,10+(pisteet*5),5,2);
  tavoite:=tavoite+5;

  nelio(0,pallo.x,pallo.y,2);
  pallo.x:=random(200)+40;
  pallo.y:=random(130)+30;

end;

procedure piirraloput;
var
  tempr,tempg,tempb,r,g,b:byte;
  i:integer;
begin
  nelio(129,pallo.x,pallo.y,2);
  getpal(127,tempr,tempg,tempb);
  waitretrace;
  for i:=126 downto 1 do
  begin
    getpal(i,r,g,b);
    pal(i+1,r,g,b);
  end;
  pal(1,tempr,tempg,tempb);
end;

procedure tormasko;
var
  paksuu:integer;
  c1,c2,c3,c4:byte;

begin
  paksuu:=round(paksuus);
  {Mahdollinen optimointipaikka}
  c1:=getpixel(round(alku^.x+ddx(kulma,(paksuu div 2+1))),round(alku^.y+ddy(kulma,(paksuu div 2+1))),vaddr);
  if ((c1>0)and(c1<129)and((c1<>alku^.c)))
    then loppu:=true;
end;

procedure play;

begin
{  liikuta;}
  if (alku^.x<20)or(alku^.x>300)or(alku^.y<20)or(alku^.y>180) then
  begin
    loppu:=true;
    kuoli:=true;
  end;
  tormasko;
  piirrauusi;
  if pistmaara>=tavoite then poistavimppa;
  if pistmaara>=tavoite then poistavimppa;
  if (alku^.x<(pallo.x+paksuus+1))and(alku^.x>(pallo.x-paksuus-1))
    and(alku^.y<(pallo.y+paksuus+1))and(alku^.y>(pallo.y-paksuus-1)) then pisteita;
  if pisteet>=loppuraja then
  begin
    loppu:=true;
    lapi:=true;
  end;
  if napp[1]=true then kulma:=kulma-kkulma;
  if napp[5]=true then kulma:=kulma+kkulma;
  if napp[2]=true then tavoite:=tavoite+1;
  if napp[3]=true then tavoite:=tavoite-1;
  if (napp[4]=true)and(paksuus<10) then paksuus:=paksuus+0.1;
  if (napp[6]=true)and(paksuus>0) then paksuus:=paksuus-0.1;
  piirraloput;
  flip;
end;

begin
  alusta;
  repeat play;
  until loppu=true;
  for viive:=0 to 999999 do;
  lopeta;
  clrscr;
  writeln('Sait ker„tty„ ',pisteet,' pistett„.');
  if lapi=true then writeln('P„„sit l„pi! Onneksi olkoon! Eth„n vain huijannut!');
end.
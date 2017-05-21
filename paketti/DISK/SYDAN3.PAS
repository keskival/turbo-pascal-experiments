program kuutio;
uses graf,tpr,crt,dos;

var
    PISTE:ARRAY[1..8,1..3]OF INTEGER;
    OLDX,OLDY,OLDZ,UUSIX,UUSIY,UUSIZ:ARRAY[1..8]OF INTEGER;
    viive:longint;
    xsu,ysu:integer;
    edex,edey,xs,ys,d,I:INTEGER;
    XANGLE,YANGLE,ZANGLE:REAL;
    a,b,LOPPU:BOOLEAN;

PROCEDURE PYORITA(X,Y,Z:INTEGER; XAN,YAN,ZAN:REAL; VAR NEWX,NEWY,NEWZ:INTEGER);
BEGIN
  NEWX:=ROUND(X*(SIN(YAN)*SIN(ZAN)*SIN(XAN)+COS(YAN)*COS(XAN))+Y*(COS(ZAN)*SIN(XAN))+
  Z*(COS(YAN)*SIN(ZAN)*SIN(XAN)-COS(XAN)*SIN(YAN)));
  NEWY:=ROUND(X*(COS(XAN)*SIN(YAN)*SIN(ZAN)-COS(YAN)*SIN(XAN))+Y*(COS(ZAN)*COS(XAN))+
  Z*(COS(YAN)*COS(XAN)*SIN(ZAN)+SIN(YAN)*SIN(XAN)));
  NEWZ:=ROUND(X*(COS(YAN)*SIN(ZAN)*SIN(XAN)-COS(XAN)*SIN(YAN))+
  Y*(-SIN(ZAN))+Z*(COS(YAN)*COS(ZAN)));
END;

PROCEDURE PLAY;
BEGIN
  if a=true then XANGLE:=XANGLE+0.06;
  if xangle>=6.28 then begin
    a:=false;
    xangle:=0;
  end;
  if (a=false)and(b=true) then yangle:=yangle+0.06;
  if yangle>=pi*2 then begin
    b:=false;
    yangle:=0;
  end;
  if b=false then zangle:=zangle+0.06;
  if zangle>=pi*2 then begin
    loppu:=true;
    zangle:=0;
  end;
  FOR I:=1 TO 8 DO BEGIN
    OLDX[I]:=UUSIX[I];
    OLDY[I]:=UUSIY[I];
    OLDZ[I]:=UUSIZ[I];
    PYORITA(PISTE[I,1],PISTE[I,2],PISTE[I,3],XANGLE,YANGLE,ZANGLE,UUSIX[I],UUSIY[I],UUSIZ[I]);
  END;
  polygon(oldx[1]+159,oldy[1]+99,oldx[2]+159,oldy[2]+99,oldx[3]+159,oldy[3]+99,oldx[4]+159,oldy[4]+99,0,vaddr);
  polygon(oldx[4]+159,oldy[4]+99,oldx[5]+159,oldy[5]+99,oldx[6]+159,oldy[6]+99,oldx[1]+159,oldy[1]+99,0,vaddr);
  polygon(oldx[6]+159,oldy[6]+99,oldx[7]+159,oldy[7]+99,oldx[8]+159,oldy[8]+99,oldx[1]+159,oldy[1]+99,0,vaddr);
  polygon(uusix[1]+159,uusiy[1]+99,uusix[2]+159,uusiy[2]+99,uusix[3]+159,uusiy[3]+99,uusix[4]+159,uusiy[4]+99,4,vaddr);
  polygon(uusix[4]+159,uusiy[4]+99,uusix[5]+159,uusiy[5]+99,uusix[6]+159,uusiy[6]+99,uusix[1]+159,uusiy[1]+99,4,vaddr);
  polygon(uusix[6]+159,uusiy[6]+99,uusix[7]+159,uusiy[7]+99,uusix[8]+159,uusiy[8]+99,uusix[1]+159,uusiy[1]+99,4,vaddr);
  flip;
END;

procedure alku;
begin;
  SETMCGA;
  setupvirtual;
  cls(0,vaddr);
  cls(0,vga);
end;

procedure lopetus;
begin
  settext;
end;

procedure sydan;
BEGIN
  PISTE[1,1]:=0;
  PISTE[1,2]:=0;
  PISTE[1,3]:=0;
  PISTE[2,1]:=-10;
  PISTE[2,2]:=-10;
  PISTE[2,3]:=0;
  PISTE[3,1]:=-20;
  PISTE[3,2]:=-10;
  PISTE[3,3]:=0;
  PISTE[4,1]:=-30;
  PISTE[4,2]:=0;
  PISTE[4,3]:=0;
  PISTE[5,1]:=0;
  PISTE[5,2]:=30;
  PISTE[5,3]:=0;
  PISTE[6,1]:=30;
  PISTE[6,2]:=0;
  PISTE[6,3]:=0;
  PISTE[7,1]:=20;
  PISTE[7,2]:=-10;
  PISTE[7,3]:=0;
  PISTE[8,1]:=10;
  PISTE[8,2]:=-10;
  PISTE[8,3]:=0;
  for d:=0 to 1 do begin
    a:=true;
    b:=true;
    loppu:=false;
    REPEAT
      PLAY;
    UNTIL LOPPU=TRUE;
  end;
END;

procedure pumppu;
begin
  flip;
  for viive:=0 to 9999999 do ;
  for d:=0 to 6 do begin
    for i:=0 to 63 do begin
      waitretrace;
      pal(4,i,0,0);
    end;
    for i:=63 downto 0 do begin
      for viive:=0 to 999 do;
      waitretrace;
      pal(4,i,0,0);
    end;
  end;
end;

procedure heilutus;
begin
  pal(4,63,0,0);
  xs:=159;
  ys:=99;
  xsu:=1;
  ysu:=1;
  for viive:=0 to 999 do begin
    edex:=xs;
    edey:=ys;
    if (xs>=279)or(xs<=50) then xsu:=-xsu;
    if (ys>=149)or(ys<=50) then ysu:=-ysu;
    xs:=xs+xsu;
    ys:=ys+ysu;
    polygon(oldx[1]+edex,oldy[1]+edey,oldx[2]+edex,oldy[2]+edey,oldx[3]+edex,oldy[3]+edey,oldx[4]+edex,oldy[4]+edey,0,vaddr);
    polygon(oldx[4]+edex,oldy[4]+edey,oldx[5]+edex,oldy[5]+edey,oldx[6]+edex,oldy[6]+edey,oldx[1]+edex,oldy[1]+edey,0,vaddr);
    polygon(oldx[6]+edex,oldy[6]+edey,oldx[7]+edex,oldy[7]+edey,oldx[8]+edex,oldy[8]+edey,oldx[1]+edex,oldy[1]+edey,0,vaddr);
    polygon(uusix[1]+xs,uusiy[1]+ys,uusix[2]+xs,uusiy[2]+ys,uusix[3]+xs,uusiy[3]+ys,uusix[4]+xs,uusiy[4]+ys,4,vaddr);
    polygon(uusix[4]+xs,uusiy[4]+ys,uusix[5]+xs,uusiy[5]+ys,uusix[6]+xs,uusiy[6]+ys,uusix[1]+xs,uusiy[1]+ys,4,vaddr);
    polygon(uusix[6]+xs,uusiy[6]+ys,uusix[7]+xs,uusiy[7]+ys,uusix[8]+xs,uusiy[8]+ys,uusix[1]+xs,uusiy[1]+ys,4,vaddr);
    flip;
  end;
end;

procedure teksti;
begin
  settext;
  clrscr;
  writeln('T„m„n Syd„n-demon on tehnyt:');
  for viive:=0 to 99999999 do;
  writeln('Tero Keski-Valkama!!!!');
  for viive:=0 to 99999999 do;
  writeln('Kiitokset t„m„n musiikin tekij„lle(enh„n m„ nyt niin hyv„ s„velt„j„ ole...),');
  for viive:=0 to 99999999 do;
  writeln('Dmp:n tekij„lle(en jaksanut tehd„ omaa MODien soitto-ohjelmaa),');
  for viive:=0 to 99999999 do;
  writeln('Ja kaikille, joilta olen ripannut koodia(Sorry about that... I''m so lame!!!)');
  for viive:=0 to 99999999 do;
  writeln('Ja nyt: That''s all folks!!!!');
  for viive:=0 to 99999999 do;
end;

begin
  alku;
  sydan;
  pumppu;
  heilutus;
  teksti;
  lopetus;
end.

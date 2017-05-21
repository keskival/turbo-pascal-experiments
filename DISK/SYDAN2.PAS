program kuutio;
uses graf,tpr,crt,dos;

var
    PISTE:ARRAY[1..8,1..3]OF INTEGER;
    OLDX,OLDY,OLDZ,UUSIX,UUSIY,UUSIZ:ARRAY[1..8]OF INTEGER;
    d,VIIVE,I:INTEGER;
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
  if a=true then XANGLE:=XANGLE+0.04;
  if xangle>=6.28 then begin
    a:=false;
    xangle:=0;
  end;
  if (a=false)and(b=true) then yangle:=yangle+0.04;
  if yangle>=6.28 then begin
    b:=false;
    yangle:=0;
  end;
  if b=false then zangle:=zangle+0.04;
  if zangle>=6.28 then begin
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
  for d:=0 to 5 do begin
    a:=true;
    b:=true;
    loppu:=false;
    REPEAT
      PLAY;
    UNTIL LOPPU=TRUE;
  end;
END;

begin
  alku;
  sydan;
  lopetus;
end.

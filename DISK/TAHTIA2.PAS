program kuutio;
uses kamaa,tpr,crt,dos;
const pistmaara=300;
      NAPPMAARA=6;
      vidseg:word=$a000;
      KEYBOARDINTR = 9;
      KEYBOARDPORT = $60;

var BIOSKeyboardHandler : procedure;
    CallBIOSHandler : boolean;
    PISTE:ARRAY[1..pistmaara,1..3]OF real;
    OLDX,OLDY,OLDZ,UUSIX,UUSIY,UUSIZ:ARRAY[1..pistmaara]OF real;
    oldxhomma,oldyhomma,xhomma,yhomma,VIIVE,I,A:INTEGER;
    vari2:byte;
    XANGLE,YANGLE,ZANGLE:REAL;
    vari:longint;
    nakyy:array[1..pistmaara]of boolean;
    EDENAKYY,LOPPU:BOOLEAN;
    NAPP:ARRAY[1..NAPPMAARA]OF BOOLEAN;

{$F+}

procedure KeyboardHandler(Flags, CS, IP, AX, BX, CX, DX,
                          SI, DI, DS, ES, BP: Word);
interrupt;
var key : byte;
begin
  key := Port[KEYBOARDPORT];
  IF KEY=1 THEN LOPPU:=TRUE;
  if CallBIOSHandler then
    begin
      asm pushf end;
      BIOSKeyboardHandler;
    end
  else Port[$20] := $20;
end;
{$F-}

PROCEDURE PYORITA(X,Y,Z:integer; XAN,YAN,ZAN:REAL; VAR NEWX,NEWY,NEWZ:Real);
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
  ZANGLE:=ZANGLE-0.02;
  XANGLE:=XANGLE-0.02;
  {YANGLE:=YANGLE-0.02;}
  FOR I:=1 TO pistmaara DO BEGIN
    nakyy[i]:=true;
    OLDX[I]:=UUSIX[I];
    OLDY[I]:=UUSIY[I];
    OLDZ[I]:=UUSIZ[I];
    PYORITA(round(PISTE[I,1]),round(PISTE[I,2]),round(PISTE[I,3]),XANGLE,YANGLE,ZANGLE,UUSIX[I],UUSIY[I],UUSIZ[I]);
    oldxhomma:=(round(((oldx[i])))+159);
    oldyhomma:=(round(((oldy[i])))+99);
    xhomma:=(round(((uusix[i])))+159);
    yhomma:=(round(((uusiy[i])))+99);
    if edenakyy=true then putpixel(oldxhomma,oldyhomma,0,vga);
    edenakyy:=nakyy[i];
    if (xhomma<0)or(xhomma>319)or(yhomma<0)or(yhomma>199) then nakyy[i]:=false
      else
      nakyy[i]:=true;
    vari:=round(uusiz[i]+19);
    if vari>63 then vari:=63;
    if vari<1 then vari:=1;
    vari2:=vari;
    if nakyy[i]=true then putpixel(xhomma,yhomma,vari2,vga);
  END;
END;

BEGIN
  CallBIOSHandler := false;
  GetIntVec(KEYBOARDINTR, @BIOSKeyboardHandler);
  SetIntVec(KEYBOARDINTR, Addr(KeyboardHandler));
  clrscr;
  WRITELN('K„yt„ A,S,D,Z,X,C nappeja!');
  SETMCGA;
  cls(0,vga);
  for i:=1 to 63 do pal(i,i,i,i);
  for i:=63 to 255 do pal(i,255,255,255);
  for i:=1 to 100 do
    for a:=1 to 3 do PISTE[i,a]:=random(pistmaara)-round(pistmaara/2);
  REPEAT
    PLAY;
  UNTIL LOPPU=TRUE;
  SETTEXT;
  SetIntVec(KEYBOARDINTR, @BIOSKeyboardHandler);
END.

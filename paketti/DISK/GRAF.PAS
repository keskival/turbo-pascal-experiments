unit graf;
interface
{$r+}
{$X+}
USES dos,Crt;

CONST
  VGA = $a000;

Type
  Virtual = Array [1..64000] of byte;
  VirtPtr = ^Virtual;

VAR
  Virscr : VirtPtr;
  Vaddr  : word;
  Pall  : Array[0..255,1..3] of Byte;

procedure LoadCOL (FileName : string);
procedure LoadCEL (FileName :  string; ScrPtr : pointer);
procedure FillBox (x1, y1, x2, y2 : integer; b : byte;whe:word);
Procedure Blackout;
Procedure Flip;
Procedure GrabPallette;
procedure WaitRetrace;
function getpixel(x,y:integer;whe:word):byte;
Procedure Circle (X,Y,rad:integer;Col:Byte;whe:word);
procedure box(x1,y1,x2,y2:integer;col:byte;whe:word);
Procedure GetPal(ColorNo : Byte; Var R,G,B : Byte);
Procedure Pal(ColorNo : Byte; R,G,B : Byte);
Procedure Cls (Col : Byte; Where:Word);
Procedure SetUpVirtual;
Procedure ShutDown;
Procedure PutPixel (X,Y : Integer; Col : Byte; Where : Word);
Procedure line(a,b,c,d,col:integer;whe:word);
Procedure Fadeup;
Procedure FadeDown;
procedure SetMode (Mode : word);
Procedure SetMCGA;
Procedure SetText;
procedure polygon(x1,y1,x2,y2,x3,y3,x4,y4:integer; c:byte;whe:word);
procedure horline(xb,xe,y:integer; c:byte; whe:word);

implementation

procedure horline(xb,xe,y:integer; c:byte; whe:word); assembler;
asm
  mov bx,[xb]
  cmp bx,0              { if zero don't draw }
  jz @out
  cmp bx,320
  ja @out
  mov cx,[xe]
  jcxz @out
  cmp cx,320
  ja @out
  cmp bx,cx             { see if x-end is smaller than x-begin }
  jb @skip
  xchg bx,cx            { yes: switch coords }
 @skip:
  inc cx
  sub cx,bx             { length of line in cx }
  mov es,whe         { segment to draw in }
  mov ax,[y]            { heigth of line }
  shl ax,6
  mov di,ax
  shl ax,2
  add di,ax             { y*320 in di (offset) }
  add di,bx             { add x-begin }
  mov al,[c]            { get color }
  shr cx,1              { div length by 2 }
  jnc @skip2            { carry set? }
  stosb                 { draw byte }
 @skip2:
  mov ah,al             { copy color in hi-byte }
  rep stosw             { draw (rest of) line }
 @out:
end;

procedure polygon(x1,y1,x2,y2,x3,y3,x4,y4:integer; c:byte; whe:word);
var
  xpos:array[0..199,0..1] of integer;
  mny,mxy,y:integer;
  i:word;
  s1,s2,s3,s4:shortint;
  pos:byte;
begin
  mny:=y1;
  if y2<mny then mny:=y2;
  if y3<mny then mny:=y3;
  if y4<mny then mny:=y4;

  mxy:=y1;
  if y2>mxy then mxy:=y2;
  if y3>mxy then mxy:=y3;
  if y4>mxy then mxy:=y4;

  s1:=byte(y1<y2)*2-1;
  s2:=byte(y2<y3)*2-1;
  s3:=byte(y3<y4)*2-1;
  s4:=byte(y4<y1)*2-1;

  y:=y1; pos:=byte(y1<y2);
  if y1<>y2 then repeat
    xpos[y,pos]:=integer(x2-x1)*(y-y1) div (y2-y1)+x1;
    inc(y,s1);
  until y=y2+s1 else xpos[y,pos]:=x1;
  y:=y2; pos:=byte(y2<y3);
  if y2<>y3 then repeat
    xpos[y,pos]:=integer(x3-x2)*(y-y2) div (y3-y2)+x2;
    inc(y,s2);
  until y=y3+s2 else xpos[y,pos]:=x2;
  y:=y3; pos:=byte(y3<y4);
  if y3<>y4 then repeat
    xpos[y,pos]:=integer(x4-x3)*(y-y3) div (y4-y3)+x3;
    inc(y,s3);
  until y=y4+s3 else xpos[y,pos]:=x3;
  y:=y4; pos:=byte(y4<y1);
  if y4<>y1 then repeat
    xpos[y,pos]:=integer(x1-x4)*(y-y4) div (y1-y4)+x4;
    inc(y,s4);
  until y=y1+s4 else xpos[y,pos]:=x4;
  for y:=mny to mxy do
    horline(xpos[y,0],xpos[y,1],y,c,whe);
end;

procedure SetMode (Mode : word);
begin
  asm
    mov ax,Mode;
    int 10h
  end;
end;

procedure FillBox (x1, y1, x2, y2 : integer; b : byte;whe:word); assembler;
label
  _l1;
asm
  push  ds
  push  es
  mov   ax,word(whe+2)
  mov   es,ax
  mov   ax,y1
  mov   bx,320
  mul   bx
  mov   di,ax
  add   di,x1
  mov   ax,y1
  mov   dx,y2
  sub   dx,ax
  inc   dx

  mov   ax,x1
  mov   cx,x2
  sub   cx,ax
  inc   cx
  mov   al,b
  cld
_l1:
  push  di
  push  cx
  rep   stosb
  pop   cx
  pop   di
  add   di,320
  dec   dx
  jnz   _l1
  pop   es
  pop   ds
end;

procedure LoadCOL (FileName : string);
type
  DACType = array [0..255] of record
                                R, G, B : byte;
                              end;
var
  DAC : DACType;
  Fil : file of DACType;
  I : integer;
  Regs : Registers;
begin
  assign (Fil, FileName);
  reset (Fil);
  read (Fil, DAC);
  close (Fil);
  for I := 0 to 255 do begin
    with Regs do begin
      AX := $1010;
      BX := I;
      DH := DAC [I].R;
      CH := DAC [I].G;
      CL := DAC [I].B;
    end;
    Intr ($10, Regs);
  end;
end;

procedure LoadCEL (FileName :  string; ScrPtr : pointer);
var
  Fil : file;
  Buf : array [1..1024] of byte;
  BlocksRead, Count : word;
begin
  assign (Fil, FileName);
  reset (Fil, 1);
  BlockRead (Fil, Buf, 800);
  Count := 0; BlocksRead := $FFFF;
  while (not eof (Fil)) and (BlocksRead <> 0) do begin
    BlockRead (Fil, mem [seg (ScrPtr^): ofs (ScrPtr^) + Count], 1024, BlocksRead);
    Count := Count + 1024;
  end;
  close (Fil);
end;

Procedure Blackout;

VAR loop1:integer;
BEGIN
  WaitRetrace;
  For loop1:=0 to 255 do
    Pal (loop1,0,0,0);
END;

Procedure GrabPallette;
VAR loop1:integer;
BEGIN
  For loop1:=0 to 255 do
    Getpal (loop1,pall[loop1,1],pall[loop1,2],pall[loop1,3]);
END;

Procedure Circle (X,Y,rad:integer;Col:Byte;whe:word);
VAR x2,y2:integer;
    deg:real;
BEGIN
  deg:=0;
  repeat
    X2:=round(rad*COS (deg));
    Y2:=round(rad*sin (deg));
    putpixel (x+x2,y+y2,col,whe);
    deg:=deg+0.005;
  until (deg>6.4);
END;

procedure box(x1,y1,x2,y2:integer;col:byte;whe:word);
begin
  line(x1,y1,x1,y2,col,whe);
  line(x1,y1,x2,y1,col,whe);
  line(x2,y1,x2,y2,col,whe);
  line(x1,y2,x2,y2,col,whe);
end;

procedure WaitRetrace; assembler;

label
  l1, l2;
asm
    mov dx,3DAh
l1:
    in al,dx
    and al,08h
    jnz l1
l2:
    in al,dx
    and al,08h
    jz  l2
end;

Procedure GetPal(ColorNo : Byte; Var R,G,B : Byte);
Begin
   Port[$3c7] := ColorNo;
   R := Port[$3c9];
   G := Port[$3c9];
   B := Port[$3c9];
End;

Procedure Pal(ColorNo : Byte; R,G,B : Byte);
Begin
   Port[$3c8] := ColorNo;
   Port[$3c9] := R;
   Port[$3c9] := G;
   Port[$3c9] := B;
End;

Procedure line(a,b,c,d,col:integer;whe:word);
   Function sgn(a:real):integer;
   BEGIN
        if a>0 then sgn:=+1;
        if a<0 then sgn:=-1;
        if a=0 then sgn:=0;
   END;
var u,s,v,d1x,d1y,d2x,d2y,m,n:real;
    i:integer;
BEGIN
     u:= c - a;
     v:= d - b;
     d1x:= SGN(u);
     d1y:= SGN(v);
     d2x:= SGN(u);
     d2y:= 0;
     m:= ABS(u);
     n := ABS(v);
     IF NOT (M>N) then
     BEGIN
          d2x := 0 ;
          d2y := SGN(v);
          m := ABS(v);
          n := ABS(u);
     END;
     s := INT(m / 2);
     FOR i := 0 TO round(m) DO
     BEGIN
          putpixel(a,b,col,whe);
          s := s + n;
          IF not (s<m) THEN
          BEGIN
               s := s - m;
               a:= a +round(d1x);
               b := b + round(d1y);
          END
          ELSE
          BEGIN
               a := a + round(d2x);
               b := b + round(d2y);
          END;
     END;
END;

Procedure Fadeup;

VAR loop1,loop2:integer;
    Tmp : Array [1..3] of byte;

BEGIN
  For loop1:=1 to 64 do BEGIN
    waitretrace;
    For loop2:=0 to 255 do BEGIN
      Getpal (loop2,Tmp[1],Tmp[2],Tmp[3]);
      If Tmp[1]<Pall[loop2,1] then inc (Tmp[1]);
      If Tmp[2]<Pall[loop2,2] then inc (Tmp[2]);
      If Tmp[3]<Pall[loop2,3] then inc (Tmp[3]);
      Pal (loop2,Tmp[1],Tmp[2],Tmp[3]);
    END;
  END;
END;

Procedure FadeDown;
VAR loop1,loop2:integer;
    Tmp : Array [1..3] of byte;
BEGIN
  For loop1:=1 to 64 do BEGIN
    waitretrace;
    For loop2:=0 to 255 do BEGIN
      Getpal (loop2,Tmp[1],Tmp[2],Tmp[3]);
      If Tmp[1]>0 then dec (Tmp[1]);
      If Tmp[2]>0 then dec (Tmp[2]);
      If Tmp[3]>0 then dec (Tmp[3]);
      Pal (loop2,Tmp[1],Tmp[2],Tmp[3]);
    END;
  END;
END;

Procedure SetMCGA;
BEGIN
  asm
     mov        ax,0013h
     int        10h
  end;
END;

Procedure SetText;
BEGIN
  asm
     mov        ax,0003h
     int        10h
  end;
END;

Procedure SetUpVirtual;
BEGIN
  getmem(virscr,64000);
  vaddr := seg (virscr^);
END;

Procedure Cls (Col : Byte; Where:Word);
BEGIN
  Fillchar (Mem [where:0],64000,col);
END;

Procedure ShutDown;
BEGIN
  FreeMem (Virscr,64000);
END;

function getpixel(x,y:integer;whe:word):byte;
begin
  getpixel:=mem[whe:x+(y*320)];
end;

Procedure Putpixel (X,Y : Integer; Col : Byte; where:word);
BEGIN
  Asm
    mov     ax,[where]
    mov     es,ax
    mov     bx,[X]
    mov     dx,[Y]
    mov     di,bx
    mov     bx, dx
    shl     dx, 8
    shl     bx, 6
    add     dx, bx
    add     di, dx
    mov     al, [Col]
    stosb
  End;
END;

Procedure Flip;
BEGIN
  Move (Virscr^,mem [VGA:0],64000);
END;

end.
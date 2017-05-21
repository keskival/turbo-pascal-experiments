unit kamaa;
interface
{$X+}
USES dos,Crt;

CONST
  VGA = $a000;
  MaxSprites = 14;
  MaxDim = 25*25;

Type
  SpriteType = record
    oldx, oldy,
    x, y : integer;
    w, h : byte;
    SpriteData,
    Buffer : array [0..MaxDim-1] of byte;
    Active : boolean;
    ix, iy : integer;
  end;
  Virtual = Array [1..64000] of byte;
  VirtPtr = ^Virtual;

VAR
  Virscr : VirtPtr;
  Vaddr  : word;
  Pall  : Array[0..255,1..3] of Byte;
  Sprite : array [1..MaxSprites] of SpriteType;

procedure DrawSprites(whe:word);
procedure LoadSprite (Num : byte; FileName : string);
procedure LoadCOL (FileName : string);
procedure LoadCEL (FileName :  string; ScrPtr : pointer);
procedure DisableAllSprites;
procedure HideSprites(whe:word);
procedure FillBox (x1, y1, x2, y2 : integer; b : byte;whe:word);
procedure CopySprite (var Sprite : SpriteType; x1, y1 : integer;whe:word);
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

implementation

procedure CopySprite (var Sprite : SpriteType; x1, y1 : integer;whe:word); assembler;
label
  _Redraw, _DrawLoop, _Exit, _LineLoop, _NextLine, _Store, _NoPaint;
  asm
    push  ds
    push  es
    lds   si,Sprite
    mov   ax,x1     { ax = x }
    mov   bx,y1     { bx = y }
_Redraw:
    push  ax
    push  bx
    mov   ax,word(whe+2)
    mov   es,ax
    pop   bx
    mov   ax,320
    mul   bx
    pop   bx
    add   ax,bx
    mov   di,ax
    mov   dl,[si+9]
    xor   ch,ch
    mov   cl,[si+8]
    add   si,10
    cld
_DrawLoop:
    push  di
    push  cx
_LineLoop:
    mov   bl,byte ptr [si]
    or    bl,bl
    jnz   _Store
_NoPaint:
    inc    si
    inc    di
    loop   _LineLoop
    jmp    _NextLine
_Store:
    movsb
    loop  _LineLoop
_NextLine:
    pop   cx
    pop   di
    dec   dl
    jz    _Exit
    add   di,320
    jmp   _DrawLoop
_Exit:
    pop   es
    pop   ds
  end;

procedure SetMode (Mode : word);
begin
  asm
    mov ax,Mode;
    int 10h
  end;
end;

procedure DrawSprite (var Sprite : SpriteType;whe:word); assembler;
label
  _Redraw, _DrawLoop, _Exit, _LineLoop, _NextLine, _Store, _NoPaint;
  asm
    push  ds
    push  es
    lds   si,Sprite
    mov   ax,[si+4]
    mov   bx,[si+6]
_Redraw:
    mov   [si],ax
    mov   [si+2],bx
    push  ax
    push  bx
    mov   ax,word(whe+2)
    mov   es,ax
    pop   bx
    mov   ax,320
    mul   bx
    pop   bx
    add   ax,bx
    mov   di,ax
    mov   dl,[si+9]
    xor   ch,ch
    mov   cl,[si+8]
    add   si,10
    cld
_DrawLoop:
    push  di
    push  cx
_LineLoop:
    mov   bl,byte ptr [si]
    or    bl,bl
    jnz   _Store
_NoPaint:
    inc    si
    inc    di
    loop   _LineLoop
    jmp    _NextLine
_Store:
    movsb
    loop  _LineLoop
_NextLine:
    pop   cx
    pop   di
    dec   dl
    jz    _Exit
    add   di,320
    jmp   _DrawLoop
_Exit:
    pop   es
    pop   ds
  end;

procedure SaveSpriteBackground (var Sprite : Spritetype;whe:word); assembler;
label
  _Redraw, _DrawLoop, _Exit;
  asm
    push  ds
    push  es
    les   di,Sprite
    mov   ax,es:[di+4]
    mov   bx,es:[di+6]
    push  ax
    push  bx
    mov   ax,word(whe+2)
    mov   ds,ax
    pop   bx
    mov   ax,320
    mul   bx
    pop   bx
    add   ax,bx
    mov   si,ax
    mov   dl,es:[di+9]
    xor   ch,ch
    mov   cl,es:[di+8]
    add   di,10+MaxDim
    cld
_DrawLoop:
    push  si
    push  cx
    rep   movsb
    pop   cx
    pop   si
    dec   dl
    jz    _Exit
    add   si,320
    jmp   _DrawLoop
_Exit:
    pop   es
    pop   ds
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


procedure RestoreSpriteBackground (var Sprite : Spritetype;whe:word); assembler;
label
  _Redraw, _DrawLoop, _Exit, _LineLoop;
  asm
    push  ds
    push  es
    lds   si,Sprite
    mov   ax,[si]
    mov   bx,[si+2]
    push  ax
    push  bx
    mov   ax,word(whe+2)
    mov   es,ax
    pop   bx
    mov   ax,320
    mul   bx
    pop   bx
    add   ax,bx
    mov   di,ax
    mov   dl,[si+9]
    xor   ch,ch
    mov   cl,[si+8]
    add   si,10+MaxDim
    cld
_DrawLoop:
    push  di
    push  cx
    rep   movsb
    pop   cx
    pop   di
    dec   dl
    jz    _Exit
    add   di,320
    jmp   _DrawLoop
_Exit:
    pop   es
    pop   ds
  end;

procedure DrawSprites(whe:word);
var
  I : byte;
begin
  for I := MaxSprites downto 1 do
    if (Sprite[I].Active) and (Sprite [I].oldx <> -1) then
      RestoreSpriteBackground (Sprite [I],whe);
  for I := 1 to MaxSprites do begin
    if Sprite [I].Active then begin
      SaveSpriteBackground (Sprite [I],whe);
      DrawSprite (Sprite [I],whe);
    end;
  end;
end;

procedure HideSprites(whe:word);
var
  I : byte;
begin
  for I := MaxSprites downto 1 do
    if (Sprite [I].oldx <> -1) then begin
      RestoreSpriteBackground (Sprite [I],whe);
      Sprite [I].oldx := -1;
    end;
end;

procedure LoadSprite (Num : byte; FileName : string);
var
  Fil : text;
  fx, fy : word;
begin
  assign (Fil, FileName);
  reset (Fil);
  fillchar (Sprite [Num], sizeof (Sprite[1]), 0);
  with Sprite [Num] do begin
    oldx := integer ($FFFF);
    readln (Fil, w, h);
    for fy := 1 to h do begin
      for fx := 1 to w do
        read (Fil, SpriteData [pred (fy) * w + pred (fx)]);
      readln (fil);
    end;
  end;
  close (Fil);
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

procedure DisableAllSprites;
var
  I : integer;
begin
  for I := 1 to MaxSprites do
    with Sprite [I] do begin
      OldX := -1;
      Active := FALSE;
    end;
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

begin
  DisableAllSprites;
end.

program teronspriteyritys;

uses crt,graph;
var
   key:integer;
   x,y:integer;
   looppix,vaaka,pysty:integer;
   vari:byte;

procedure vgapaalle; assembler;

  asm
    mov ax, 0013h
    int 10h
  end;

procedure pset (vaaka, pysty : integer; vari : byte); far;

  begin
    mem[$A000:vaaka + pysty * 320] := vari;
  end;

function pget (vaaka, pysty : integer): byte; far;

  begin
    pget:=mem[$A000:vaaka + pysty * 320];
  end;
begin
  vgapaalle;
  repeat
  if keypressed=true then key:=1;
  until key=1;
  end.

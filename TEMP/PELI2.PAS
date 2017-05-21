program teronspriteyritys;

var
   vaaka,pysty:integer;
   vari:byte;

procedure vgap„„lle; assembler;

  asm
    mov ax, 0013h
    int 10h
  end;

procedure Pset (vaaka, pysty : integer; vari : byte); far;

  begin
    mem[$A000:vaaka + pysty * 320] := vari;
  end;


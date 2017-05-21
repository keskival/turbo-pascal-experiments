program piste;

var
   a:string;
   b:longint;
   c:longint;
   vaaka,pysty:integer;
   x,y:integer;
   vari:byte;

procedure VGA; assembler;

  asm
    mov ax, 0013h
    int 10h
  end;

procedure Pset (vaaka, pysty : integer; vari : byte); far;

  begin
    mem[$A000:vaaka + pysty * 320] := vari;
  end;

begin
     vga;
     for c:=0 to 320 do
     for b:=0 to 200 do pset(c,b,c);
     readln(a)
end.

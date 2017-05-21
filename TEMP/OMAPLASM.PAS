program plasma;

const
  puntype:integer=3;
  sintype:integer=4;
  tyhja:integer=16;

type
    pplace=array [0..(1000)] of integer;
    cellpointer=^celtype;
    celtype=record
            vari:byte;
            lapsfiffif:boolean;
            next:cellpointer;
            paikka:longint;
    end;

var
  numero:integer;
  position:longint;

procedure initvga; assembler;

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

procedure alusta;
  begin
    initvga;
    for position:=0 to (1000) do
    begin
      numero:=random(3);
      case numero of
        1:pplace(position):=puntype;
        2:pplace(position):=sintype;
        3:pplace(position):=tyhja;
      end;
    end;
  for position:=0 to (1000) do
  begin
    pset(position,0,pplace(position));
  end;

  begin
  alusta;
  repeat
  until keypressed=true;
end.

Program nappis;
uses crt;
var nuoli : char;
    x,y   : byte;

procedure rata;
begin
clrscr;
gotoxy (x,y);
write ('0');
end;

procedure ohjaus;
begin
   nuoli := readkey;
    IF nuoli = '6' then x := x+1;
      IF  nuoli ='4' then x := x-1;
        IF nuoli ='2' then y := y+1;
          IF nuoli ='8' then y := y-1;
 if x < 10 then x := 10;
 if x > 35 then x := 35;
 if y < 10 then y := 10;
 if y > 20 then y := 20;
end;   { n„ppis  }

procedure ikkuna;
begin
 textbackground(blue);
 textcolor(green);
end;

begin {p„„ohjelma}
clrscr;
x:=10;
y:=10;
 repeat;
   ikkuna;
   ohjaus;
   rata;
 until nuoli = 'q';
end.
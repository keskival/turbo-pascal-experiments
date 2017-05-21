program simu;
uses crt;

var
  odotus:real;
  vapaa,pois,i,oikein:integer;

procedure play;
begin
  vapaa:=random(3)+1;
  if vapaa=1 then pois:=random(2)+2;
  if vapaa=2 then pois:=3;
  if vapaa=3 then pois:=2;
  if (vapaa=3)and(pois=2) then oikein:=oikein+1;
  if pois=2 then i:=i+1;
  odotus:=oikein/i;
  writeln(odotus);
end;

begin
  randomize;
  i:=1;
  repeat
    play;
  until keypressed;
end.
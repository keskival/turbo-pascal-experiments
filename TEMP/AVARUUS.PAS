program avaruus;
uses kamaa,crt;

type
  starinfo=record
    x,y:integer;
    size:integer;
    minerals:integer;
  end;

var
  b,i:integer;
  onjo:boolean;
  space:array[1..20] of starinfo;

procedure alusta;
label alku;
begin
  for i:=1 to 20 do
  begin
    alku:onjo:=false;
    space[i].x:=random(319);
    space[i].y:=random(199);
    for b:=1 to i-1 do
    begin
      if (space[i].x=space[b].x)and(space[i].y=space[b].y) then onjo:=true;
    end;
    if onjo=true then goto alku;
    waitretrace;
    cls(16);
    putpixel(space[i].x,space[i].y,15);
  end;
end;

begin
  setmcga;
  repeat
  alusta;
  until keypressed=true;
end.

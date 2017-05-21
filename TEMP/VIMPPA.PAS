program thrddmns;
uses tpr,graph;

const
  gd:integer=detect;

var
  rand,gm,the,ro:integer;
  x,y:real;

procedure init;
begin
  initgraph(gd,gm,'c:\turbo\bgi');
  cleardevice;
end;

begin
  randomize;
  init;
  for ro:=200 downto 1 do
  begin
    for the:=0 to 100 do
    begin

      x:=ddx(the-10,ro);
      y:=ddy(the+10,ro);
      putpixel(round(319+x),round(239+y),the);
    end;
  end;
readln;
end.

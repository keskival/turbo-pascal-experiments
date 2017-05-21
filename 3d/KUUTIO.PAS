program hojo;
uses crt,unit3d;

var
  x1,y1,x2,y2,x3,y3,x4,y4:integer;
  c1,c2,c3,c4:byte;
  x1su,x2su,x3su,x4su,y1su,y2su,y3su,y4su:integer;

procedure play;
begin
  gpolygon(x1,y1,x2,y2,x3,y3,x4,y4,c1,c2,c3,c4,vaddr);
  flip;
  cls(0,vaddr);

  if (x1+x1su<0)or(x1+x1su>319) then x1su:=-x1su;
  if (x2+x2su<0)or(x2+x2su>319) then x2su:=-x2su;
  if (x3+x3su<0)or(x3+x3su>319) then x3su:=-x3su;
  if (x4+x4su<0)or(x4+x4su>319) then x4su:=-x4su;
  if (y1+y1su<0)or(y1+y1su>199) then y1su:=-y1su;
  if (y2+y2su<0)or(y2+y2su>199) then y2su:=-y2su;
  if (y3+y3su<0)or(y3+y3su>199) then y3su:=-y3su;
  if (y4+y4su<0)or(y4+y4su>199) then y4su:=-y4su;

  x1:=x1+x1su;
  x2:=x2+x2su;
  x3:=x3+x3su;
  x4:=x4+x4su;
  y1:=y1+y1su;
  y2:=y2+y2su;
  y3:=y3+y3su;
  y4:=y4+y4su;

end;


begin
  randomize;
  setmcga;
  setupvirtual;
  cls(0,vaddr);
  x1:=random(319);
  x2:=random(319);
  x3:=random(319);
  x4:=random(319);
  y1:=random(199);
  y2:=random(199);
  y3:=random(199);
  y4:=random(199);

  c1:=random(255);
  c2:=random(255);
  c3:=random(255);
  c4:=random(255);

  x1su:=-1;
  x2su:=1;
  x3su:=-1;
  x4su:=1;
  y1su:=1;
  y2su:=-1;
  y3su:=1;
  y4su:=-1;

  repeat
    play;
  until keypressed;
  settext;
  shutdown;
end.
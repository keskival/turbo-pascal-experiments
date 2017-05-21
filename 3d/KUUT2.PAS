program hojo;
uses crt,unit3d;

var
  x1,y1,x2,y2,x3,y3,x4,y4,x5,x6,y5,y6:integer;
  c1,c2,c3,c4,c5,c6:byte;
  c1su,c2su,c3su,c4su,c5su,c6su:integer;
  x1su,x2su,x3su,x4su,x5su,x6su,y1su,y2su,y3su,y4su,y5su,y6su:integer;

procedure play;
begin
  gkolm(x1,y1,x2,y2,x3,y3,c1,c2,c3,vaddr);
  gkolm(x4,y4,x5,y5,x6,y6,c4,c5,c6,vaddr);
  flip;
  cls(0,vaddr);

  if (x1+x1su<0)or(x1+x1su>319) then x1su:=-x1su;
  if (x2+x2su<0)or(x2+x2su>319) then x2su:=-x2su;
  if (x3+x3su<0)or(x3+x3su>319) then x3su:=-x3su;
  if (x4+x4su<0)or(x4+x4su>319) then x4su:=-x4su;
  if (x5+x5su<0)or(x5+x5su>319) then x5su:=-x5su;
  if (x6+x6su<0)or(x6+x6su>319) then x6su:=-x6su;
  if (y1+y1su<0)or(y1+y1su>199) then y1su:=-y1su;
  if (y2+y2su<0)or(y2+y2su>199) then y2su:=-y2su;
  if (y3+y3su<0)or(y3+y3su>199) then y3su:=-y3su;
  if (y4+y4su<0)or(y4+y4su>199) then y4su:=-y4su;
  if (y5+y5su<0)or(y5+y5su>199) then y5su:=-y5su;
  if (y6+y6su<0)or(y6+y6su>199) then y6su:=-y6su;
  if (c1+c1su<0)or(c1+c1su>255) then c1su:=-c1su;
  if (c2+c2su<0)or(c2+c2su>255) then c2su:=-c2su;
  if (c3+c3su<0)or(c3+c3su>255) then c3su:=-c3su;
  if (c4+c4su<0)or(c4+c4su>255) then c4su:=-c4su;
  if (c5+c5su<0)or(c5+c5su>255) then c5su:=-c5su;
  if (c6+c6su<0)or(c6+c6su>255) then c6su:=-c6su;

  x1:=x1+x1su;
  x2:=x2+x2su;
  x3:=x3+x3su;
  x4:=x4+x4su;
  x5:=x5+x5su;
  x6:=x6+x6su;
  y1:=y1+y1su;
  y2:=y2+y2su;
  y3:=y3+y3su;
  y4:=y4+y4su;
  y5:=y5+y5su;
  y6:=y6+y6su;

  c1:=c1+c1su;
  c2:=c2+c2su;
  c3:=c3+c3su;
  c4:=c4+c4su;
  c5:=c5+c5su;
  c6:=c6+c6su;

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
  x5:=random(319);
  x6:=random(319);
  y1:=random(199);
  y2:=random(199);
  y3:=random(199);
  y4:=random(199);
  y5:=random(199);
  y6:=random(199);

  c1:=random(255);
  c2:=random(255);
  c3:=random(255);
  c4:=random(255);
  c5:=random(255);
  c6:=random(255);
  c1su:=1;
  c2su:=-1;
  c3su:=1;
  c4su:=-1;
  c5su:=1;
  c6su:=-1;

  x1su:=-1;
  x2su:=1;
  x3su:=-1;
  x4su:=1;
  x5su:=-1;
  x6su:=1;
  y1su:=1;
  y2su:=-1;
  y3su:=1;
  y4su:=-1;
  y5su:=1;
  y6su:=-1;

  repeat
    play;
  until keypressed;
  settext;
  shutdown;
end.
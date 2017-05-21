program nelikulmio;
uses unit3d,crt;

var
  x1,y1,x2,y2,x3,y3,x4,y4:integer;
  c1,c2,c3,c4:byte;
  x1su,x2su,x3su,x4su,y1su,y2su,y3su,y4su:integer;

procedure nelikulm(x1,y1,x2,y2,x3,y3,x4,y4:integer;c1,c2,c3,c4:byte;where:word);
var
  x,y:array[1..4]of integer;
  c:array[1..4]of byte;
  i,j,apu:integer;

begin
  y[1]:=y1;
  y[2]:=y2;
  y[3]:=y3;
  y[4]:=y4;
  x[1]:=x1;
  x[2]:=x2;
  x[3]:=x3;
  x[4]:=x4;
  c[1]:=c1;
  c[2]:=c2;
  c[3]:=c3;
  c[4]:=c4;

  for i:=1 to 3 do
  for j:=i+1 to 4 do
  begin
    if y[i]>y[j] then
    begin
      apu:=x[i];
      x[i]:=x[j];
      x[j]:=apu;
      apu:=y[i];
      y[i]:=y[j];
      y[j]:=apu;
      apu:=c[i];
      c[i]:=c[j];
      c[j]:=apu;
    end;
  end;
  gkolm(x[1],y[1],x[2],y[2],x[3],y[3],c[1],c[2],c[3],where);
  gkolm(x[2],y[2],x[3],y[3],x[4],y[4],c[2],c[3],c[4],where);
end;

procedure play;
begin
  nelikulm(x1,y1,x2,y2,x3,y3,x4,y4,c1,c2,c3,c4,vaddr);
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

  repeat play;
  until keypressed;
  shutdown;
  settext;
end.
program robo;
uses unit3d,crt;

const
  maara=300;

var
  x,y,valo:array[1..maara]of real;
  xt,yt,i,g,j,h:integer;
  viive:longint;

procedure play;
begin
  for i:=1 to maara do
  begin
    if ((x[i]-xt)*(y[i]-yt))<>0 then valo[i]:=+1/(sqr(x[i]-xt)+sqr(y[i]-yt))
    else valo[i]:=1;
  end;
  cls(0,vaddr);
  for i:=1 to maara do
  begin
    g:=i;
    for j:=1 to maara do
    begin
      if valo[i]<valo[j] then
      begin
      if (x[j]+40-random(80))>x[i] then x[i]:=x[i]+0.03;
      if (x[j]+40-random(80))<x[i] then x[i]:=x[i]-0.03;
      if (y[j]+40-random(80))>y[i] then y[i]:=y[i]+0.03;
      if (y[j]+40-random(80))<y[i] then y[i]:=y[i]-0.03;
      end;
    end;
    for j:=1 to maara do
    begin
      if valo[i]>valo[j] then
      begin
      if (x[j]+40-random(80))>x[i] then x[i]:=x[i]-0.005;
      if (x[j]+40-random(80))<x[i] then x[i]:=x[i]+0.005;
      if (y[j]+40-random(80))>y[i] then y[i]:=y[i]-0.005;
      if (y[j]+40-random(80))<y[i] then y[i]:=y[i]+0.005;
      end;
    end;
    if x[i]>319 then x[i]:=319;
    if x[i]<0 then x[i]:=0;
    if y[i]>199 then y[i]:=199;
    if y[i]<0 then y[i]:=0;


  end;

  for i:=1 to maara do
  begin
    putpixel(round(x[i]),round(y[i]),6,vaddr);
  end;
    putpixel(round(xt),round(yt),9,vaddr);
  flip;
end;
begin
  randomize;
  for i:=1 to maara do
  begin
    xt:=random(319);
    yt:=random(199);
    x[i]:=random(319);
    y[i]:=random(199);
  end;
  setmcga;
  setupvirtual;
  cls(0,vaddr);
  repeat for h:=0 to 42 do play;
  for i:=1 to maara do
  begin
    xt:=160;
    yt:=100;
    x[i]:=random(319);
    y[i]:=random(199);
  end;

  until keypressed;
  settext;
  shutdown;
end.

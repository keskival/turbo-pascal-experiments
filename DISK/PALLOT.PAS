program pallot;
uses crt,kamaa;
var
  i:integer;
  x,y,xsu,ysu:array[0..70]of real;
  e:real;
  loop:longint;
  edex,edey:integer;

procedure play;
begin
  for i:=0 to 70 do
  begin
    edey:=round(y[i]);
    edex:=round(x[i]);
    if (x[i]<2)or(x[i]>317) then xsu[i]:=-xsu[i];
    if (y[i]<2)or(y[i]>197) then ysu[i]:=-ysu[i];
    x[i]:=round(x[i]+xsu[i]);
    y[i]:=round(y[i]+ysu[i]);
    if getpixel(round(x[i]),round(y[i]),vga)<>0 then begin
      xsu[i]:=-xsu[i];
      ysu[i]:=-ysu[i];
    end;
    putpixel(edex,edey,0,vga);
    putpixel(round(x[i]),round(y[i]),i,vga);
  end;
{  putpixel(round(x[1]-xsu[1]),round(y[1]-ysu[1]),0,vga);
  putpixel(round(x[36]-xsu[36]),round(y[36]-ysu[36]),0,vga);
}  for loop:=1 to 100000 do;
end;

begin
  setmcga;
  for i:=0 to 35 do
  begin
    xsu[i]:=1;
    ysu[i]:=2;
    x[i]:=random(315)+2;
    y[i]:=random(195)+2;
  end;
  for i:=36 to 70 do
  begin
    xsu[i]:=2;
    ysu[i]:=1;
    x[i]:=random(315)+2;
    y[i]:=random(195)+2;
    e:=e+2;
  end;
  repeat
    play;
  until keypressed;
  settext;
end.

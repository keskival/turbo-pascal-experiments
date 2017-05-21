program virrat;
uses unit3d,crt;

var
  vari,z,i,j,g:integer;
  mattox:array[0..100,0..200]of byte;
  mattoy:array[0..100,0..200]of byte;

procedure sotke;
begin
  z:=0;
  for i:=0 to 99 do for j:=0 to 199 do
  begin
    putpixel(i,j,random(255),vaddr);
  end;
  flip;
end;

procedure virtaa;
begin
  for i:=0 to 99 do for j:=0 to 199 do
  begin
    vari:=round((getpixel(i+mattox[i,j]-2,j+mattoy[i,j]-2,vga)
      +getpixel(i+mattox[i,j]-3+random(3),j+mattoy[i,j]-3+random(3),vga))/3);
    putpixel(i,j,vari,vaddr);
  end;
  flip;
end;

procedure alusta;
begin
  randomize;
  for i:=0 to 10 do for j:=0 to 20 do
  begin
    mattox[i*10,j*10]:=random(5);
    if mattox[i*10,j*10]=2 then mattox[i*10,j*10]:=3;
    mattoy[i*10,j*10]:=random(5);
    if mattoy[i*10,j*10]=2 then mattoy[i*10,j*10]:=3;
  end;
  for i:=0 to 10 do for j:=0 to 19 do
  begin
    for g:=1 to 9 do
    begin
      mattox[i*10,j*10+g]:=round(mattox[i*10,j*10+10]+(mattox[i*10,j*10+10]-mattox[i*10,j*10])/10*g);
      if mattox[i*10,j*10+g]=2 then mattox[i*10,j*10+g]:=3;
      mattoy[i*10,j*10+g]:=round(mattoy[i*10,j*10+10]+(mattoy[i*10,j*10+10]-mattoy[i*10,j*10])/10*g);
      if mattoy[i*10,j*10+g]=2 then mattoy[i*10,j*10+g]:=3;
    end;
  end;
  for i:=0 to 9 do for j:=0 to 200 do
  begin
    for g:=1 to 9 do
    begin
      mattox[i*10+g,j]:=round(mattox[i*10+10,j]+(mattox[i*10+10,j]-mattox[i*10,j])/10*g);
      if mattox[i*10+g,j]=2 then mattox[i*10+g,j]:=3;
      mattoy[i*10+g,j]:=round(mattoy[i*10+10,j]+(mattoy[i*10+10,j]-mattoy[i*10,j])/10*g);
      if mattoy[i*10+g,j]=2 then mattoy[i*10+g,j]:=3;
    end;
  end;

end;

procedure play;
begin
  virtaa;
end;

begin
  alusta;
  setmcga;
  setupvirtual;
  cls(0,vaddr);
  z:=0;
  for i:=0 to 63 do pal(i,i,i,i);
  repeat
    play;
    z:=z+1;
    if z=10 then sotke;
  until keypressed;
  settext;
  shutdown;
end.
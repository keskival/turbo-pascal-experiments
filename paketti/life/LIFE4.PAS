program life;
uses unit3d,crt;

var
  ruutu:array[0..319,0..199]of byte;
  i,j,a:integer;

procedure alusta;
begin
  setmcga;
  setupvirtual;
  cls(0,vaddr);
  randomize;
  pal(1,63,63,1);
  for i:=1 to 318 do
{  for j:=1 to 198 do if random(8)=1 then putpixel(i,j,1,vaddr);}
  putpixel(11,12,1,vaddr);
  putpixel(14,12,1,vaddr);
  putpixel(15,13,1,vaddr);
  putpixel(15,14,1,vaddr);
  putpixel(11,14,1,vaddr);
  putpixel(12,15,1,vaddr);
  putpixel(13,15,1,vaddr);
  putpixel(14,15,1,vaddr);
  putpixel(15,15,1,vaddr);

  putpixel(11,19,1,vaddr);
  putpixel(12,20,1,vaddr);
  putpixel(13,20,1,vaddr);
  putpixel(13,21,1,vaddr);
  putpixel(13,22,1,vaddr);
  putpixel(12,23,1,vaddr);

  putpixel(11,26,1,vaddr);
  putpixel(14,26,1,vaddr);
  putpixel(15,27,1,vaddr);
  putpixel(15,28,1,vaddr);
  putpixel(11,28,1,vaddr);
  putpixel(12,29,1,vaddr);
  putpixel(13,29,1,vaddr);
  putpixel(14,29,1,vaddr);
  putpixel(15,29,1,vaddr);
  flip;
  for i:=1 to 318 do
  for j:=1 to 198 do
  begin
    ruutu[i,j]:=getpixel(i,j,vaddr);
  end;
end;

procedure play;
begin
  for i:=1 to 318 do
  for j:=1 to 198 do
  begin
    a:=ruutu[i-1,j-1];
    a:=a+ruutu[i,j-1];
    a:=a+ruutu[i+1,j-1];
    a:=a+ruutu[i-1,j];
    a:=a+ruutu[i+1,j];
    a:=a+ruutu[i+1,j+1];
    a:=a+ruutu[i,j+1];
    a:=a+ruutu[i-1,j+1];
    putpixel(i,j,0,vaddr);
    if (ruutu[i,j]=1)and((a>1)and(a<4)) then
    begin
      putpixel(i,j,1,vaddr);
    end;
    if (ruutu[i,j]=0)and(a=3) then
    begin
      putpixel(i,j,1,vaddr);
    end;
  end;
  for i:=1 to 318 do
  for j:=1 to 198 do
  begin
    ruutu[i,j]:=getpixel(i,j,vaddr);
    if random(900)=1 then ruutu[i,j]:=1;
  end;
  flip;
end;

begin
  alusta;
  repeat play;
  until keypressed;
  shutdown;
  settext;
end.
program fire;
uses unit3d,crt;

var
  ii,i,j,apu,a,b:integer;
  c,axa,yy:real;
  randomi:array[0..19200]of boolean;
  sini:array[0..1000]of real;

procedure sumenna;
label Loop;
begin
  asm
    les di, virscr
    add di, 320
    mov cx, 63360
    xor ax, ax
    xor bx, bx
  end;
  Loop:
  asm
    mov al, [es:di-1]
    mov bl, [es:di+1]
    add ax, bx
    mov bl, [es:di-320]
    add ax, bx
    mov bl, [es:di+320]
    add ax, bx
    shr ax, 2
    stosb
    loop Loop
  end;
end;

procedure play;

begin
  c:=c+0.1;
  axa:=sini[(round(c*159)) mod 1000]*sini[(round(c*83+130)) mod 1000]*140;
  yy:=sini[(round(c*97+153)) mod 1000]*sini[(round(c*107)) mod 1000]*80;
  for i:=1 to 318 do
  begin
    for j:=1 to 198 do
    begin
      ii:=ii+1;
      if ii=19201 then ii:=0;
      if randomi[ii] then putpixel(i,j,255,vaddr);
    end;
  end;
  for i:=150+round(-axa) to 170+round(-axa) do
  begin
    for j:=90+round(-yy) to 110+round(-yy) do putpixel(i,j,255,vaddr);
  end;
  for i:=150+round(axa) to 170+round(axa) do
  begin
    for j:=90+round(yy) to 110+round(yy) do putpixel(i,j,255,vaddr);
  end;
{  if (a+asu<-139)or(a+asu>159) then asu:=-asu;
  a:=a+asu;
  if (b+bsu<-89)or(b+bsu>89) then bsu:=-bsu;
  b:=b+bsu;}

  sumenna;
  sumenna;
  sumenna;
  sumenna;
  sumenna;
  sumenna;
  flip;

end;

begin
  setmcga;
  ii:=0;
  for i:=0 to 1000 do
  begin
    sini[i]:=sin(i*0.00628318530718);
  end;
  for i:=0 to 19200 do
  begin
    if random(60)=1 then randomi[i]:=true
    else randomi[i]:=false;
  end;
  a:=0;
  b:=0;
  setupvirtual;
  cls(0,vaddr);
  for apu:=0 to 63 do pal(apu,round(apu),0,0);
  for apu:=64 to 127 do pal(apu,63,round(apu),0);
  for apu:=128 to 191 do pal(apu,63,63,round(apu));
  for apu:=192 to 255 do pal(apu,63,63,63);
  randomize;
  for i:=1 to 319 do
  begin
    for j:=1 to 198 do putpixel(i,j,random(254),vaddr);
  end;
  repeat play;
  until keypressed;
  settext;
  shutdown;
end.
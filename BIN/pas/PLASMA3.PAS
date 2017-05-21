program fire;
uses unit3d,crt;

var
  i,j,apu,a,asu,b,bsu:integer;
  virtu:word;
  c,axa,yy:real;
  apuruutu:array[0..319,0..199]of byte;

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
{  for i:=1 to 319 do
  begin
    for j:=1 to 198 do if random(30)=1 then putpixel(i,j,255,vaddr);
  end;}
  c:=c+0.001;
  axa:=sqr(sin(c))*140;
  yy:=sqr(cos(c*0.98))*90;
  for i:=150+round(axa) to 170+round(axa) do
  begin
    for j:=90+round(yy) to 110+round(yy) do if random(5)=1 then putpixel(i,j,255,vaddr);
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
  sumenna;
  sumenna;
  waitretrace;
  flip;

end;

begin
  setmcga;
  asu:=4;
  a:=0;
  bsu:=3;
  b:=0;
  setupvirtual;
  cls(0,vaddr);
  virtu:=vaddr;
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
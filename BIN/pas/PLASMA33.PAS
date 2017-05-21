program fire;
uses unit3d,crt,dos;

var
  ii,i,j,apu,a,b:integer;
  c,axa,yy:real;
  ax,yyy,ykk,nappi:word;
  randomi:array[0..19200]of boolean;
  sini:array[0..1000]of real;

procedure luetila (var x,y,nappi1,nappi2 : word);
var regs : registers ;
    stop : integer;
begin
  regs.ax:=3;
  intr(51,regs);
  x:=regs.cx;
  y:=regs.dx;
  nappi1:=(regs.bx and 1);
  nappi2:=(regs.bx and 2) shr 1;
end;

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
    mov bl, [es:di]
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
  luetila(ax,yyy,nappi,ykk);
  axa:=ax*0.4699367+1;
  yy:=yyy*0.921875+1;
  if axa<1 then axa:=1;
  if axa>298 then axa:=298;
  if yy<1 then yy:=1;
  if yy>178 then yy:=178;
  for i:=1 to 318 do
  begin
    for j:=1 to 198 do
    begin
      ii:=ii+1;
      if ii=19201 then ii:=0;
      if randomi[ii] then putpixel(i,j,255,vaddr);
    end;
  end;
  if nappi=1 then for i:=round(axa) to 20+round(axa) do
  begin
    for j:=round(yy) to 20+round(yy) do putpixel(i,j,255,vaddr);
  end;
  if (ykk=1)and(nappi=0) then for i:=round(axa)+5 to 15+round(axa) do
  begin
    for j:=round(yy)+5 to 15+round(yy) do putpixel(i,j,255,vaddr);
  end;
  if (nappi=0)and(ykk=0) then
  for i:=round(axa)+8 to 12+round(axa) do
  begin
    for j:=round(yy)+8 to 12+round(yy) do putpixel(i,j,255,vaddr);
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
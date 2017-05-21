program fire;
uses unit3d,crt;

var
  apu:integer;
  virtu:word;
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
var
  i,j:integer;

begin
  for i:=1 to 319 do
  begin
    for j:=1 to 198 do if random(20)=8 then putpixel(i,j,random(254),vaddr);
  end;
  sumenna;
  sumenna;
  sumenna;
  sumenna;
  waitretrace;
  flip;

end;

begin
  setmcga;
  setupvirtual;
  cls(0,vaddr);
  virtu:=vaddr;
  for apu:=0 to 255 do pal(apu,round((300-apu)/4),0,0);
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
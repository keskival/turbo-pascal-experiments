program fire;
uses unit3d,crt;

var
  x1,y1,x2,y2,x1su,x2su,y1su,y2su:real;
  apu:integer;

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
  if (x1+x1su<2)or(x1+x1su>317) then x1su:=-x1su;
  if (x2+x2su<2)or(x2+x2su>317) then x2su:=-x2su;
  if (y1+y1su<2)or(y1+y1su>197) then y1su:=-y1su;
  if (y2+y2su<2)or(y2+y2su>197) then y2su:=-y2su;
  x1:=x1+x1su;
  x2:=x2+x2su;
  y1:=y1+y1su;
  y2:=y2+y2su;
  line(round(x1),round(y1),round(x2),round(y2),255,vaddr);
  sumenna;
  waitretrace;
  flip;

end;

begin
  setmcga;
  setupvirtual;
  randomize;
  x1:=random(319);
  x2:=random(319);
  y1:=random(199);
  y2:=random(199);
  x1su:=0.9;
  x2su:=-0.6;
  y1su:=-0.5;
  y2su:=1;
  cls(0,vaddr);
  cls(0,vga);
  for apu:=0 to 255 do pal(apu,round((apu)/4),0,0);
  randomize;
  repeat play;
  until keypressed;
  settext;
  shutdown;
end.
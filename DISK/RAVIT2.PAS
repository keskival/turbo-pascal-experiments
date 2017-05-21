{$i-}
program Ravia;
uses graf,crt,dos;

const
  Gseg = $A000;

type
  pcxheader = record
    manufacturer,version,encoding,bits_per_pixel : byte;
    xmin,ymin,xmax,ymax,hres,vres : word;
    palette : array[0..47] of byte;
    reserved : byte;
    color_planes : byte;
    bytes_per_line : word;
    palette_type : word;
    filler : array[0..57] of byte;
  end;

var
  p,nopeus,pistmaara,alust,h,j,g,apu,f,d,i:integer;
  voit,voittaja,heppa:array[0..15]of integer;
  loppu,uusi:boolean;
  viive:longint;
  pcxfile : file;
  header : pcxheader;
  Str80 : string[80];
  BufTp : array[0..4095] of byte;
  PalBuf : array[0..$2ff] of byte;
  a:char;
  edepaikka,paikka:byte;
  painettu:boolean;

procedure error(errstr : string);
begin
  writeln(errstr);
  halt;
end;

{----------------------------------------------------------------------------}

function validpcx : boolean;
begin
  seek(pcxfile,0);
  blockread(pcxfile,header,sizeof(header));
  with header do validpcx := (manufacturer = 10) and (version = 5) and
    (bits_per_pixel = 8) and (color_planes = 1);
end;

{----------------------------------------------------------------------------}

function validpal : boolean;
var v : byte;
begin
  seek(pcxfile,filesize(pcxfile)-769);
  blockread(pcxfile,v,1);
  validpal := v = $0c;
end;

{----------------------------------------------------------------------------}

procedure setvideo(md : word); assembler;
asm
  mov ax,md
  int 10h
end;

{----------------------------------------------------------------------------}

procedure setpal;
var pal : array[0..767] of byte;
begin
  seek(pcxfile,filesize(pcxfile)-768);
  blockread(pcxfile,pal,768);
  asm
    cld
    xor di,di
    xor bx,bx
   @L1:
    mov dx,03c8h
    mov ax,bx
    out dx,al
    inc dx
    mov cx,3
   @L2:
    mov al,byte ptr pal[di]
    shr al,1
    shr al,1
    out dx,al
    inc di
    loop @L2
    inc bx
    cmp bx,256
    jne @L1
  end;
end;

{----------------------------------------------------------------------------}

procedure unpack;
var gofs,j : word; i,k,v,loop : byte;
begin
  seek(pcxfile,128);
  gofs := 0;
  for i := 0 to header.ymax-header.ymin+1 do begin
    j := 0;
    while j < header.bytes_per_line do begin
      blockread(pcxfile,v,1);
      if (v and 192) = 192 then begin
        loop := v and 63;
        inc(j,loop);
        blockread(pcxfile,v,1);
        for k := 1 to loop do begin
          mem[gseg:gofs] := v;
          inc(gofs);
        end;
      end
      else begin
        mem[gseg:gofs] := v;
        inc(gofs);
        inc(j);
      end;
    end;
  end;
end;

procedure lataakuva;
begin
  if 'valikko.pcx' = '' then error('Enter filename on commandline.');
  assign(pcxfile,'valikko.pcx');
  reset(pcxfile,1);
  if ioresult <> 0 then error('valikko.pcx'+' not found.');
  if not validpcx then error('Not a 256 color PCX file.');
  if not validpal then error('Palette corrupt.');
  setpal;
  unpack;
  close(pcxfile);
end;

procedure ylos;
begin
 edepaikka:=paikka;
 paikka:=paikka-1;
 if paikka=255 then paikka:=0;
 pal(edepaikka+1,255,255,255);
 pal(paikka+1,255,0,0);
end;

procedure alas;
begin
 edepaikka:=paikka;
 paikka:=paikka+1;
 if paikka=3 then paikka:=2;
 pal(edepaikka+1,255,255,255);
 pal(paikka+1,255,0,0);
end;

procedure painetaan;
begin
  painettu:=true;
end;

procedure alusta;
begin
  randomize;
  setmcga;
  cls(18,vga);
  line(319,0,319,199,11,vga);
end;

procedure play;
begin
  loppu:=false;
  i:=random(pistmaara);
  heppa[i]:=heppa[i]+1;
  if heppa[i]=319 then loppu:=true;
  putpixel(heppa[i]-1,i*(pistmaara-1)+40,18,vga);
  putpixel(heppa[i],i*(pistmaara-1)+40,i+1,vga);
  if keypressed then loppu:=true;
  for viive:=0 to (nopeus*20000) do;
end;

procedure ravit;
begin
  alusta;
  repeat
    play;
  until loppu=true;
  loppu:=false;
  settext;
  for g:=0 to pistmaara-1 do voittaja[g]:=heppa[g];
  for f:=0 to pistmaara-2 do begin
    for d:=f+1 to pistmaara-1 do
    begin
      if voittaja[d]<voittaja[f] then
      begin
        apu:=voittaja[f];
        voittaja[f]:=voittaja[d];
        voittaja[d]:=apu;
      end;
    end;
  end;
  for h:=0 to pistmaara-1 do
  begin
    for j:=0 to pistmaara-1 do
    begin
      if voittaja[h]=heppa[j] then apu:=j;
    end;
    voit[h]:=apu+1;
    heppa[apu]:=999;
  end;
  for p:=0 to pistmaara-2 do writeln((pistmaara-2)-p+2,'. oli piste nro: ',voit[p],'.');
  writeln('Piste numero ',voit[pistmaara-1],' voitti!');
  readkey;
end;

procedure options;
begin
  settext;
  writeln('Sy”t„ pisteiden m„„r„ (3-10)');
  readln(pistmaara);
  if pistmaara>10 then pistmaara:=10;
  if pistmaara<3 then pistmaara:=3;
end;
procedure valik;
begin
  setmcga;
  uusi:=false;
  lataakuva;
  paikka:=0;
  pal(1,255,0,0);
  pal(2,255,255,255);
  pal(3,255,255,255);
  repeat
    if keypressed then a:=readkey;
    if a='H' then ylos;
    if a='P' then alas;
    if a=' ' then painetaan;
    a:='q';
  until painettu;
  if paikka=0 then begin
    ravit;
    uusi:=true;
    for alust:=0 to 15 do heppa[alust]:=0;
    painettu:=false;
  end;
  if paikka=1 then begin
    options;
    uusi:=true;
    painettu:=false;
  end;
end;

begin
  nopeus:=1;
  pistmaara:=6;
  repeat valik;
  until uusi=false;
  settext;
  writeln('This piece of crap was made by Tero Keski-Valkama...');
  writeln('And not to forget Mika Keski-Valkama, who made the');
  writeln('cool picture.');
end.

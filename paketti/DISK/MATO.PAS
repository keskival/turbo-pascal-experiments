{$i-}
program Mato;
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
  pcxfile : file;
  header : pcxheader;
  Str80 : string[80];
  BufTp : array[0..4095] of byte;
  PalBuf : array[0..$2ff] of byte;

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
  if 'valikko2.pcx' = '' then error('Enter filename on commandline.');
  assign(pcxfile,'valikko2.pcx');
  reset(pcxfile,1);
  if ioresult <> 0 then error('valikko2.pcx'+' not found.');
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
end;

procedure play;
begin
end;

procedure matopeli;
begin
  alusta;
  repeat
    play;
  until loppu=true;
  loppu:=false;
  settext;
end;

procedure options;
begin

end;

procedure valik;
begin
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
    matopeli;
    uusi:=true;
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

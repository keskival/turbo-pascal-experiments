program matopeli;
uses graf,crt;

var
  loppu:boolean;

procedure alustus;
begin

end;

procedure alkukuva;

procedure lataakuva;
const vseg = $a000;
type
  str80 = string[80];
  buftp = array[0..4095] of byte;
  palbuf = array[0..$2ff] of byte;
var
  picfile : file;
  palette : palbuf;
  buffer : buftp;
  filename : str80;
  i,bufct : longint;
  nofread : integer;

procedure setpal(col,r,g,b : byte); assembler; asm
  mov dx,03c8h; mov al,col; out dx,al; inc dx; mov al,r
  out dx,al; mov al,g; out dx,al; mov al,b; out dx,al end;

procedure setcolors(buf : palbuf); var c : word; i : byte; begin c := 3;
  for i := 1 to 255 do begin setpal(i,buf[c],buf[c+1],buf[c+2]); inc(c,3); end; end;

begin
  filename := 'alku.raw';
  if filename = '' then begin
    writeln('Please enter filename on commandline.'); halt; end;
  assign(picfile,filename);
  reset(picfile,1); if ioresult <> 0 then begin
    writeln(filename+' not found in current dir'); halt; end;
  seek(picfile,10);
  blockread(picfile,palette,$300);
  asm mov ax,2eh; int 10h; end;
  setcolors(palette);
  bufct := 0;
  repeat
    blockread(picfile,buffer,4096,nofread);
    for i := 0 to nofread-1 do begin
      port[$03cd] := (bufct+i) shr 16;
      mem[vseg:(bufct+i) and $ffff] := buffer[i];
    end;
    inc(bufct,nofread);
  until nofread < 4096;
  close(picfile);
end;

begin
  lataakuva;
end;

procedure pelaa;
begin

end;

procedure options;
begin

end;

procedure valint;
var
  valittu:boolean;
  key:char;
  valinta:byte;

procedure ylos;
begin
  valinta:=valinta-1;
  if valinta=0 then valinta:=3;
end;

procedure alas;
begin
  valinta:=valinta+1;
  if valinta=3 then valinta:=1;
end;

procedure piirra;
begin
  if valinta=1 then begin
    pal(30,30,30,100);
    pal(30,30,30,99);
    pal(100,100,100,98);
  end;
  if valinta=2 then begin
    pal(30,30,30,100);
    pal(30,30,30,98);
    pal(100,100,100,99);
  end;
  if valinta=3 then begin
    pal(30,30,30,98);
    pal(30,30,30,99);
    pal(100,100,100,100);
  end;
end;

begin
  valinta:=1;
  repeat
    piirra;
    key:='.';
    key:=readkey;
    if key=chr(72) then ylos;
    if key=chr(80) then alas;
    if (key=chr(32))or(key=chr(13)) then valittu:=true;
    piirra;
  until valittu=true;
  if valinta=1 then pelaa;
  if valinta=2 then options;
  if valinta=3 then loppu:=true;
end;

begin
  setmcga;
  alustus;
  alkukuva;
  repeat
    valint;
  until loppu=true;
  settext;
  writeln('Ja j„lleen uusi matopeli by Tero Keski-Valkama!!!');
end.

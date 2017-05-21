program tunnelibyTero;
uses crt,kamaa;

var
  edevari,edepallox,edepalloy,pallox,palloy,palloxsu,palloysu:integer;
  suunta,v,vari,i:integer;
  palvari:array[1..91,1..3]of byte;

procedure scrollaa;
begin
  for v:=1 to 91 do begin
    getpal(v,palvari[v,1],palvari[v,2],palvari[v,3]);
  end;
  waitretrace;
  if suunta=1 then begin
    for v:=1 to 90 do begin
      pal(v,palvari[v+1,1],palvari[v+1,2],palvari[v+1,3]);
    end;
    pal(91,palvari[1,1],palvari[1,2],palvari[1,3]);
  end
  else begin
    for v:=2 to 91 do begin
      pal(v,palvari[v-1,1],palvari[v-1,2],palvari[v-1,3]);
    end;
    pal(1,palvari[91,1],palvari[91,2],palvari[91,3]);
  end;
end;

procedure liikutapalloa;

begin
  if (palloy>198)or(palloy<1) then begin
    suunta:=-suunta;
    palloysu:=-palloysu;
  end;
  if (pallox>318)or(pallox<1) then begin
    suunta:=-suunta;
    palloxsu:=-palloxsu;
  end;
  putpixel(pallox,palloy,edevari,vga);
  pallox:=pallox+palloxsu;
  palloy:=palloy+palloysu;
  edevari:=getpixel(pallox,palloy,vga);
  putpixel(pallox,palloy,100,vga);
end;

procedure play;
begin
  scrollaa;
  liikutapalloa;
end;

begin
  setmcga;
  suunta:=1;
  pallox:=1;
  palloy:=1;
  palloxsu:=1;
  palloysu:=1;
  edevari:=0;
  for i:=0 to 90 do begin
    vari:=vari+1;
    box(160-i,100-i,160+i,100+i,vari,vga);
  end;
  repeat play;
  until keypressed;
  settext;
  clrscr;
  writeln('That was a piece of very cool code by Tero Keski-Valkama!');
  writeln('Can you do something like that?');
  end.

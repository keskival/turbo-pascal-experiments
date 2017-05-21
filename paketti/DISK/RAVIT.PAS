program ravit;
uses crt,graf;

var
  h,j,g,apu,f,d,i:integer;
  voit,voittaja,heppa:array[0..6]of integer;
  loppu:boolean;
  viive:longint;

procedure alusta;
begin
  randomize;
  setmcga;
  cls(18,vga);
  line(319,0,319,199,11,vga);
end;

procedure play;
begin
  i:=random(6);
  heppa[i]:=heppa[i]+1;
  if heppa[i]=319 then loppu:=true;
  putpixel(heppa[i]-1,i*5+40,18,vga);
  putpixel(heppa[i],i*5+40,i+1,vga);
  if keypressed then loppu:=true;
  for viive:=0 to 44444 do;
end;

begin
  alusta;
  repeat
    play;
  until loppu=true;
  settext;
  for g:=0 to 5 do voittaja[g]:=heppa[g];
  for f:=0 to 4 do begin
    for d:=f+1 to 5 do
    begin
      if voittaja[d]<voittaja[f] then
      begin
        apu:=voittaja[f];
        voittaja[f]:=voittaja[d];
        voittaja[d]:=apu;
      end;
    end;
  end;
  for h:=0 to 5 do
  begin
    for j:=0 to 5 do
    begin
      if voittaja[h]=heppa[j] then apu:=j;
    end;
    voit[h]:=apu+1;
    heppa[apu]:=999;
  end;
  writeln('Kuudes oli piste nro: ',voit[0],'.');
  writeln('Viides oli piste nro: ',voit[1],'.');
  writeln('Nelj„s oli piste nro: ',voit[2],'.');
  writeln('Kolmas oli piste nro: ',voit[3],'.');
  writeln('Toinen oli piste nro: ',voit[4],'.');
  writeln('Piste numero ',voit[5],' voitti!');
  readkey;
end.

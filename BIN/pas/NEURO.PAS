program neuro;
uses unit3d,crt;
const
  e=2.718282;


var
  nappi:char;
  tulo:array[0..2]of record
    lahto:real;
    kerroin:array[0..11]of real;
  end;
  i,j,k,top,p,virhe,apu:integer;
  alku,kc,kt,ka:array[0..11]of integer;


procedure laske(kuka:integer;var alk:array of integer);
var summa:real; t:integer;
begin
  summa:=0;
  for t:=0 to 11 do
  begin
    summa:=summa+(alk[t]*tulo[kuka].kerroin[t]);
  end;
  tulo[kuka].lahto:=(exp(2*summa)-1)/(exp(2*summa)+1);
end;

procedure opeta(kuka,maali:integer);
var g:integer;
begin
  if (tulo[kuka].lahto>maali) then
  begin
    for g:=0 to 11 do
    begin
      if (alku[g]>=0) then
        tulo[kuka].kerroin[g]:=tulo[kuka].kerroin[g]-random(1000)/100000;
      if (alku[g]<0) then
        tulo[kuka].kerroin[g]:=tulo[kuka].kerroin[g]+random(1000)/100000;
    end;
  end;
  if (tulo[kuka].lahto<maali) then
  begin
    for g:=0 to 11 do
    begin
      if (alku[g]>=0) then
        tulo[kuka].kerroin[g]:=tulo[kuka].kerroin[g]+random(1000)/100000;
      if (alku[g]<0) then
        tulo[kuka].kerroin[g]:=tulo[kuka].kerroin[g]-random(1000)/100000;
    end;
  end;
end;

begin
  kc[0]:=1;
  kc[1]:=1;
  kc[2]:=1;
  kc[3]:=1;
  kc[4]:=-1;
  kc[5]:=-1;
  kc[6]:=1;
  kc[7]:=-1;
  kc[8]:=-1;
  kc[9]:=1;
  kc[10]:=1;
  kc[11]:=1;
  ka[0]:=-1;
  ka[1]:=1;
  ka[2]:=-1;
  ka[3]:=1;
  ka[4]:=-1;
  ka[5]:=1;
  ka[6]:=1;
  ka[7]:=1;
  ka[8]:=1;
  ka[9]:=1;
  ka[10]:=-1;
  ka[11]:=1;
  kt[0]:=1;
  kt[1]:=1;
  kt[2]:=1;
  kt[3]:=-1;
  kt[4]:=1;
  kt[5]:=-1;
  kt[6]:=-1;
  kt[7]:=1;
  kt[8]:=-1;
  kt[9]:=-1;
  kt[10]:=1;
  kt[11]:=-1;
  randomize;
  for i:=0 to 11 do
  begin
    for j:=0 to 2 do
      tulo[j].kerroin[i]:=(random(100)/50-1);
  virhe:=0;
  while(virhe<50) do
  begin
    writeln(virhe);
    for p:=0 to 11 do
    begin
      if random(100)<89 then
      begin
        alku[p]:=kc[p];
      end
      else alku[p]:=(random(2)*2)-1;
    end;
    laske(0,alku);
    laske(1,alku);
    laske(2,alku);
    virhe:=virhe+1;
    if ((1+tulo[0].lahto)>(tulo[1].lahto))or((1+tulo[2].lahto)>(tulo[1].lahto)) then
    begin
      virhe:=0;
      opeta(0,-1);
      opeta(1,1);
      opeta(2,-1);
      writeln(tulo[0].lahto);
      writeln(' ');
      writeln(tulo[1].lahto);
      writeln(' ');
      writeln(tulo[2].lahto);
        writeln(' ');
        writeln('c');
      end;
      for p:=0 to 11 do
      begin
        if random(100)<89 then
        begin
          alku[p]:=kt[p];
        end
        else alku[p]:=(random(2)*2)-1;
      end;
      laske(0,alku);
      laske(1,alku);
      laske(2,alku);
      if ((1+tulo[1].lahto)>(tulo[2].lahto))or((1+tulo[0].lahto)>(tulo[2].lahto)) then
      begin
        virhe:=0;
        opeta(0,-1);
        opeta(1,-1);
        opeta(2,1);
        writeln(tulo[0].lahto);
        writeln(' ');
        writeln(tulo[1].lahto);
        writeln(' ');
        writeln(tulo[2].lahto);
        writeln(' ');
        writeln('t');
      end;
      for p:=0 to 11 do
      begin
        if random(100)<89 then
        begin
          alku[p]:=ka[p];
        end
        else alku[p]:=(random(2)*2)-1;
      end;
      laske(0,alku);
      laske(1,alku);
      laske(2,alku);
      if ((1+tulo[1].lahto)>(tulo[0].lahto))or((1+tulo[2].lahto)>(tulo[0].lahto)) then
      begin
        virhe:=0;
        opeta(0,1);
        opeta(1,-1);
        opeta(2,-1);
        writeln(tulo[0].lahto);
        writeln(' ');
        writeln(tulo[1].lahto);
        writeln(' ');
        writeln(tulo[2].lahto);
        writeln(' ');
        writeln('a');
      end;
    end;
  end;
  for top:=0 to 11 do
  begin
    for j:=0 to 2 do write(tulo[j].kerroin[top],',');
    writeln('');
  end;
  repeat
    nappi:=readkey;
    clrscr;
    writeln(' A ');
    writeln('');

    for p:=0 to 11 do
    begin
      if random(100)<50 then
      begin
        alku[p]:=ka[p];
      end
      else alku[p]:=(random(2)*2)-1;
    end;

    for top:=0 to 2 do
    begin
      if alku[top]>0 then write('*')
      else write(' ');
    end;
    writeln(' ');
    for top:=3 to 5 do
    begin
      if alku[top]>0 then write('*')
      else write(' ');
    end;
    writeln(' ');
    for top:=6 to 8 do
    begin
      if alku[top]>0 then write('*')
      else write(' ');
    end;
    writeln(' ');
    for top:=9 to 11 do
    begin
      if alku[top]>0 then write('*')
      else write(' ');
    end;
    writeln(' ');
    laske(0,alku);
    laske(1,alku);
    laske(2,alku);
    apu:=0;
    if tulo[0].lahto<tulo[1].lahto then apu:=1;
    if tulo[apu].lahto<tulo[2].lahto then apu:=2;
    if apu=0 then writeln('a');
    if apu=1 then writeln('c');
    if apu=2 then writeln('t');

    writeln(' C ');
    writeln('');

    for p:=0 to 11 do
    begin
      if random(100)<50 then
      begin
        alku[p]:=kc[p];
      end
      else alku[p]:=(random(2)*2)-1;
    end;

    for top:=0 to 2 do
    begin
      if alku[top]>0 then write('*')
      else write(' ');
    end;
    writeln(' ');
    for top:=3 to 5 do
    begin
      if alku[top]>0 then write('*')
      else write(' ');
    end;
    writeln(' ');
    for top:=6 to 8 do
    begin
      if alku[top]>0 then write('*')
      else write(' ');
    end;
    writeln(' ');
    for top:=9 to 11 do
    begin
      if alku[top]>0 then write('*')
      else write(' ');
    end;
    writeln(' ');
    laske(0,alku);
    laske(1,alku);
    laske(2,alku);
    apu:=0;
    if tulo[0].lahto<tulo[1].lahto then apu:=1;
    if tulo[apu].lahto<tulo[2].lahto then apu:=2;
    if apu=0 then writeln('a');
    if apu=1 then writeln('c');
    if apu=2 then writeln('t');

    writeln(' T ');
    writeln('');

    for p:=0 to 11 do
    begin
      if random(100)<50 then
      begin
        alku[p]:=kt[p];
      end
      else alku[p]:=(random(2)*2)-1;
    end;

    for top:=0 to 2 do
    begin
      if alku[top]>0 then write('*')
      else write(' ');
    end;
    writeln(' ');
    for top:=3 to 5 do
    begin
      if alku[top]>0 then write('*')
      else write(' ');
    end;
    writeln(' ');
    for top:=6 to 8 do
    begin
      if alku[top]>0 then write('*')
      else write(' ');
    end;
    writeln(' ');
    for top:=9 to 11 do
    begin
      if alku[top]>0 then write('*')
      else write(' ');
    end;
    writeln(' ');
    laske(0,alku);
    laske(1,alku);
    laske(2,alku);
    apu:=0;
    if tulo[0].lahto<tulo[1].lahto then apu:=1;
    if tulo[apu].lahto<tulo[2].lahto then apu:=2;
    if apu=0 then writeln('a');
    if apu=1 then writeln('c');
    if apu=2 then writeln('t');

  until nappi='a';

end.

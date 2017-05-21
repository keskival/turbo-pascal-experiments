program rubik;
uses crt;

type
  kuutio=array[1..9,1..6]of byte;


var
  d,e:integer;
  lopp:boolean;
  apu,kuut1,kohde:kuutio;
  ratk:array[1..10]of string;

procedure tulosta;
begin
  for d:=1 to 10 do writeln(ratk[d]);
  writeln('');
  readkey;
end;

function valmis(eka,toka:kuutio):boolean;
var g,h:integer;
  lop:boolean;
begin
  lop:=false;
  for g:=1 to 9 do for h:=1 to 6 do
  begin
    if eka[g,h]<>toka[g,h] then lop:=true;
  end;
  if lop=false then valmis:=true
  else valmis:=false;
end;

procedure koita(testi:kuutio;monta:integer);
label loppu;
begin
  if (monta<=0)or(lopp=true) then goto loppu;
  if valmis(testi,kohde)=true then
  begin
    tulosta;
    monta:=0;
    writeln('T„h.');
    lopp:=true;
  end;
  if lopp=true then goto loppu;
  if monta>9 then writeln(monta,' '+ratk[9-monta]);
  for d:=1 to 9 do for e:=1 to 6 do apu[d,e]:=testi[d,e];
  for d:=1 to 3 do apu[d+6,3]:=testi[d*3,5];
  for d:=1 to 3 do apu[d*3,5]:=testi[d,6];
  for d:=1 to 3 do apu[d,6]:=testi[d*3-2,2];
  for d:=1 to 3 do apu[d*3-2,2]:=testi[d+6,3];
  if lopp=false then ratk[10-monta]:='1m';
  koita(apu,monta-1);

  for d:=1 to 9 do for e:=1 to 6 do apu[d,e]:=testi[d,e];
  for d:=1 to 3 do apu[d*3,5]:=testi[d+6,3];
  for d:=1 to 3 do apu[d,6]:=testi[d*3,5];
  for d:=1 to 3 do apu[d*3-2,2]:=testi[d,6];
  for d:=1 to 3 do apu[d+6,3]:=testi[d*3-2,2];
  if lopp=false then ratk[10-monta]:='1v';
  koita(apu,monta-1);

  for d:=1 to 9 do for e:=1 to 6 do apu[d,e]:=testi[d,e];
  for d:=1 to 3 do apu[d*3,1]:=testi[d*3,6];
  for d:=1 to 3 do apu[d*3,3]:=testi[d*3,1];
  for d:=1 to 3 do apu[d*3,6]:=testi[d*3-2,4];
  for d:=1 to 3 do apu[d,4]:=testi[d*3,3];
  if lopp=false then ratk[10-monta]:='2m';
  koita(apu,monta-1);

  for d:=1 to 9 do for e:=1 to 6 do apu[d,e]:=testi[d,e];
  for d:=1 to 3 do apu[d*3,6]:=testi[d*3,1];
  for d:=1 to 3 do apu[d*3,1]:=testi[d*3,3];
  for d:=1 to 3 do apu[d*3-2,4]:=testi[d*3,6];
  for d:=1 to 3 do apu[d*3,3]:=testi[d,4];
  if lopp=false then ratk[10-monta]:='2v';
  koita(apu,monta-1);

  for d:=1 to 9 do for e:=1 to 6 do apu[d,e]:=testi[d,e];
  for d:=1 to 3 do apu[d,1]:=testi[d,2];
  for d:=1 to 3 do apu[d,2]:=testi[d,4];
  for d:=1 to 3 do apu[d,4]:=testi[d,5];
  for d:=1 to 3 do apu[d,5]:=testi[d,1];
  if lopp=false then ratk[10-monta]:='3m';
  koita(apu,monta-1);

  for d:=1 to 9 do for e:=1 to 6 do apu[d,e]:=testi[d,e];
  for d:=1 to 3 do apu[d,2]:=testi[d,1];
  for d:=1 to 3 do apu[d,4]:=testi[d,2];
  for d:=1 to 3 do apu[d,5]:=testi[d,4];
  for d:=1 to 3 do apu[d,1]:=testi[d,5];
  if lopp=false then ratk[10-monta]:='3v';
  koita(apu,monta-1);

  for d:=1 to 9 do for e:=1 to 6 do apu[d,e]:=testi[d,e];
  for d:=1 to 3 do apu[d+6,2]:=testi[10-d,6];
  for d:=1 to 3 do apu[d+6,6]:=testi[d*3-2,5];
  for d:=1 to 3 do apu[d*3-2,5]:=testi[4-d,3];
  for d:=1 to 3 do apu[d,3]:=testi[d*3,2];
  if lopp=false then ratk[10-monta]:='4m';
  koita(apu,monta-1);

  for d:=1 to 9 do for e:=1 to 6 do apu[d,e]:=testi[d,e];
  for d:=1 to 3 do apu[10-d,6]:=testi[d+6,2];
  for d:=1 to 3 do apu[d*3-2,5]:=testi[d+6,6];
  for d:=1 to 3 do apu[4-d,3]:=testi[d*3-2,5];
  for d:=1 to 3 do apu[d*3,2]:=testi[d,3];
  if lopp=false then ratk[10-monta]:='4v';
  koita(apu,monta-1);

  for d:=1 to 9 do for e:=1 to 6 do apu[d,e]:=testi[d,e];
  for d:=1 to 3 do apu[d*3-2,6]:=testi[d*3-2,1];
  for d:=1 to 3 do apu[d*3-2,1]:=testi[d*3-2,3];
  for d:=1 to 3 do apu[d*3-2,3]:=testi[12-d*3,4];
  for d:=1 to 3 do apu[d*3,4]:=testi[10-d*3,6];
  if lopp=false then ratk[10-monta]:='5m';
  koita(apu,monta-1);

  for d:=1 to 9 do for e:=1 to 6 do apu[d,e]:=testi[d,e];
  for d:=1 to 3 do apu[d*3-2,1]:=testi[d*3-2,6];
  for d:=1 to 3 do apu[d*3-2,3]:=testi[d*3-2,1];
  for d:=1 to 3 do apu[12-d*3,4]:=testi[d*3-2,3];
  for d:=1 to 3 do apu[10-d*3,6]:=testi[d*3,4];
  if lopp=false then ratk[10-monta]:='5v';
  koita(apu,monta-1);

  for d:=1 to 9 do for e:=1 to 6 do apu[d,e]:=testi[d,e];
  for d:=1 to 3 do apu[d+6,1]:=testi[d+6,5];
  for d:=1 to 3 do apu[d+6,5]:=testi[d+6,4];
  for d:=1 to 3 do apu[d+6,4]:=testi[d+6,2];
  for d:=1 to 3 do apu[d+6,2]:=testi[d+6,1];
  if lopp=false then ratk[10-monta]:='6m';
  koita(apu,monta-1);

  for d:=1 to 9 do for e:=1 to 6 do apu[d,e]:=testi[d,e];
  for d:=1 to 3 do apu[d+6,1]:=testi[d+6,5];
  for d:=1 to 3 do apu[d+6,5]:=testi[d+6,4];
  for d:=1 to 3 do apu[d+6,4]:=testi[d+6,2];
  for d:=1 to 3 do apu[d+6,2]:=testi[d+6,1];
  if lopp=false then ratk[10-monta]:='6v';
  koita(apu,monta-1);

loppu:
end;

begin
  for d:=1 to 9 do kohde[d,1]:=1;
  for d:=1 to 9 do kohde[d,2]:=2;
  for d:=1 to 9 do kohde[d,3]:=3;
  for d:=1 to 9 do kohde[d,4]:=4;
  for d:=1 to 9 do kohde[d,5]:=5;
  for d:=1 to 9 do kohde[d,6]:=6;
  for d:=1 to 9 do kuut1[d,1]:=1;
  for d:=1 to 9 do kuut1[d,2]:=2;
  for d:=1 to 9 do kuut1[d,3]:=3;
  for d:=1 to 9 do kuut1[d,4]:=4;
  for d:=1 to 9 do kuut1[d,5]:=5;
  for d:=1 to 9 do kuut1[d,6]:=6;
  kuut1[7,1]:=2;
  kuut1[9,1]:=5;
  kuut1[4,2]:=5;
  kuut1[7,2]:=1;
  kuut1[6,5]:=2;
  kuut1[9,5]:=1;
  lopp:=false;
  koita(kuut1,20);


end.
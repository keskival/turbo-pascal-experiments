program neuro;
uses crt;

var
  i:integer;
  input:array[1..35] of real;
  taso1:array[1..60] of record
    kynnys:real;
    paalla:real;
  end;
  taso2:array[1..60] of record
    kynnys:real;
    paalla:real;
  end;
  output:array[1..3] of record
    kynnys:real;
    paalla:real;
  end;

procedure alusta;
begin
  for i:=1 to 35 do input[i]:=0;
  for i:=1 to 60 do
  begin
    taso1[i].kynnys:=0.5;
    taso1[i].paalla:=0;
  end;
  for i:=1 to 60 do
  begin
    taso2[i].kynnys:=0.5;
    taso2[i].paalla:=0;
  end;
  for i:=1 to 60 do
  begin
    output[i].kynnys:=0.5;
    output[i].paalla:=0;
  end;
end;

begin
  randomize;
  alusta;
{  opeta;
  otasyote;
  tutki;
  naytatulokset;}
end.

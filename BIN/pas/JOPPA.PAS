program juttu;
uses crt;

const
  mato:array[0..8,0..17]of integer=
       ((0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
        (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
        (0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0),
        (1,0,0,0,0,1,1,1,1,1,1,0,0,0,0,1,1,1),
        (1,1,1,0,1,1,0,0,0,0,1,1,1,1,1,0,0,0),
        (1,1,1,1,1,0,0,0,0,0,0,1,1,1,0,0,0,0),
        (0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
        (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
        (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0));
  teksti:array[0..8,0..29]of integer=
       ((1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),
        (1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),
        (1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),
        (1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),
        (1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),
        (1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),
        (1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),
        (1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),
        (1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1));

var
  viive:longint;
  teksti:array[0..8,0..50]of boolean;
  d:array[0..9]of integer;
  piirto:array[0..8,0..9]of integer;
  i,j,f,g:integer;

procedure piirra;
begin
  clrscr;
  for i:=0 to 8 do
  begin
    for j:=0 to 8 do if piirto[i,j]=1 then write('* ') else write('. ');
    if piirto[i,9]=1 then writeln('*') else writeln('.');
  end;
  for viive:=0 to 10000000 do;
end;

procedure oikea(var a:array of integer);
begin
  for i:=0 to 8 do for j:=9 downto 1 do
  begin
    piirto[i,j]:=piirto[i,j-1];
  end;
  for i:=0 to 8 do piirto[i,0]:=a[i];
end;

procedure vasen(var a:array of integer);
begin
  for i:=0 to 8 do for j:=0 to 8 do
  begin
    piirto[i,j]:=piirto[i,j+1];
  end;
  for i:=0 to 8 do piirto[i,9]:=a[i];
end;

begin
  piirra;
{  for f:=0 to 9 do d[f]:=1;
  for f:=0 to 3 do
  begin
    vasen(d);
    piirra;
    vasen(d);
    piirra;
    vasen(d);
    piirra;
    oikea(d);
    piirra;
    oikea(d);
    piirra;
    oikea(d);
    piirra;
  end;                     }
  for f:=0 to 9 do d[f]:=0;
  for f:=0 to 9 do
  begin
    vasen(d);
    piirra;
  end;
  for g:=0 to 17 do
  begin
    for f:=0 to 8 do d[f]:=mato[f,g];
    vasen(d);
    piirra;
  end;
  for f:=0 to 9 do d[f]:=0;
  for f:=0 to 9 do
  begin
    vasen(d);
    piirra;
  end;

end.
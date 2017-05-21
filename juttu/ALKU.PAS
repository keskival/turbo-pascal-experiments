program aine;
uses unit3d,crt;

var
  alkua:array[1..20]of string;
  maara:integer;
  muita:boolean;
  i,a,code:integer;
  kaava:string;

begin
  writeln('Kirjoita aineen kaava: ');
  readln(kaava);
  if (pos('C',kaava)<>0) then
  begin
    val(copy(kaava,pos('C',kaava)+1,1),a,code);
    if a=2 then write('di');
    if a=3 then write('tri');
    muita:=true;
    write('hiili');
  end;
  if pos('H',kaava)<>0 then
  begin
    val(copy(kaava,pos('H',kaava)+1,1),a,code);
    if a=2 then write('di');
    if a=3 then write('tri');
    write('vety');
    muita:=true;
  end;
  if pos('kl',kaava)<>0 then
  begin
    val(copy(kaava,pos('Kl',kaava)+1,1),a,code);
    if a=2 then write('di');
    if a=3 then write('tri');
    if muita=true then write('kloridi')
    else write('vety');
  end;
  if pos('O',kaava)<>0 then
  begin
    val(copy(kaava,pos('O',kaava)+1,1),a,code);
    if a=2 then write('di');
    if a=3 then write('tri');
    if muita=true then write('oksidi')
    else write('happi');
  end;
  readkey;
end.
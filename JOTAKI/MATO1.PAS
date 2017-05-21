program worm;
uses crt,graph;
var x,y,z,a,b,c,tx,ty,vari,rinki,loppu,monta :integer;
    suunta,tark : char;

procedure suorakulmio(pituus, leveys, vari : integer);
var v : integer;
begin
     v := GetColor;
     rectangle(GetX, GetY, GetX + pituus, GetY + leveys);
     SetFillStyle(1, vari); FloodFill(GetX + 2, GetY + 2, v);
     SetColor(v);
end;
procedure pallo;
begin
z:=random(16);
setcolor(z);
circle(x,y,5);
rinki:=rinki+1;
end;

procedure tavara;
begin
setcolor(blue);
circle(tx,ty,20);
z:=random(16);
if z>9 then
   begin
   tx:=random(560)+20;
   ty:=random(260)+20;
   setcolor(z);
   circle(tx,ty,20);
   monta:=monta+1;
   end;
end;

procedure oikea;
begin
c:=random(3);
if c=1 then y:=y-1;
if c=2 then y:=y+1;
x:=x+3;
end;

procedure alas;
begin
c:=random(3);
if c=1 then x:=x-1;
if c=2 then x:=x+1;
y:=y+3;
end;

procedure vasen;
begin
c:=random(3);
if c=1 then y:=y-1;
if c=2 then y:=y+1;
x:=x-3;
end;

procedure ylos;
begin
c:=random(3);
if c=1 then x:=x-1;
if c=2 then x:=x+1;
y:=y-3;
end;

procedure tarkista;
begin
if suunta ='4'then if tark='6'then suunta :='6';
if suunta ='8'then if tark='2'then suunta :='2';
if suunta ='6'then if tark='4'then suunta :='4';
if suunta ='2'then if tark='8'then suunta :='8';
if suunta<>'6'then if suunta<>'2'then if suunta<>'8'then if suunta<>'4'then suunta:=tark;
end;

procedure exit;
begin
clrscr;
monta:=monta-1;
textmode(3);
write('sait ker„tty„ ');
write(monta);
writeln(' pistett„.');
write('ja ');
write(rinki);
writeln(' rinki„');
writeln;
readln;
end;

begin
initgraph(a,b,'');
clrscr;
suorakulmio(600,300,1);
loppu := 0;
randomize;
x:=40; y:=40;
repeat;
pallo;
tark:=suunta;
if keypressed then suunta:=readkey;
tarkista;
if suunta = '6'then oikea;
if suunta = '2'then alas;
if suunta = '4'then vasen;
if suunta = '8'then ylos;
if x+6 > 600 then loppu :=1;
if x-6 < 1 then loppu :=1;
if y+6 > 300 then loppu :=1;
if y-6 < 1 then loppu :=1;
if x+2>tx-20 then if x+2<tx+20 then if y+2>ty-20 then if y+2<ty+20 then tavara;
if monta =0 then tavara;
delay(10);
until loppu =1;
exit;
clrscr;
end.
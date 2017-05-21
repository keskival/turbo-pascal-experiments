program test;

uses
    graph;
var
   graphdriver:integer;
   graphmode:integer;
   roe,roe1,roe2,roe3:real;
   theta,theta1,theta2,theta3:real;
   x,x1,x2,x3:real;
   y,y1,y2,y3:real;
   toisto:integer;
   kulma:real;

procedure alustus;
begin
graphdriver:=0;
graphmode:=1;
initgraph(graphdriver,graphmode,'c:\turbo\bgi');
clearviewport;
cleardevice;
kulma:=45;
x1:=10;
y1:=0;
x2:=0;
y2:=10;
x3:=0;
y3:=0;
end;

function lasketheta(x,y:real):real;
begin
theta:=arctan(x/y);
end;

function laskeroe(x,y:real):real;
begin
roe:=sqrt(sqr(x)+sqr(y));
end;

function laskex(theta,roe:real):real;
begin
x:=roe*(cos(theta));
end;

function laskey(theta,roe:real):real;
begin
y:=roe*(sin(theta));
end;
begin
alustus;
theta1:=lasketheta(10,1);
roe1:=laskeroe(10,1);
theta2:=lasketheta(1,10);
roe2:=laskeroe(1,10);
theta3:=lasketheta(1,1);
roe3:=laskeroe(1,1);
line (100+round(x1),100+round(y1),100+round(x3),100+round(y3));
line (100+round(x2),100+round(y2),100+round(x3),100+round(y3));
repeat
theta1:=theta1+1;
theta2:=theta2+1;
theta3:=theta3+1;
x1:=laskex(theta1,roe1);
y1:=laskey(theta1,roe1);
x2:=laskex(theta2,roe2);
y2:=laskey(theta2,roe2);
x3:=laskex(theta3,roe3);
y3:=laskey(theta3,roe3);
line (100+round(x1),100+round(y1),100+round(x3),100+round(y3));
line (100+round(x2),100+round(y2),100+round(x3),100+round(y3));
until theta1=360;
end.

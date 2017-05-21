unit tpr;
interface
uses trighyp;

function radiaaneiksi(asteet:real):real;
function asteiksi(radiaanit:real):real;
function theta(x,y:real):real;
function phi(z,roe:real):real;
function ddroe(x,y:real):real;
function tdroe(x,y,z:real):real;
function ddx(theta,roe:real):real;
function tdx(theta,phi,roe:real):real;
function ddy(theta,roe:real):real;
function tdy(theta,phi,roe:real):real;
function z(phi,roe:real):real;

implementation

function radiaaneiksi(asteet:real):real;
begin
  radiaaneiksi:=asteet*(pi/180);
end;

function asteiksi(radiaanit:real):real;
begin
  asteiksi:=radiaanit*(180/pi);
end;

function theta(x,y:real):real;
begin
  theta:=arctan(y/x);
end;

function phi(z,roe:real):real;
begin
  phi:=arccos(z/roe);
end;

function ddroe(x,y:real):real;
begin
  ddroe:=sqrt(sqr(x)+sqr(y));
end;

function tdroe(x,y,z:real):real;
begin
  tdroe:=sqrt(sqr(x)+sqr(y)+sqr(z));
end;

function ddx(theta,roe:real):real;
begin
  ddx:=roe*cos(theta);
end;

function tdx(theta,phi,roe:real):real;
begin
  tdx:=roe*(sin(phi)*cos(theta));
end;

function ddy(theta,roe:real):real;
begin
  ddy:=roe*sin(theta);
end;

function tdy(theta,phi,roe:real):real;
begin
  tdy:=roe*(sin(phi)*sin(theta));
end;

function z(phi,roe:real):real;
begin
  z:=roe*cos(phi);
end;
end.

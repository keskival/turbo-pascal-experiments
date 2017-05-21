program hypnoosi;
uses tpr,crt,graf;

var
  i:real;
  viive:longint;
  edex,edey,edex2,edey2,edex3,edey3,edex4,edey4,j:integer;

procedure play;
begin
  repeat
    for j:=0 to 50 do begin
      if j<>0 then line(edex,edey,round(ddx(i,j)+159),round(ddy(i,j)+99),11,vga);
      if j<>0 then line(edex2,edey2,round(ddx(i+0.5,j)+159),round(ddy(i+0.5,j)+99),12,vga);
      if j<>0 then line(edex3,edey3,round(ddx(i+1,j)+159),round(ddy(i+1,j)+99),13,vga);
      if j<>0 then line(edex4,edey4,round(ddx(i+1.5,j)+159),round(ddy(i+1.5,j)+99),14,vga);
      edex:=round(ddx(i,j)+159);
      edey:=round(ddy(i,j)+99);
      edex2:=round(ddx(i+0.5,j)+159);
      edey2:=round(ddy(i+0.5,j)+99);
      edex3:=round(ddx(i+1,j)+159);
      edey3:=round(ddy(i+1,j)+99);
      edex4:=round(ddx(i+1.5,j)+159);
      edey4:=round(ddy(i+1.5,j)+99);
      i:=i+0.5;
    end;
    for viive:=0 to 99999 do;
    cls(0,vga);
  until i>=(2*pi);
end;



begin
  i:=round(2*pi);
  setmcga;
  repeat
    play;
  until keypressed;
  settext;
end.

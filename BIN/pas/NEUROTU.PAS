program neuro;
uses crt;


var
  i,j:integer;
  solu:array[1..10,1..16]of record
    e1,e2,e3:integer;
    t:array[1..2]of integer;
    paalla:boolean;
    ek1,ek2,ek3:real;
    tk:real;
    paljoko:real;
end;

procedure palkitse;
begin
  for i:=1 to 9 do for j:=1 to 16 do
  begin
    if solu[i,j].paalla=true then
    begin
      if solu[i,j].ek1>=0 then solu[i,j].ek1:=solu[i,j].ek1+(random(100)/500)
      else solu[i,j].ek1:=solu[i,j].ek1-(random(100)/500);
      if solu[i,j].ek2>=0 then solu[i,j].ek2:=solu[i,j].ek2+(random(100)/500)
      else solu[i,j].ek2:=solu[i,j].ek2-(random(100)/500);
      if solu[i,j].ek3>=0 then solu[i,j].ek3:=solu[i,j].ek3+(random(100)/500)
      else solu[i,j].ek3:=solu[i,j].ek3-(random(100)/500);
      if solu[i,j].tk>=0 then solu[i,j].tk:=solu[i,j].tk+(random(100)/500)
      else solu[i,j].tk:=solu[i,j].tk-(random(100)/500);
    end;
  end;
end;

procedure rankaise;
begin
  for i:=1 to 9 do for j:=1 to 16 do
  begin
    if solu[i,j].paalla=true then
    begin
      if solu[i,j].ek1<0 then solu[i,j].ek1:=solu[i,j].ek1+(random(100)/500)
      else solu[i,j].ek1:=solu[i,j].ek1-(random(100)/500);
      if solu[i,j].ek2<0 then solu[i,j].ek2:=solu[i,j].ek2+(random(100)/500)
      else solu[i,j].ek2:=solu[i,j].ek2-(random(100)/500);
      if solu[i,j].ek3<0 then solu[i,j].ek3:=solu[i,j].ek3+(random(100)/500)
      else solu[i,j].ek3:=solu[i,j].ek3-(random(100)/500);
      if solu[i,j].tk<0 then solu[i,j].tk:=solu[i,j].tk+(random(100)/500)
      else solu[i,j].tk:=solu[i,j].tk-(random(100)/500);
    end;
  end;
end;

procedure paivita;
begin
  for i:=1 to 9 do for j:=1 to 16 do
  begin
    if solu[i,j].paljoko>0 then
    begin
      solu[i+1,solu[i,j].e1].paljoko:=solu[i,j].ek1+solu[i+1,solu[i,j].e1].paljoko;
      solu[i+1,solu[i,j].e2].paljoko:=solu[i,j].ek2+solu[i+1,solu[i,j].e2].paljoko;
      solu[i+1,solu[i,j].e3].paljoko:=solu[i,j].ek3+solu[i+1,solu[i,j].e3].paljoko;
      solu[solu[i,j].t[1],solu[i,j].t[2]].paljoko:=solu[i,j].tk+solu[solu[i,j].t[1],solu[i,j].t[2]].paljoko;
      solu[i,j].paalla:=true;
    end;
  end;
end;

procedure alusta;
begin
  for j:=1 to 10 do begin
    for i:=1 to 16 do begin
      solu[i,j].e1:=round(random(16)+1);
      solu[i,j].e2:=round(random(16)+1);
      solu[i,j].e3:=round(random(16)+1);
      solu[i,j].t[1]:=round(random(j-1)+1);
      solu[i,j].t[2]:=round(random(16)+1);
      solu[i,j].ek1:=(random(100)-50)/100;
      solu[i,j].ek2:=(random(100)-50)/100;
      solu[i,j].ek3:=(random(100)-50)/100;
      solu[i,j].tk:=(random(100)-50)/100;
      solu[i,j].paalla:=false;
      solu[i,j].paljoko:=0;
    end;
  end;

end;

begin
  randomize;
  alusta;


end.
program pelia2;
uses crt,unit3d;

var
  akt:array[1..50]of real;
  dx,dy,pii:real;
  a,b,kulma,paikka:real;

  syote:array[1..18]of real;
  vanhasyote:array[1..18]of real;
  suunta:integer;
  solut:array[1..50]of record
    paalla:boolean;
    kerroin:array[1..18] of real;
    vanhakerroin:array[1..18] of real;
    suuntaker:real;
  end;
  nappi:char;
  pallox:array[1..10]of real;
  palloy:array[1..10]of real;
  palloxsu:array[1..10]of real;
  palloysu:array[1..10]of real;
  pallo:array[1..10]of boolean;
  mailax:integer;
  i,j,k:integer;

procedure ohi(i:integer);
begin
  pallo[i]:=false;

end;

procedure osui(i:integer);
begin
  palloysu[i]:=-palloysu[i];

end;

procedure pelaa;
begin
  for i:=1 to 5 do
  begin
    if pallo[i]=true then
    begin
      if (pallox[i]+palloxsu[i]<100)or(pallox[i]+palloxsu[i]>300) then palloxsu[i]:=-palloxsu[i];
      pallox[i]:=pallox[i]+palloxsu[i];
      if (palloy[i]+palloysu[i]>190)and(abs(pallox[i]-mailax)<3) then osui(i);
      if (palloy[i]+palloysu[i]>190)and(abs(pallox[i]-mailax)>=3) then ohi(i);
      if (palloy[i]+palloysu[i]<0) then pallo[i]:=false;
      palloy[i]:=palloy[i]+palloysu[i];
    end
    else
    begin
      if random(300)=3 then
      begin
        pallox[i]:=101+random(199);
        palloxsu[i]:=1;
        if random(3)=1 then palloxsu[i]:=-1;
        pallo[i]:=true;
        palloy[i]:=0;
        palloysu[i]:=1;
      end;
    end;
  end;
  paikka:=0;
  for i:=1 to 50 do
  begin
    if solut[i].paalla=true then paikka:=paikka+solut[i].suuntaker;
  end;
  paikka:=round(paikka*100)+200;
  if paikka<103 then paikka:=103;
  if paikka>297 then paikka:=297;
  mailax:=round(paikka);
end;

procedure piirra;
begin
  cls(0,vaddr);
  for i:=1 to 18 do
  begin
    if syote[i]<>0 then putpixel(i,10,4,vaddr);
    if (syote[i]>0.002) then putpixel(i,10,3,vaddr);
  end;
  putpixel(9,10,7,vaddr);
  putpixel(1,10,7,vaddr);
  putpixel(18,10,7,vaddr);
  for i:=1 to 10 do for j:=0 to 4 do
  begin
    if solut[i+j*10].paalla=true then putpixel(i,j+1,9,vaddr);
  end;
  line(301,0,301,199,7,vaddr);
  line(99,0,99,199,7,vaddr);
  line(mailax-3,190,mailax+3,190,8,vaddr);
  for i:=1 to 5 do
  begin
    if pallo[i]=true then
    begin
      putpixel(round(pallox[i]),round(palloy[i]),6,vaddr);
    end;
  end;
  flip;
end;

procedure aisti;
begin
  for i:=1 to 18 do vanhasyote[i]:=syote[i];
  for i:=1 to 18 do syote[i]:=0;
  for i:=1 to 5 do
  begin
    if pallo[i]=true then
    begin
      dx:=(mailax-pallox[i])*(mailax-pallox[i]);
      dy:=(190-palloy[i])*(190-palloy[i]);
      if palloy[i]-192<>0 then kulma:=arctan((mailax-pallox[i])/(palloy[i]-192))+pii/2
      else kulma:=pii;
      syote[round(kulma/(pii/18))+1]:=1/(dx+dy+1);
    end;
  end;
end;

procedure kelaa;
begin
  for i:=1 to 50 do
  begin
    a:=0;
    for j:=1 to 18 do
    begin
      a:=a+solut[i].kerroin[j]*(syote[j]+1);
      a:=a+solut[i].vanhakerroin[j]*(vanhasyote[j]+1);
    end;
    if a>0.5 then solut[i].paalla:=true
    else solut[i].paalla:=false;
    akt[i]:=a;
  end;
  b:=-1000;
  for i:=1 to 50 do
  begin
    if akt[i]>b then
    begin
      b:=akt[i];
      k:=i;
    end;
  end;
  for i:=1 to 50 do for j:=1 to 18 do
  begin
    if i<>k then
    begin
      if (vanhasyote[j]>0)and(solut[i].vanhakerroin[j]>-1) then
        solut[i].vanhakerroin[j]:=solut[i].vanhakerroin[j]-random(1000)/5000;
      if (syote[j]>0)and(solut[i].kerroin[j]>-1) then
        solut[i].kerroin[j]:=solut[i].kerroin[j]-random(1000)/5000;
      if (vanhasyote[j]=0)and(solut[i].vanhakerroin[j]<1) then
        solut[i].vanhakerroin[j]:=solut[i].vanhakerroin[j]+random(1000)/5000;
      if (syote[j]=0)and(solut[i].kerroin[j]<1) then
        solut[i].kerroin[j]:=solut[i].kerroin[j]+random(1000)/5000;
    end
    else
    begin
      if (vanhasyote[j]>0)and(solut[i].vanhakerroin[j]<1) then
        solut[i].vanhakerroin[j]:=solut[i].vanhakerroin[j]+random(1000)/5000;
      if (syote[j]>0)and(solut[i].kerroin[j]<1) then
        solut[i].kerroin[j]:=solut[i].kerroin[j]+random(1000)/5000;
      if (vanhasyote[j]=0)and(solut[i].vanhakerroin[j]>-1) then
        solut[i].vanhakerroin[j]:=solut[i].vanhakerroin[j]-random(1000)/5000;
      if (syote[j]=0)and(solut[i].kerroin[j]>-1) then
        solut[i].kerroin[j]:=solut[i].kerroin[j]-random(1000)/5000;
    end;
  end;
end;

procedure play;
begin
  aisti;
  kelaa;
  pelaa;
{  tuomitse;}
  piirra;
end;

begin
  pii:=3.1415926535897932385;
  randomize;
  for i:=1 to 50 do
  begin
    for j:=1 to 18 do
    begin
      solut[i].kerroin[j]:=random(1000)/500-1;
      solut[i].vanhakerroin[j]:=random(1000)/500-1;
    end;
    solut[i].suuntaker:=random(1000)/500-1;
  end;

  setmcga;
  setupvirtual;
  cls(0,vaddr);
  mailax:=200;
  repeat
    play;
    if keypressed then nappi:=readkey;
  until nappi='q';
  shutdown;
  settext;
end.
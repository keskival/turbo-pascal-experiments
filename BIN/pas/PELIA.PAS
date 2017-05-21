program neupeli;
uses unit3d,crt;

var
  opeta:boolean;
  nappi:char;
  f:text;
  syote:array[1..18]of boolean;
  neuronit:array[1..50]of record
    kerroin:array[1..50]of real;
    syotker:array[1..18]of real;
    toler:real;
    paalla:boolean;
    a:real;
  end;
  etaisyys:real;
  lahin:integer;
  liikesynv:array[1..50]of real;
  liikesyno:array[1..50]of real;
  x,i,j:integer;
  xsu,ysu:integer;
  y:real;
  mailax:integer;
  liike:integer;
  rankki,a,b,vasen,oikea:real;

procedure ammu;
begin
  ysu:=1;
  y:=0;
  x:=random(190)+110;
  xsu:=1;
  if random(2)<1 then xsu:=-1;
end;

procedure palkitse;
begin
  ysu:=-ysu;
end;

procedure kelaa;
var onnaa:boolean;
begin
  etaisyys:=0;
  for i:=1 to 50 do
  begin
    onnaa:=false;
    for j:=1 to 18 do
    begin
      if neuronit[i].syotker[j]>=0 then onnaa:=true;
    end;
    if onnaa=false then
    begin
      neuronit[i].syotker[random(18)+1]:=random(1000)/1000+0.3;
    end;
  end;
  for i:=1 to 50 do
  begin
    if (etaisyys<neuronit[i].a) then
    begin
      etaisyys:=neuronit[i].a;
      lahin:=i;
    end;
  end;
  for i:=1 to 50 do
  begin
    if (i<>lahin) then
    begin
      for j:=1 to 18 do
      begin
        if (syote[j]=true) then
          neuronit[i].syotker[j]:=neuronit[i].syotker[j]-random(1000)/4000
      end;
    end
    else
    begin
      for j:=1 to 18 do
      begin
        if (syote[j]=true)and(neuronit[lahin].syotker[j]<3) then
          neuronit[lahin].syotker[j]:=neuronit[lahin].syotker[j]+random(1000)/4000;
        if (syote[j]=false)and(neuronit[lahin].syotker[j]>-3) then
          neuronit[lahin].syotker[j]:=neuronit[lahin].syotker[j]-random(1000)/4000;
      end;
    end;
  end;
  if (nappi='x') then
  begin
    for i:=1 to 50 do
    begin
      if (neuronit[i].paalla=false) then
      begin
        if liikesynv[i]<1 then
          liikesynv[i]:=liikesynv[i]+random(1000)/1000;
        if liikesyno[i]>-1 then
          liikesyno[i]:=liikesyno[i]-random(1000)/1000;
      end;
      if neuronit[i].paalla=true then
      begin
        if liikesyno[i]<1 then
          liikesyno[i]:=liikesyno[i]+random(1000)/1000;
        if liikesynv[i]>-1 then
          liikesynv[i]:=liikesynv[i]-random(1000)/1000;
      end;
    end;

  end;
  if (nappi='z') then
  begin
    for i:=1 to 50 do
    begin
      if (neuronit[i].paalla=true) then
      begin
        if liikesynv[i]<1 then
          liikesynv[i]:=liikesynv[i]+random(1000)/1000;
        if liikesyno[i]>-1 then
          liikesyno[i]:=liikesyno[i]-random(1000)/1000;
      end;
      if neuronit[i].paalla=false then
      begin
        if liikesyno[i]<1 then
          liikesyno[i]:=liikesyno[i]+random(1000)/1000;
        if liikesynv[i]>-1 then
          liikesynv[i]:=liikesynv[i]-random(1000)/1000;
      end;
    end;

  end;
end;

procedure rankaise;
begin
  if opeta=true then
  begin

  if x>mailax+2 then
  begin
    for i:=1 to 50 do
    begin
{      if (neuronit[i].paalla=false) then
      begin
        if liikesynv[i]<3 then
          liikesynv[i]:=liikesynv[i]+random(1000)/5000;
        if liikesyno[i]>-3 then
          liikesyno[i]:=liikesyno[i]-random(1000)/5000;
      end;                                             }
      if neuronit[i].paalla=true then
      begin
        liikesyno[i]:=liikesyno[i]+random(1000)/1000;
        liikesynv[i]:=liikesynv[i]-random(1000)/1000;
      end;
    end;
  end;
  if x<mailax+2 then
  begin
    for i:=1 to 50 do
    begin
      if (neuronit[i].paalla=true) then
      begin
        liikesynv[i]:=liikesynv[i]+random(1000)/1000;
        liikesyno[i]:=liikesyno[i]-random(1000)/1000;
      end;
{      if neuronit[i].paalla=false then
      begin
        if liikesyno[i]<3 then
          liikesyno[i]:=liikesyno[i]+random(1000)/5000;
        if liikesynv[i]>-3 then
          liikesynv[i]:=liikesynv[i]-random(1000)/5000;
      end;}
    end;
  end;
  end;
  ammu;
end;

procedure mieti;
var
  g:integer;

begin
  for i:=1 to 50 do neuronit[i].paalla:=false;
  for i:=1 to 18 do syote[i]:=false;
  if (mailax-x)>100 then syote[1]:=true;
  if (x-mailax)>100 then syote[18]:=true;
  if ((mailax-x)>50)and((mailax-x)<100) then syote[2]:=true;
  if ((x-mailax)>50)and((x-mailax)<100) then syote[17]:=true;
  if ((mailax-x)>40)and((mailax-x)<50) then syote[3]:=true;
  if ((x-mailax)>40)and((x-mailax)<50) then syote[16]:=true;
  if ((mailax-x)>30)and((mailax-x)<40) then syote[4]:=true;
  if ((x-mailax)>30)and((x-mailax)<40) then syote[15]:=true;
  if ((mailax-x)>20)and((mailax-x)<30) then syote[5]:=true;
  if ((x-mailax)>20)and((x-mailax)<30) then syote[14]:=true;
  if ((mailax-x)>10)and((mailax-x)<20) then syote[6]:=true;
  if ((x-mailax)>10)and((x-mailax)<20) then syote[13]:=true;
  if ((mailax-x)>0)and((mailax-x)<10) then syote[7]:=true;
  if ((x-mailax)>0)and((x-mailax)<10) then syote[12]:=true;
  if (mailax=x) then syote[9]:=true;
  for i:=1 to 50 do
  begin
    neuronit[i].a:=0;
    for j:=1 to 18 do
    begin
      if syote[j]=true then
      begin
        neuronit[i].a:=neuronit[i].a+neuronit[i].syotker[j];
      end;
    end;
  end;

  for i:=1 to 50 do
  begin
    if neuronit[i].a>neuronit[i].toler then
    begin
      neuronit[i].paalla:=true;
    end
    else neuronit[i].paalla:=false;
  end;

  a:=0;
  b:=0;
  for i:=1 to 50 do
  begin
    if (neuronit[i].paalla=true) then a:=a+liikesynv[i];
    if (neuronit[i].paalla=true) then b:=b+liikesyno[i];
  end;
  vasen:=a;
  oikea:=b;
  if ((b-a)<-2) then liike:=-2;
  if (((b-a)<0)and((b-a)>=-2)) then liike:=-1;
  if ((a-b)<-2) then liike:=2;
  if (((a-b)<0)and((a-b)>=-2)) then liike:=1;
end;

procedure liiku;
begin
  if (mailax+liike>=295) then mailax:=294;
  if (mailax+liike<=100) then mailax:=101;
  if (mailax+liike<295)and(mailax+liike>100) then mailax:=mailax+liike;
end;

procedure piirra;
begin
  cls(0,vaddr);
  for i:=1 to 18 do if syote[i]=true then putpixel(i,0,4,vaddr);
  putpixel(1,0,2,vaddr);
  putpixel(9,0,2,vaddr);
  putpixel(18,0,2,vaddr);
  line(40,60,40,round(60+vasen*10),6,vaddr);
  line(50,60,50,round(60+oikea*10),6,vaddr);
  for i:=1 to 50 do if (neuronit[i].paalla=true) then putpixel(5+round((i-1)-int((i-1)/10)*10+1),
    5+round(int((i-1)/10)+1),14,vaddr);
  line(mailax,180,mailax+5,180,6,vaddr);
  line(99,0,99,199,6,vaddr);
  line(301,0,301,199,6,vaddr);
  putpixel(x,round(y),7,vaddr);
  flip;
end;

procedure pelaa;
begin
  kelaa;
  if (y>180) then rankaise;
  if (y+ysu<0) then ammu;
  if (x+xsu<100) then x:=105;
  if (x+xsu>295) then x:=290;
  if (x+xsu<=100)or(x+xsu>=295) then xsu:=-xsu;
  y:=y+ysu;
  x:=x+xsu;
  if (y=180)and(mailax<=x)and(mailax+5>=x) then palkitse;
  mieti;
  liiku;
  piirra;
end;

begin
  randomize;
  rankki:=random(1000)/1000;
  for i:=1 to 50 do for j:=1 to 18 do
  begin
    neuronit[i].syotker[j]:=(random(1000)-500)/1000;
  end;
  for i:=1 to 50 do
  begin
    neuronit[i].toler:=1;
  end;
  for i:=1 to 50 do
  begin
{    if random(2)=1 then}
    begin
    liikesynv[i]:=0.1;
    liikesyno[i]:=0.1;
    end;
{    else
    begin
    liikesynv[i]:=-0.1;
    liikesyno[i]:=0.1;
    end;}
  end;
  opeta:=false;
  mailax:=145;
  x:=145;
  y:=0;
  ysu:=1;
  xsu:=1;
  setmcga;
  setupvirtual;
  repeat
    pelaa;
    nappi:=' ';
    if keypressed then nappi:=readkey;
    if nappi='o' then opeta:=true;
  until nappi='q';
{  assign(f,'data.dat');
  rewrite(f);
  for i:=1 to 50 do
  begin
    write(liikesynv[i],f);
    write(liikesyno[i],f);
  end;
  for i:=1 to 50 do for j:=1 to 50 do
  begin
    write(neuronit[i].kerroin[j],f);
  end;
  for i:=1 to 50 do for j:=1 to 18 do
  begin
    write(neuronit[i].syotker[j],f);
  end;
  close(f);}
  shutdown;
  settext;
end.
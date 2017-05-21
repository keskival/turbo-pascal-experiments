{$M $8000 ,0,0}
program install;
uses crt,dos,strings;

var
  PURATTU,loppu:boolean;
  asema:byte;
  levy,hake:string;
  dirinfo:searchrec;
  tila:longint;

procedure apu;
begin
  writeln('Laita aseman kirjain nimen j„lkeen.');
  writeln('Jos et laita mit„„n, ohjelma asentuu ceelle.');
  loppu:=true;
  readkey;
end;

procedure alku;
begin
  clrscr;
  loppu:=false;
  if (paramstr(1)='?')or(paramstr(1)='h') then apu;
  if paramstr(1)<>'' then begin
    levy:=paramstr(1);
  end
  else levy:='C';
  IF PARAMSTR(1)='C' THEN ASEMA:=3;
  IF PARAMSTR(1)='D' THEN ASEMA:=4;
  IF PARAMSTR(1)='E' THEN ASEMA:=5;
  IF PARAMSTR(1)='F' THEN ASEMA:=6;
  IF PARAMSTR(1)='G' THEN ASEMA:=7;
  textcolor(Blue);
end;

procedure arjpurku;
begin
  hake:=dirinfo.name;
  delete(hake,length(dirinfo.name)-3,4);
  mkdir(levy+':'+hake);
  swapvectors;
  exec('C:\PURKU\ARJ.EXE',' X -V A:\*.ARJ '+levy+':'+HAKE);
  swapvectors;
  PURATTU:=TRUE;
end;

procedure zippurku;
begin
  hake:=dirinfo.name;
  delete(hake,length(dirinfo.name)-3,4);
  mkdir(levy+':'+hake);
  swapvectors;
  exec('C:\PURKU\PKUNZIP.EXE',' -D -O A:\*.ZIP '+levy+':'+HAKE);
  swapvectors;
  PURATTU:=TRUE;
end;

procedure asennusinf;
label a;

begin
  a:
  if loppu=false then begin
    clrscr;
    if loppu=false then begin
      tila:=diskfree(asema);
      if tila=-1 then begin
        writeln('Sinulla ei ole t„t„ asemaa!!!');
        readkey;
      end;
      writeln('Aloitetaan asennus');
      writeln('Etsii purattavaa tiedostoa');
      findfirst('A:\*.ARJ',anyfile,dirinfo);
      if doserror=0 then arjpurku;
      findfirst('A:\*.ZIP',anyfile,dirinfo);
      if doserror=0 then zippurku;
{    findfirst('A:\*.RAR',anyfile,dirinfo);
    if doserror=0 then rarpurku;
}     if purattu=false then writeln('Pakkauksen muoto tuntematon');
    end;
  end;
end;

procedure lopetus;
begin
  textcolor(lightgray);
end;

begin
  alku;
  asennusinf;
  lopetus;
end.

program esim;
uses crt;

var
  i:integer; {Kokonaislukumuuttuja}
  numero:integer; {Toinen kokonaislukumuuttuja}

begin
  clrscr; {Tyhjennet„„n n„ytt”}
  randomize; {Alustetaan satunnaislukugeneraattori}
  writeln('Lottorivi:'); {Tulostetaan teksti}
  for i:=1 to 6 do {Luodaan ja tulostetaan 6 ensimm„ist„ numeroa}
  begin
    numero:=random(39)+1;
    write(numero,', ');
  end;
  numero:=random(39)+1; {Luodaan viimeinen numero}
  writeln(numero); {Tulostetaan viimeinen numero}
  readkey; {Odotetaan n„pp„imen painamista}
end.
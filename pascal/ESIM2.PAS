program esim;
uses crt;

var
  i,j:integer; {Kokonaislukumuuttujia}
  montako,numero:integer; {Lis„„ kokonaislukumuuttujia}

begin
  clrscr; {Tyhjennet„„n n„ytt”}
  randomize; {Alustetaan satunnaislukugeneraattori}
  writeln('Montako lottorivi„ arvotaan? '); {Tulostetaan teksti}
  readln(montako); {Kysyt„„n lottorivien lukum„„r„}
  writeln(''); {Tyhj„ rivi}
  for j:=1 to montako do {Luodaan montako-muuttujan m„„r„„m„ m„„r„ lottorivej„}
  begin
    writeln('Lottorivi ',j,':'); {Tulostetaan teksti}
    for i:=1 to 6 do {Kuusi numeroa}
    begin
      numero:=random(39)+1; {random(39) on kokonaisluku v„lilt„ 0-38, johon lis„t„„n 1}
      write(numero,', ');
    end;
    numero:=random(39)+1; {Arvotaan viimeinen numero}
    writeln(numero); {Tulostetaan viimeinen lottorivin numero}
  end;
  readkey; {Odotetaan n„pp„imen painamista}
end.
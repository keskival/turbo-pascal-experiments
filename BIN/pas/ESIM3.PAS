program esim;
uses crt;

var
  i,j,apu:integer; {Kokonaislukumuuttujia}
  numero:array[1..7]of integer; {Taulukko kokonaislukumuuttujia}

begin
  clrscr; {Tyhjennet„„n n„ytt”}
  randomize; {Alustetaan satunnaislukugeneraattori}
  for i:=1 to 7 do {Arvotaan seitsem„n lukua}
  begin
    numero[i]:=random(39)+1;
  end;

  for j:=1 to 6 do for i:=1 to 6 do {K„yd„„n l„pi numero-taulukkoa}
  begin
    if numero[i]>numero[i+1] then {Jos vertailtavat ovat v„„r„ss„ j„rjestyksess„, niin k„„nnet„„n ne}
    begin
      apu:=numero[i+1];
      numero[i+1]:=numero[i];
      numero[i]:=apu;
    end;
  end;
  for i:=1 to 6 do {Tulostetaan 6 ensimm„ist„ numeroa}
  begin
    write(numero[i],', ');
  end;
  writeln(numero[7]); {Tulostetaan viimeinen numero}
  readkey; {Odotetaan n„pp„imen painallusta}
end.
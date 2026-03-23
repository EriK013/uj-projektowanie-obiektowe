program zadanie1;
procedure Random50;
var
    i : integer;

begin
    Randomize;

    writeln('50 losowych liczb: ');

    for i := 1 to 50 do
    begin 
        writeln(Random(101));
    end;

    writeln;
end;

begin
    Random50;
end.

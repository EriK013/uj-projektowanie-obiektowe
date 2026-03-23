program zadanie1;

{$mode objfpc}{$H+}

type
    TIntArray = array of integer;

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

procedure BubbleSort(var arr : TIntArray);

var
    i, j, k, temp : integer;
begin
    i := High(arr);
    if i < 0 then Exit;

    repeat
        j := 0;
        for k := 1 to i do
          begin
            if arr[k - 1] > arr[k] then
              begin 
                temp := arr[k - 1];
                arr[k - 1] := arr[k];
                arr[k] := temp;
                j := k;
              end;
          end;
        i := j;
    until i <= 0;
end;

begin
    Randomize;
end.

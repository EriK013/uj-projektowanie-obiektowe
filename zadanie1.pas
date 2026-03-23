program zadanie1;
{$mode objfpc}{$H+}

type
    TIntArray = array of integer;

procedure RandomNumbers(start, stop, count : integer; out arr : TIntArray; display : Boolean = False);
var
    i : integer;

begin
    SetLength(arr, count);
    if display then writeln(count, ' losowych liczb: ');

    for i := 0 to count - 1 do
    begin 
        arr[i] := Random(stop - start + 1) + start;
        if display then write(arr[i], ' ');
    end;
    if display then writeln;
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

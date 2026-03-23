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

procedure Test;
var
    arrTest : TIntArray;
    i, passed : integer;
    testFlag : Boolean;
begin
    passed := 0;

    writeln('TEST 1: poprawna liczba elementów');
    RandomNumbers(0, 100, 10, arrTest);
    if Length(arrTest) = 10 then 
    begin
        writeln('TEST 1: OK');
        passed := passed + 1;
    end
    else
        writeln('TEST 1: Błędna długość tablicy');
    
    testFlag := True;
    writeln('TEST 2: poprawny zakres losowanych liczb');
    RandomNumbers(10, 20, 50, arrTest);
    for i := 0 to High(arrTest) do
    begin
        if (arrTest[i] < 10) or (arrTest[i] > 20) then
        begin
            writeln('TEST 2: Błąd zakresu liczb: ', arrTest[i]);
            testFlag := False;
            Break;
        end;
    end;
    if testFlag then
    begin
        writeln('TEST 2: OK');
        passed := passed + 1;
    end;

    testFlag := True;
    writeln('TEST 3: poprawne sortowanie');
    RandomNumbers(0, 100, 20, arrTest);
    BubbleSort(arrTest);
    for i := 0 to High(arrTest) - 1 do
    begin
        if arrTest[i] > arrTest[i + 1] then
        begin
            writeln('TEST 3: Błąd sortowania: ', arrTest[i], ' > ', arrTest[i + 1]);
            testFlag := False;
            Break;
        end;
    end;
    if testFlag then
    begin
        writeln('TEST 3: OK');
        passed := passed + 1;
    end;

    writeln('TEST 4: sortowanie pustej tablicy');
    RandomNumbers(0, 100, 0, arrTest);
    BubbleSort(arrTest);
    if Length(arrTest) = 0 then
    begin
        writeln('TEST 4: OK');
        passed := passed + 1;
    end
    else
        writeln('TEST 4: Błąd sortowania pustej tablicy');

    writeln('TEST 5: sortowanie tablicy z jednym elementem');
    RandomNumbers(0, 100, 1, arrTest);
    BubbleSort(arrTest);
    if Length(arrTest) = 1 then
    begin
        writeln('TEST 5: OK');
        passed := passed + 1;
    end
    else
        writeln('TEST 5: Błąd sortowania tablicy z jednym elementem');


    writeln('Zakończono testy. Poprawnych: ', passed, '/5');
end;

begin
    Randomize;
    Test;
end.

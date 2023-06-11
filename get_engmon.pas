unit get_engmon;

interface

uses kernel;

procedure BoxGetEngMon;
procedure ShowGetEngMon;
procedure ShowGetEngMon_Empty;

var
  mpdwEngMon:   array[0..3,1..MONTHS] of longword; 
  mpfEngMon:    array[0..3,1..MONTHS] of boolean; 
  mpfEmptyMon:  array[1..MONTHS] of boolean;

implementation

uses SysUtils, support, soutput, progress, box, realz, timez, calendar, get_koeffs;

const
  quGetEngMon:  querys = (Action: acGetEngMon; cwOut: 2+2+2; cwIn: 1+16+2; bNumber: 0);

var
  bMon:         byte;

procedure QueryGetEngMon;
begin
  InitPushZero;
  PushByte(GetDeviceAddr);
  PushByte(5);
  PushByte($30 or bMon);
  PushByte(0);
  Query(quGetEngMon, True);
end;

procedure BoxGetEngMon;
var
  i,j:  byte;
begin
  AddInfo('');

  for i := 0 to 3 do 
    for j := 1 to MONTHS do begin
      mpdwEngMon[i][j] := 0;
      mpfEngMon[i][j] := False;
      mpfEmptyMon[j] := True;
    end;

  bMon := 1;
  QueryGetEngMon;
end;

procedure EndGetEngMon;
var
  i,j:  byte;
  s,z:  string;
begin
    AddInfo('');
    AddInfo('');
    AddInfo('»мпульсы по мес€цам');

    s := PackStrR('',GetColWidth);
    for j := 1 to MONTHS do s := s + PackStrR(Times2StrMon(MonIndexToDate(DateToMonIndex(tiCurr)-((12+tiCurr.bMonth-j) mod 12))),GetColWidth);
    AddInfo(s);
    s := PackStrR('',GetColWidth);
    for j := 1 to MONTHS do s := s + PackStrR('мес€ц '+IntToStr(j),GetColWidth);
    AddInfo(s);

    for i := 0 to 3 do begin
      s := PackStrR(GetCanalName(i),GetColWidth);
      for j := 1 to MONTHS do begin
        if mpfEmptyMon[j] then
          z := PackStrR('нет',GetColWidth)
        else
          z := PackStrR(IntToStr(mpdwEngMon[i][j]),GetColWidth);
        s := s + z;
      end;
      AddInfo(s);
    end;

    AddInfo('');
    AddInfo('Ёнерги€ по мес€цам');

    s := PackStrR('',GetColWidth);
    for j := 1 to MONTHS do s := s + PackStrR(Times2StrMon(MonIndexToDate(DateToMonIndex(tiCurr)-((12+tiCurr.bMonth-j) mod 12))),GetColWidth);
    AddInfo(s);
    s := PackStrR('',GetColWidth);
    for j := 1 to MONTHS do s := s + PackStrR('мес€ц '+IntToStr(j),GetColWidth);
    AddInfo(s);

    for i := 0 to 3 do begin
      s := PackStrR(GetCanalName(i),GetColWidth);
      for j := 1 to MONTHS do begin
        if mpfEmptyMon[j] then
          z := PackStrR('нет',GetColWidth)
        else
          z := Reals2StrR(mpdwEngMon[i][j]*kE);
        s := s + z;
      end;
      AddInfo(s);
    end;

    BoxRun;
end;

procedure ShowGetEngMon;
var
  i,j:  byte;
  s:    string;
begin
  Stop;
  InitPop(1);

  for i := 0 to 3 do begin
    mpdwEngMon[i][bMon] := PopByte*$1000000 + PopByte*$10000 + PopByte*$100 + PopByte;
    mpfEngMon[i][bMon] := True;
    mpfEmptyMon[bMon] := False;
  end;

  ShowProgress(bMon-1,MONTHS);

  Inc(bMon);
  if (bMon <= MONTHS) then
    QueryGetEngMon
  else begin
    EndGetEngMon;
  end;
end;

procedure ShowGetEngMon_Empty;
var
  i,j:  byte;
  s:    string;
begin
  Stop;

  AddInfo('Ќет данных за мес€ц: '+IntToStr(bMon));
  ShowProgress(bMon-1,MONTHS);

  Inc(bMon);
  if (bMon <= MONTHS) then
    QueryGetEngMon
  else begin
    EndGetEngMon;
  end;
end;

end.


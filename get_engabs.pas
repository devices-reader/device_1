unit get_engabs;

interface

procedure BoxGetEngAbs;
procedure ShowGetEngAbs;

var
  mpdwEngAbs:   array[0..3] of longword; 

implementation

uses SysUtils, support, soutput, box, realz, get_koeffs;

const
  quGetEngAbs:  querys = (Action: acGetEngAbs; cwOut: 2+2+2; cwIn: 1+16+2; bNumber: 0);

procedure QueryGetEngAbs;
begin
  InitPushZero;
  PushByte(GetDeviceAddr);
  PushByte(5);
  PushByte(0);
  PushByte(0);
  Query(quGetEngAbs, True);
end;

procedure BoxGetEngAbs;
begin
  QueryGetEngAbs;
end;

procedure ShowGetEngAbs;
var
  i:    byte;
  s:    string;
begin
  Stop;
  InitPop(1);

  for i := 0 to 3 do
    mpdwEngAbs[i] := PopByte*$1000000 + PopByte*$10000 + PopByte*$100 + PopByte;
  
  AddInfo('');
  AddInfo('');
  AddInfo('»мпульсы всего');

  s := PackStrR('',GetColWidth);
  s := s + PackStrR('всего',GetColWidth);
  AddInfo(s);

  for i := 0 to 3 do begin
    s := PackStrR(GetCanalName(i),GetColWidth);
    s := s + PackStrR(IntToStr(mpdwEngAbs[i]),GetColWidth);
    AddInfo(s);
  end;
    
  AddInfo('');
  AddInfo('Ёнерги€ всего');

  s := PackStrR('',GetColWidth);
  s := s + PackStrR('всего',GetColWidth);
  AddInfo(s);

  for i := 0 to 3 do begin
    s := PackStrR(GetCanalName(i),GetColWidth);
    s := s + Reals2StrR(mpdwEngAbs[i]*kE);
    AddInfo(s);
  end;
    
  BoxRun;
end;

end.


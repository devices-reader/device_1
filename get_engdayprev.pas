unit get_engdayprev;

interface

procedure BoxGetEngDayPrev;
procedure ShowGetEngDayPrev;

var
  mpdwEngDayPrev:   array[0..3] of longword; 

implementation

uses SysUtils, support, soutput, progress, kernel, box, realz, timez, calendar, get_koeffs;

const
  quGetEngDayPrev:  querys = (Action: acGetEngDayPrev; cwOut: 2+2+2; cwIn: 1+16+2; bNumber: 0);

procedure QueryGetEngDayPrev;
begin
  InitPushZero;
  PushByte(GetDeviceAddr);
  PushByte(5);
  PushByte($50);
  PushByte(0);
  Query(quGetEngDayPrev, True);
end;

procedure BoxGetEngDayPrev;
begin
  QueryGetEngDayPrev;
end;

procedure ShowGetEngDayPrev;
var
  i:  byte;
  s:  string;
begin
  Stop;
  InitPop(1);

  for i := 0 to 3 do
    mpdwEngDayPrev[i] := PopByte*$1000000 + PopByte*$10000 + PopByte*$100 + PopByte;
  
  AddInfo('');
  AddInfo('');
  AddInfo('»мпульсы за предыдущие сутки');

  s := PackStrR('',GetColWidth);
  s := s + PackStrR('всего',GetColWidth);
  AddInfo(s);

  for i := 0 to 3 do begin
    s := PackStrR(GetCanalName(i),GetColWidth);
    s := s + PackStrR(IntToStr(mpdwEngDayPrev[i]),GetColWidth);
    AddInfo(s);
  end;
    
  AddInfo('');
  AddInfo('Ёнерги€ за предыдущие сутки');

  s := PackStrR('',GetColWidth);
  s := s + PackStrR('всего',GetColWidth);
  AddInfo(s);

  for i := 0 to 3 do begin
    s := PackStrR(GetCanalName(i),GetColWidth);
    s := s + Reals2StrR(mpdwEngDayPrev[i]*kE);
    AddInfo(s);
  end;
    
  BoxRun;
end;

end.


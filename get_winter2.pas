unit get_winter2;

interface

procedure BoxGetWinter2;
procedure ShowGetWinter2;

implementation

uses SysUtils, support, soutput, timez, box;

const
  quGetWinter2:  querys = (Action: acGetWinter2; cwOut: 3+0+2; cwIn: 1+3+2; bNumber: 0);

procedure QueryGetWinter2;
begin
  InitPushZero;
  PushByte(GetDeviceAddr);
  PushByte(8);
  PushByte(8);
  Query(quGetWinter2, True);
end;

procedure BoxGetWinter2;
begin
  AddInfo('');
  AddInfo('');
  AddInfo('Время перехода на зимнее время');
  QueryGetWinter2;
end;

procedure ShowGetWinter2;
var
  a,b,c:  byte;
begin
  Stop;
  InitPop(1);

  a := FromBCD(PopByte);
  b := FromBCD(PopByte);
  c := FromBCD(PopByte);
  
  AddInfo('час:              ' + IntToStr(a));
  AddInfo('день недели:      ' + GetWeekdayName(b));
  AddInfo('месяц:            ' + IntToStr(c));

  AddInfo('');
  AddInfo('Чтение времени - проведено успешно');
end;

end.

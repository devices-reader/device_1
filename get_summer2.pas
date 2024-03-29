unit get_summer2;

interface

procedure BoxGetSummer2;
procedure ShowGetSummer2;

implementation

uses SysUtils, support, soutput, timez, box, get_winter2;

const
  quGetSummer2:  querys = (Action: acGetSummer2; cwOut: 3+0+2; cwIn: 1+3+2; bNumber: 0);

procedure QueryGetSummer2;
begin
  InitPushZero;
  PushByte(GetDeviceAddr);
  PushByte(8);
  PushByte(7);
  Query(quGetSummer2, True);
end;

procedure BoxGetSummer2;
begin
  AddInfo('');
  AddInfo('');
  AddInfo('����� �������� �� ������ �����');
  QueryGetSummer2;
end;

procedure ShowGetSummer2;
var
  a,b,c:  byte;
begin
  Stop;
  InitPop(1);

  a := FromBCD(PopByte);
  b := FromBCD(PopByte);
  c := FromBCD(PopByte);
  
  AddInfo('���:              ' + IntToStr(a));
  AddInfo('���� ������:      ' + GetWeekdayName(b));
  AddInfo('�����:            ' + IntToStr(c));

  BoxGetWinter2;
end;

end.

unit get_winter;

interface

procedure BoxGetWinter;
procedure ShowGetWinter;

implementation

uses SysUtils, support, soutput, timez, box;

const
  quGetWinter:  querys = (Action: acGetWinter; cwOut: 3+0+2; cwIn: 1+3+2; bNumber: 0);

procedure QueryGetWinter;
begin
  InitPushZero;
  PushByte(GetDeviceAddr);
  PushByte(8);
  PushByte(8);
  Query(quGetWinter, True);
end;

procedure BoxGetWinter;
begin
  AddInfo('');
  AddInfo('');
  AddInfo('����� �������� �� ������ �����');
  QueryGetWinter;
end;

procedure ShowGetWinter;
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
  
  BoxRun;
end;

end.

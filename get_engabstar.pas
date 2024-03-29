unit get_engabstar;

interface

procedure BoxGetEngAbsTar;
procedure ShowGetEngAbsTar;

var
  mpdwEngAbsTar:   array[0..3,0..4] of longword; 

implementation

uses SysUtils, support, soutput, progress, box, realz, get_koeffs;

const
  quGetEngAbsTar:  querys = (Action: acGetEngAbsTar; cwOut: 2+2+2; cwIn: 1+16+2; bNumber: 0);

var
  bTar:            byte;

procedure QueryGetEngAbsTar;
begin
  InitPushZero;
  PushByte(GetDeviceAddr);
  PushByte(5);
  PushByte($00);
  PushByte(bTar);
  Query(quGetEngAbsTar, True);
end;

procedure BoxGetEngAbsTar;
var
  i:  byte;
begin
  for i := 0 to 3 do
    mpdwEngAbsTar[i][0] := 0;
  
  bTar := 1;
  QueryGetEngAbsTar;
end;

procedure ShowGetEngAbsTar;
var
  i,j:  byte;
  s:    string;
begin
  Stop;
  InitPop(1);

  for i := 0 to 3 do begin
    mpdwEngAbsTar[i][bTar] := PopByte*$1000000 + PopByte*$10000 + PopByte*$100 + PopByte;
    Inc(mpdwEngAbsTar[i][0], mpdwEngAbsTar[i][bTar]);
  end;  

  ShowProgress(bTar-1,4);
  
  Inc(bTar);
  if (bTar <= 4) then
    QueryGetEngAbsTar
  else begin  
    AddInfo('');
    AddInfo('');
    AddInfo('�������� ����� (�� �������)');

    s := PackStrR('',GetColWidth);
    for j := 1 to 4 do s := s + PackStrR('����� '+IntToStr(j),GetColWidth);
    s := s + PackStrR('�����',GetColWidth);
    AddInfo(s);

    for i := 0 to 3 do begin
      s := PackStrR(GetCanalName(i),GetColWidth);
      for j := 1 to 4 do s := s + PackStrR(IntToStr(mpdwEngAbsTar[i][j]),GetColWidth);
      s := s + PackStrR(IntToStr(mpdwEngAbsTar[i][0]),GetColWidth);
      AddInfo(s);
    end;
    
    AddInfo('');
    AddInfo('������� ����� (�� �������)');

    s := PackStrR('',GetColWidth);
    for j := 1 to 4 do s := s + PackStrR('����� '+IntToStr(j),GetColWidth);
    s := s + PackStrR('�����',GetColWidth);
    AddInfo(s);

    for i := 0 to 3 do begin
      s := PackStrR(GetCanalName(i),GetColWidth);
      for j := 1 to 4 do s := s + Reals2StrR(mpdwEngAbsTar[i][j]*kE);
      s := s + Reals2StrR(mpdwEngAbsTar[i][0]*kE);
      AddInfo(s);
    end;
    
    BoxRun;
  end;    
end;

end.


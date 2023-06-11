unit get_info;

interface

uses box;

procedure BoxGetInfo(i: byte);
procedure ShowGetInfo(i: byte);
function GetInfoName(i: byte): string;
function GetInfoQuery(i: byte): querys;

const
  quGetInfo1:   querys = (Action: acGetInfo1;  cwOut: 2+1+2; cwIn: 1+14+2; bNumber: 0);
  quGetInfo2:   querys = (Action: acGetInfo2;  cwOut: 2+1+2; cwIn: 1+14+2; bNumber: 0);
  quGetInfo3:   querys = (Action: acGetInfo3;  cwOut: 2+1+2; cwIn:  1+7+2; bNumber: 0);
  quGetInfo4:   querys = (Action: acGetInfo4;  cwOut: 2+1+2; cwIn:  1+7+2; bNumber: 0);
  quGetInfo5:   querys = (Action: acGetInfo5;  cwOut: 2+1+2; cwIn:  1+7+2; bNumber: 0);
  quGetInfo6:   querys = (Action: acGetInfo6;  cwOut: 2+1+2; cwIn:  1+7+2; bNumber: 0);
  quGetInfo7:   querys = (Action: acGetInfo7;  cwOut: 2+1+2; cwIn: 1+14+2; bNumber: 0);
  quGetInfo8:   querys = (Action: acGetInfo8;  cwOut: 2+1+2; cwIn: 1+14+2; bNumber: 0);
  quGetInfo9:   querys = (Action: acGetInfo9;  cwOut: 2+1+2; cwIn: 1+14+2; bNumber: 0);
  quGetInfo10:  querys = (Action: acGetInfo10; cwOut: 2+1+2; cwIn: 1+14+2; bNumber: 0);

implementation

uses SysUtils, support, soutput, timez, crc, terminal, progress;

var
  ibInfo:   byte;
  mpInfo:   array[1..10,0..1] of times;

function GetInfoSize(i: byte): byte;
begin
  if i in [1..2,7..10]
    then Result := 14
  else 
    Result := 7
end;

function GetInfoName(i: byte): string;
begin
  case i of
     1: Result := 'Журнал 1: время выключения/включения прибора';
     2: Result := 'Журнал 2: время до/после коррекции часов прибора';
     3: Result := 'Журнал 3: время коррекции расписания праздничных дней';
     4: Result := 'Журнал 4: время коррекции тарифного расписания';
     5: Result := 'Журнал 5: время сброса регистров накопленной энергии';
     6: Result := 'Журнал 6: время сброса массива средних мощностей';     
     7: Result := 'Журнал 7: время выключения/включения фазы 1 прибора';
     8: Result := 'Журнал 8: время выключения/включения фазы 2 прибора';
     9: Result := 'Журнал 9: время выключения/включения фазы 3 прибора';
    10: Result := 'Журнал 10: время открытия/закрытия крышки прибора';
  end;
end;

procedure QueryGetInfo(i: byte; j: byte);
begin
  InitPushZero;
  PushByte(GetDeviceAddr);
  PushByte(4);
  PushByte((i shl 4) or j);
  Query(GetInfoQuery(i), True);
end;

procedure BoxGetInfo(i: byte);
begin
  AddInfo('');
  AddInfo(GetInfoName(i));

  ibInfo := 0;
  QueryGetInfo(i,ibInfo);
end;

function GetInfoQuery(i: byte): querys;
begin
  case i of
    1:   Result := quGetInfo1;
    2:   Result := quGetInfo2;
    3:   Result := quGetInfo3;
    4:   Result := quGetInfo4;
    5:   Result := quGetInfo5;
    6:   Result := quGetInfo6;
    7:   Result := quGetInfo7;
    8:   Result := quGetInfo8;
    9:   Result := quGetInfo9;
    10:  Result := quGetInfo10;
  end;
end;

function PopTimesBCD: times;
begin
  with Result do begin
    bSecond := FromBCD(PopByte);
    bMinute := FromBCD(PopByte);
    bHour   := FromBCD(PopByte);
    PopByte;
    bDay    := FromBCD(PopByte);
    bMonth  := FromBCD(PopByte);
    bYear   := FromBCD(PopByte);
  end;
end;

procedure ShowGetInfo(i: byte);
var
  s:  string;
  j:  byte;
begin
  Stop;

  InitPop(1);  
  s := 'Дамп: ';
  for j := 0 to GetInfoSize(i)+3-1 do begin
    s := s + IntToHex(PopByte,2) + ' ';
  end;
  //AddInfo(s);
  
  InitPop(1);
  if i in [3..6] then begin
    mpInfo[i][0] := PopTimesBCD;
    AddInfo(Times2Str(mpInfo[i][0]));
  end;

  if i in [1..2,7..10] then begin
    mpInfo[i][0] := PopTimesBCD;
    mpInfo[i][1] := PopTimesBCD;
    AddInfo(Times2Str(mpInfo[i][0]) + '   ' +Times2Str(mpInfo[i][1]));
  end;

  ShowProgress(ibInfo,10);
  if ibInfo < 10-1 then begin
    Inc(ibInfo);
    QueryGetInfo(i,ibInfo);
  end
  else BoxRun;
end;

end.

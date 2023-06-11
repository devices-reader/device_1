unit get_graph_header;

interface

uses timez;

procedure BoxGetGraphHeader;
procedure ShowGetGraphHeader;

var
  tiGraphHeader: times;

implementation

uses SysUtils, support, soutput, box, get_graph_top, get_graph_data;

const
  quGetGraphHeader:  querys = (Action: acGetGraphHeader; cwOut: 3+3+2; cwIn: 1+8+2; bNumber: 0);

procedure QueryGetGraphHeader;
var
  x:  word;
begin
  InitPushZero;
  PushByte(GetDeviceAddr);
  PushByte(6);
  PushByte(3);

  x := wGraphTop*24;
  PushByte(x div $100);
  PushByte(x mod $100);

  PushByte(8);
  
  Query(quGetGraphHeader, True);
end;

procedure BoxGetGraphHeader;
begin
  AddTerm('Заголовок блока');
  QueryGetGraphHeader;
end;

procedure ShowGetGraphHeader;
var
  s,z:  string;
  x:    word;  
begin
  Stop;
  InitPop(1);

  with tiGraphHeader do begin
    bHour   := FromBCD(PopByte);
    bDay    := FromBCD(PopByte);
    bMonth  := FromBCD(PopByte);
    bYear   := FromBCD(PopByte);

    s :=    Int2Str(bHour)   + '   ' +
      ' ' + Int2Str(bDay)    +
      '.' + Int2Str(bMonth)  +
      '.' + Int2Str(bYear);    
  end;

  s := PackStrR(s,3*GetColWidth div 2) + 
       PackStrR(IntToStr(wGraphTop),5) + 
       PackStrR('0x' + IntToHex(wGraphTop*24,4),GetColWidth);
  
  s := s + 
       PackStrR(GetSeasonName(PopByte),GetColWidth) + 
       PackStrR('период: '+IntToStr(PopByte),GetColWidth);

  InitPop(1);
  x := PopByte + PopByte + PopByte + PopByte + PopByte + PopByte;
  if x mod $100 = PopByte then z := 'да ' else z := 'нет';
    
  AddInfo('');  
  AddInfo(s + 'к.сумма: ' + z);

  BoxGetGraphData;  
end;

end.

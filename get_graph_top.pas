unit get_graph_top;

interface

procedure BoxGetGraphTop;
procedure ShowGetGraphTop;

var
  wGraphTop:    word;
  wGraphCount:  word;

implementation

uses SysUtils, support, soutput, timez, box, kernel, get_graph_header, t_profile2, main;
  
const
  quGetGraphTop:  querys = (Action: acGetGraphTop; cwOut: 3+0+2; cwIn: 1+7+2; bNumber: 0);

procedure QueryGetGraphTop;
begin
  InitPushZero;
  PushByte(GetDeviceAddr);
  PushByte(8);
  PushByte(4);
  Query(quGetGraphTop, True);
end;

procedure BoxGetGraphTop;
begin
  AddTerm('Указатель на вершину блоков');
  QueryGetGraphTop;
end;

procedure ShowGetGraphTop;
var
  ti:   times;
  s,z:  string;
  x:    byte;
  y:    word;
begin
  Stop;
  InitPop(1);

  with ti do begin
    x := PopByte;
    bMinute := FromBCD(x and $7F);
    bHour   := FromBCD(PopByte);
    bDay    := FromBCD(PopByte);
    bMonth  := FromBCD(PopByte);
    bYear   := FromBCD(PopByte);

    s :=    Int2Str(bHour)   +
      ':' + Int2Str(bMinute) +
      ' ' + Int2Str(bDay)    +
      '.' + Int2Str(bMonth)  +
      '.' + Int2Str(bYear);    
  end;

  y := PopByte*$100+PopByte;

  AddInfo('');
  AddInfo('Энергия по часам:');
  
  AddInfo('Вершина: ');
  s := PackStrR(s,3*GetColWidth div 2) + 
       PackStrR(IntToStr(y div 24),5) + 
       PackStrR('0x' + IntToHex(y,4),GetColWidth);
      
  if x and $80 <> 0 then z := 'да ' else z := 'нет';
  AddInfo(s + 'переполнение: ' + z);

  wGraphTop := y div 24;
  wGraphTop := (wGraphMax + wGraphTop - frmMain.updGraphOffset.Position) mod wGraphMax; 
  
  AddInfo('Вершина с учетом смещения ' + IntToStr(frmMain.updGraphOffset.Position) + ': ' +IntToStr(wGraphTop));
  
  wGraphCount := 0;
  InitProfile;
  BoxGetGraphHeader;  
end;

end.

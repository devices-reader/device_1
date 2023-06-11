unit get_graph_data;

interface

procedure BoxGetGraphData;
procedure ShowGetGraphData;

implementation

uses SysUtils, support, soutput, timez, box, kernel, calendar, get_koeffs, get_graph_top, get_graph_header, t_profile2, main;

const
  quGetGraphData:  querys = (Action: acGetGraphData; cwOut: 3+3+2; cwIn: 1+16+2; bNumber: 0);
  
procedure QueryGetGraphData;
var
  x:  word;
begin
  InitPushZero;
  PushByte(GetDeviceAddr);
  PushByte(6);
  PushByte(3);

  x := wGraphTop*24 + 8;
  PushByte(x div $100);
  PushByte(x mod $100);

  PushByte(16);
  
  Query(quGetGraphData, True);
end;

procedure BoxGetGraphData;
begin
  AddTerm('Данные блока');
  QueryGetGraphData;
end;

procedure ShowGetGraphData;
var
  s:    string;
  i,j:  byte;
  y:    word;
  e:    extended;
begin
  Stop;
  InitPop(1);
  
  for j := 0 to 1 do begin
    s := '';
    for i := 1 to 4 do begin
      y := (PopByte*$100 + PopByte) and $7FFF;
      s := s + PackStrR(IntToStr(y),GetColWidth);

      e := y * kE * 2;
      AddProfile(i, e, y, HalfIndexToDate(DateToHalfIndex(tiGraphHeader)+j));
    end;  
    AddInfo(s);
  end;

  wGraphTop := (wGraphMax + wGraphTop - 1) mod wGraphMax; 

  Inc(wGraphCount);    
  if wGraphCount < frmMain.updGraphCount.Position then 
    BoxGetGraphHeader
  else begin
    frmMain.AddInfoAll(ResultProfile);
    BoxRun; 
  end; 
end;

end.

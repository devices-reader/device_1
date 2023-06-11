unit box;

interface

uses SysUtils, AdTapi, timez;

type
  actions =
  (
    acGetOpen,
    acGetTime,
    acGetId,
    acGetVersion,
    acGetFlags,
    acGetSummer,
    acGetWinter,
    
    acGetTrans,
    acGetPulse,
    acGetEngAbs,
    acGetEngAbsTar,
    acGetEngMon,
    acGetEngDayCur,
    acGetEngDayCurTar,
    acGetEngDayPrev,
    acGetCalc1,
    acGetCalc2,
    
    acGetGraphTop,

    acGetInfo1,
    acGetInfo2,
    acGetInfo3,
    acGetInfo4,
    acGetInfo5,
    acGetInfo6,
    acGetInfo7,
    acGetInfo8,
    acGetInfo9,
    acGetInfo10,
    
    acNone,
    acTransit,

    acGetGraphHeader,
    acGetGraphData,
    
    acGetOpen2,
    acGetTime2,
    acGetCorrect2,
    acGetSetup2,
    
    acGetFlags2,
    acGetSummer2,
    acGetWinter2,

    acGetDisableSeasonTime,
    acGetEnableSeasonTime
  );

  querys = record
    Action:     actions;
    cwOut:      word;
    cwIn:       word;
    bNumber:    byte;
  end;

procedure BoxCreate;
procedure BoxRun;
procedure BoxRead;
procedure BoxShow(ac: actions);
function BoxVariousSize(cwIn: word; ac: actions): boolean;

var
  cwConnect:  longword;
  tiCurr:     times;

implementation

uses main, support, progress, terminal,
get_open, 
get_time, get_id, get_version, get_flags, get_summer, get_winter,
get_koeffs,
get_engabs, get_engabstar, get_engdaycur, get_engdaycurtar, get_engdayprev, get_engmon,
get_calc1,
get_calc2,
get_graph_top,
get_graph_header,
get_graph_data,
get_info,
get_open2, get_time2, get_correct2, get_setup2,
get_flags2, get_summer2, get_winter2,
get_disable_season_time, get_enable_season_time  
;

var
  BoxStart:   TDateTime;
  iwBox:      word;

procedure BoxCreate;
var
  i:  word;
begin
  with frmMain.clbMain do begin
    for i := 1 to Ord(acNone) do Items.Add('?');
    Items[Ord(acGetOpen)]         := 'Открытие канала';
    Items[Ord(acGetTime)]         := 'Время';
    Items[Ord(acGetId)]           := 'Логический номер';
    Items[Ord(acGetVersion)]      := 'Версия';
    Items[Ord(acGetFlags)]        := 'Конфигурация';
    Items[Ord(acGetSummer)]       := 'Время перехода на летнее время';
    Items[Ord(acGetWinter)]       := 'Время перехода на зимнее время';

    Items[Ord(acGetTrans)]        := 'К. трансформации';
    Items[Ord(acGetPulse)]        := 'К. преобразования';
    Items[Ord(acGetEngAbs)]       := 'Энергия всего';
    Items[Ord(acGetEngAbsTar)]    := 'Энергия всего (по тарифам)';
    Items[Ord(acGetEngMon)]       := 'Энергия по месяцам';
    Items[Ord(acGetEngDayCur)]    := 'Энергия за текущие сутки';
    Items[Ord(acGetEngDayCurTar)] := 'Энергия за текущие сутки (по тарифам)';
    Items[Ord(acGetEngDayPrev)]   := 'Энергия за предыдущие сутки';
    Items[Ord(acGetCalc1)]        := 'Счетчики на начало текущих суток (по тарифам) - расчет';
    Items[Ord(acGetCalc2)]        := 'Счетчики по месяцам - расчет';

    Items[Ord(acGetGraphTop)]     := 'Энергия по часам';
    
    Items[Ord(acGetInfo1)]        := GetInfoName(1);
    Items[Ord(acGetInfo2)]        := GetInfoName(2);
    Items[Ord(acGetInfo3)]        := GetInfoName(3);
    Items[Ord(acGetInfo4)]        := GetInfoName(4);
    Items[Ord(acGetInfo5)]        := GetInfoName(5);
    Items[Ord(acGetInfo6)]        := GetInfoName(6);
    Items[Ord(acGetInfo7)]        := GetInfoName(7);
    Items[Ord(acGetInfo8)]        := GetInfoName(8);
    Items[Ord(acGetInfo9)]        := GetInfoName(9);
    Items[Ord(acGetInfo10)]       := GetInfoName(10);
  end;
end;

procedure BoxRun;
var
  b:  boolean;
begin
  with frmMain do begin
    with clbMain do  while (iwBox < Items.Count) do begin
      if Checked[iwBox] then begin
        case iwBox of
          Ord(acGetOpen):         begin BoxGetOpen;         Inc(iwBox); exit; end;
          Ord(acGetTime):         begin BoxGetTime;         Inc(iwBox); exit; end;
          Ord(acGetId):           begin BoxGetId;           Inc(iwBox); exit; end;
          Ord(acGetVersion):      begin BoxGetVersion;      Inc(iwBox); exit; end;
          Ord(acGetFlags):        begin BoxGetFlags;        Inc(iwBox); exit; end;
          Ord(acGetSummer):       begin BoxGetSummer;       Inc(iwBox); exit; end;
          Ord(acGetWinter):       begin BoxGetWinter;       Inc(iwBox); exit; end;
        
          Ord(acGetTrans):        begin BoxGetTrans;        Inc(iwBox); exit; end;
          Ord(acGetPulse):        begin BoxGetPulse;        Inc(iwBox); exit; end;
          Ord(acGetEngAbs):       begin BoxGetEngAbs;       Inc(iwBox); exit; end;
          Ord(acGetEngAbsTar):    begin BoxGetEngAbsTar;    Inc(iwBox); exit; end;        
          Ord(acGetEngMon):       begin BoxGetEngMon;       Inc(iwBox); exit; end;        
          Ord(acGetEngDayCur):    begin BoxGetEngDayCur;    Inc(iwBox); exit; end;
          Ord(acGetEngDayCurTar): begin BoxGetEngDayCurTar; Inc(iwBox); exit; end;
          Ord(acGetEngDayPrev):   begin BoxGetEngDayPrev;   Inc(iwBox); exit; end;
          Ord(acGetCalc1):        begin BoxGetCalc1;        Inc(iwBox); exit; end;
          Ord(acGetCalc2):        begin BoxGetCalc2;        Inc(iwBox); exit; end;        
        
          Ord(acGetGraphTop):   begin BoxGetGraphTop;   Inc(iwBox); exit; end;        
        
          Ord(acGetInfo1):      begin BoxGetInfo(1);    Inc(iwBox); exit; end;
          Ord(acGetInfo2):      begin BoxGetInfo(2);    Inc(iwBox); exit; end;
          Ord(acGetInfo3):      begin BoxGetInfo(3);    Inc(iwBox); exit; end;
          Ord(acGetInfo4):      begin BoxGetInfo(4);    Inc(iwBox); exit; end;
          Ord(acGetInfo5):      begin BoxGetInfo(5);    Inc(iwBox); exit; end;
          Ord(acGetInfo6):      begin BoxGetInfo(6);    Inc(iwBox); exit; end;
          Ord(acGetInfo7):      begin BoxGetInfo(7);    Inc(iwBox); exit; end;
          Ord(acGetInfo8):      begin BoxGetInfo(8);    Inc(iwBox); exit; end;
          Ord(acGetInfo9):      begin BoxGetInfo(9);    Inc(iwBox); exit; end;
          Ord(acGetInfo10):     begin BoxGetInfo(10);   Inc(iwBox); exit; end;
          else ErrBox('Ошибка при задании списка запросов !');
        end;
      end;
      Inc(iwBox);
    end;

    AddInfo('');
    AddInfo('');
    AddInfo('Начало опроса: '+Times2Str(ToTimes(BoxStart)));
    AddInfo('Конец опроса:  '+Times2Str(ToTimes(Now)));
    AddInfo('Длительность опроса:'+DeltaTimes2Str(ToTimes(BoxStart)));

    b := False;
    if (TapiDevice.TapiState = tsConnected) and (chbCancelCall.Checked) then begin
      b := True;
      btbCancelCallClick(nil);
    end;

    if b then begin
      AddInfo(' ');
      AddInfo('Cоединение: ' + IntToStr(timNow.Interval * cwConnect div 1000) + ' секунд');
    end;

    AddInfo(' ');
    AddInfo('Опрос успешно завершен');

    ShowProgress(-1, 1);
  end;
end;

procedure BoxRead;
begin
  with frmMain do begin
    with clbMain do begin
      Checked[Ord(acGetOpen)] := True;

      if Checked[Ord(acGetCalc1)] 
      then begin
        Checked[Ord(acGetEngAbsTar)] := True;
        Checked[Ord(acGetEngDayCurTar)] := True;
      end;

      if Checked[Ord(acGetCalc2)] 
      then begin
        Checked[Ord(acGetEngAbs)] := True;
        Checked[Ord(acGetEngDayCur)] := True;
        Checked[Ord(acGetEngMon)] := True;
      end;    
      
      if Checked[Ord(acGetEngAbs)] or
         Checked[Ord(acGetEngAbsTar)] or
         Checked[Ord(acGetEngMon)] or
         Checked[Ord(acGetEngDayCur)] or
         Checked[Ord(acGetEngDayCurTar)] or
         Checked[Ord(acGetEngDayPrev)] or
         Checked[Ord(acGetGraphTop)]          
      then begin
        Checked[Ord(acGetTime)] := True;
        Checked[Ord(acGetTrans)] := True;
        Checked[Ord(acGetPulse)] := True;
      end;    

      if Checked[Ord(acGetPulse)]
      then begin
        Checked[Ord(acGetTrans)] := True;
      end;    

      if Checked[Ord(acGetGraphTop)]
      then begin
        Checked[Ord(acGetTime)] := True;
      end;    

      if Checked[Ord(acGetSummer)] or
         Checked[Ord(acGetWinter)]
      then begin
        Checked[Ord(acGetTime)] := True;
        Checked[Ord(acGetFlags)] := True;
      end;
      
    end;

    BoxStart := Now;

    AddInfo('');
    AddInfo('');
    AddInfo('Cчетчик: номер '+IntToStr(GetDeviceAddr));
    
    iwBox := 0;
    BoxRun;
  end;
end;

procedure BoxShow(ac: actions);
begin
  case ac of
    acGetOpen:          ShowGetOpen;
    acGetTime:          ShowGetTime;
    acGetId:            ShowGetId;
    acGetVersion:       ShowGetVersion;
    acGetFlags:         ShowGetFlags;
    acGetSummer:        ShowGetSummer;
    acGetWinter:        ShowGetWinter;

    acGetTrans:         ShowGetTrans;
    acGetPulse:         ShowGetPulse;
    acGetEngAbs:        ShowGetEngAbs;
    acGetEngAbsTar:     ShowGetEngAbsTar;
    acGetEngMon:        ShowGetEngMon;
    acGetEngDayCur:     ShowGetEngDayCur;    
    acGetEngDayCurTar:  ShowGetEngDayCurTar;
    acGetEngDayPrev:    ShowGetEngDayPrev;
    acGetCalc1:         ShowGetCalc1;
    acGetCalc2:         ShowGetCalc2;
    
    acGetGraphTop:      ShowGetGraphTop;
    acGetGraphHeader:   ShowGetGraphHeader;
    acGetGraphData:     ShowGetGraphData;
    
    acGetInfo1:       ShowGetInfo(1);
    acGetInfo2:       ShowGetInfo(2);
    acGetInfo3:       ShowGetInfo(3);
    acGetInfo4:       ShowGetInfo(4);
    acGetInfo5:       ShowGetInfo(5);
    acGetInfo6:       ShowGetInfo(6);
    acGetInfo7:       ShowGetInfo(7);
    acGetInfo8:       ShowGetInfo(8);
    acGetInfo9:       ShowGetInfo(9);
    acGetInfo10:      ShowGetInfo(10);

    acGetOpen2:       ShowGetOpen2;    
    acGetTime2:       ShowGetTime2;
    acGetCorrect2:    ShowGetCorrect2;
    acGetSetup2:      ShowGetSetup2;
    
    acGetFlags2:      ShowGetFlags2;
    acGetSummer2:     ShowGetSummer2;
    acGetWinter2:     ShowGetWinter2;

    acGetDisableSeasonTime: ShowGetDisableSeasonTime;
    acGetEnableSeasonTime:  ShowGetEnableSeasonTime;
  end;
end;

function BoxVariousSize(cwIn: word; ac: actions): boolean;
begin
  Result := false;
  case ac of
    acGetEngMon: if (cwIn = 4) and (mpbIn[1] and $0F = 1) then begin
                   ShowGetEngMon_Empty; Result := true;
                 end;
  end;
end;

end.


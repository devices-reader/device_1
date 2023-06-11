unit sinput;

interface

procedure PostInput;
procedure SaveOut(wSize: word);
procedure LoadOut(wSize: word);

var
  cbMaxRepeat,
  cbCurRepeat:  byte;

implementation

uses SysUtils, Graphics, support, soutput, main, terminal, crc, box;

procedure SaveOut(wSize: word);
var
  i:  word;
begin
  cbCurRepeat := 0;
  if wSize > 0 then
    for i := 0 to wSize-1 do mpbOutSave[i] := mpbOut[i];  
end;

procedure LoadOut(wSize: word);
var
  i:  word;
begin
  if wSize > 0 then
    for i := 0 to wSize-1 do mpbOut[i] := mpbOutSave[i];  
end;

procedure RepeatAction(s: string);
begin
  if (cbCurRepeat < 20) then
    with frmMain do begin
      Inc(cbCurRepeat);
      Inc(cbMaxRepeat); ShowRepeat;
      AddTerminal(s+', повтор: ' + IntToStr(cbCurRepeat),clGray);
      AddInfo(s+', повтор: ' + IntToStr(cbCurRepeat));
      LoadOut(quCurr.cwOut);  
      Query(quCurr, False);
    end;
end;

procedure BadSizeBox(wSize1,wSize2: word);
begin
  RepeatAction('Неправильная длина ответа: ' + IntToStr(wSize1) + ' вместо ' + IntToStr(wSize2) + ' байт'); 
end;

procedure OtherActions(cwIn: word);
begin
  if cwIn <> quCurr.cwIn then begin
    if not BoxVariousSize(cwIn,quCurr.Action) then
      BadSizeBox(cwIn,quCurr.cwIn);
  end else begin
    cbCurRepeat := 0;
    BoxShow(quCurr.Action);
  end;
end;

function Checksum(mpbT: array of byte; wSize: word): boolean;
var
  i:  word;
begin
  if wSize < 2 then 
    Result := False
  else begin
    i := CRC16(mpbIn,wSize);
    Result := (i = 0);
  end;
end;

procedure PostInput;
var
  i,wSize:  word;
begin
  with frmMain,ComPort do begin

    wSize := InBuffUsed;  
    GetBlock(mpbIn, wSize);
    ShowInData(wSize);

    if frmMain.chbTunnel.Checked then begin
      if (wSize = 0) then begin end
      else
      if (wSize <= 7) then
        RepeatAction('Ошибка туннеля - малая длина ответа')
      else
      if (wSize = 0) or (CRC16(mpbIn,wSize) <> 0) then 
        RepeatAction('Ошибка туннеля - нет ответа')
      else begin
        for i := 0 to wSize-7 do mpbIn[i] := mpbIn[i+5];
        wSize := wSize-7;
        quCurr.cwIn := quCurr.cwIn-7;
        ShowInData(wSize);
      end;
    end;
    
    ShowTimeout;

    if quCurr.Action = acNone then begin
    end
    
    else if quCurr.Action = acTransit then begin
      ShowTransit;
    end

    else if (wSize = 0) and (cbCurRepeat < 20) then begin
      RepeatAction('Нет ответа от устройства');
    end
    else if not Checksum(mpbIn,wSize) and (cbCurRepeat < 20) then begin
      RepeatAction('Ошибка контрольной суммы');
    end

    else begin
      if wSize = 0 then 
        ErrBox('Нет ответа от устройства !')
      else if not Checksum(mpbIn,wSize) 
        then ErrBox('Ошибка контрольной суммы !') 
      else
        OtherActions(wSize);
    end;
  end;
end;

end.


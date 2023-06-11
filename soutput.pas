unit soutput;

interface

uses box;

var
  quCurr:    querys;
  
const  
  quTransit:    querys = (Action: acTransit; cwOut: 5+2; cwIn: 5+2+2; bNumber: 0);

procedure Stop;

procedure InitPush(i: word);
procedure InitPushZero;
procedure InitPushCRC;
procedure PushByte(bT: byte);
procedure InitPopZero;
procedure InitPopCRC;
procedure InitPop(i: word);
function PopByte: byte;
function PopInt: word;
function PopLong: longword;
procedure Query(quT: querys; b: boolean);
procedure QueryTransit;
procedure ShowTransit;

implementation

uses SysUtils, Graphics, main, kernel, terminal, crc, support, sinput;

const
  stHEADER:     string = 'Калюмны ';

procedure Stop;
begin
  with frmMain do begin
    timTimeout.Enabled := False;

    quCurr.Action := acNone;
    quCurr.cwIn := 0;
  end;
end;

procedure InitPush(i: word);
begin
  iwOut := i;
end;

procedure InitPushZero;
begin
  iwOut := 0;
end;

procedure InitPushCRC;
begin
  iwOut := 5;
end;

procedure PushByte(bT: byte);
begin
  mpbOut[iwOut] := bT;
  Inc(iwOut);
end;

procedure InitPopZero;
begin
  iwIn := 0;
end;

procedure InitPopCRC;
begin
  iwIn := 5;
end;

procedure InitPop(i: word);
begin
  iwIn := i;
end;

function PopByte: byte;
begin
  Result := mpbIn[iwIn];
  Inc(iwIn);
end;

function PopInt: word;
begin
  Result := PopByte*$100 + PopByte;
end;

function PopLong: longword;
begin
  Result := PopByte*$1000000 + PopByte*$10000 + PopByte*$100 + PopByte;
end;

procedure Query(quT: querys; b: boolean);
var
  i,j:  word;
begin
  try
    with frmMain,ComPort do begin
      quCurr := quT;
      
      i := CRC16(mpbOut,quCurr.cwOut-2);

      InitPush(quCurr.cwOut-2);
      PushByte(i div $100);
      PushByte(i mod $100);

      if b then SaveOut(quCurr.cwOut);  
      
      with timTimeout do begin
        Enabled  := False;
        Interval := updTimeout.Position;
        Enabled  := True;
      end;

      FlushInBuffer;
      FlushOutBuffer;
      AddTerminal('',clSilver);
      
      if not chbTunnel.Checked then begin
        PutBlock(mpbOut,quCurr.cwOut);
        ShowOutData(quCurr.cwOut);
      end
      else begin
        if chbPacket.Checked then begin
          PutString(stHEADER);
          Delay(100);
        end;
        
        ShowOutData(quCurr.cwOut);
        for j := 1 to quT.cwOut do
          mpbOut[8+quT.cwOut-j] := mpbOut[quT.cwOut-j];

        mpbOut[0] := updServerAddr.Position;  
        mpbOut[1] := 0;
        mpbOut[2] := (quT.cwOut+10) mod $100;
        mpbOut[3] := (quT.cwOut+10) div $100;
        mpbOut[4] := $AC;

        mpbOut[5] := cmbTunnel.ItemIndex;
        mpbOut[6] := quT.cwIn mod $100;
        mpbOut[7] := quT.cwIn div $100;

        i := CRC16(mpbOut, quT.cwOut+8);
        mpbOut[quT.cwOut+8] := i div $100;
        mpbOut[quT.cwOut+9] := i mod $100;

        PutBlock(mpbOut,quT.cwOut+10);
        ShowOutData(quT.cwOut+10);

        quCurr.cwIn := quCurr.cwIn+7;
      end;  
    end;
  except
    ErrBox('Ошибка при передаче !');
  end;
end;

procedure QueryTransit;
var
  i:  word;
begin
  try
    with frmMain,ComPort do begin
      if chbPacket.Checked then begin
        PutString(stHEADER);
        Delay(100);
      end;

      quCurr := quTransit;
      
      InitPushZero;
      PushByte(updServerAddr.Position);
      PushByte(0);
      PushByte(quTransit.cwOut);
      PushByte(0);
      PushByte(245);
      i := CRC16(mpbOut, 5);
      PushByte(i div $100);
      PushByte(i mod $100);

      SaveOut(quTransit.cwOut);  
      
      with timTimeout do begin
        Enabled  := False;
        Interval := updTimeout.Position;
        Enabled  := True;
      end;

      FlushInBuffer;
      FlushOutBuffer;

      PutBlock(mpbOut,quTransit.cwOut);
      ShowOutData(quTransit.cwOut);  
    end;
  except
    ErrBox('Ошибка при передаче !');
  end;  
end;

procedure ShowTransit;
var
  i:    byte;
begin
  Stop;
  InitPop(5);

  i := PopByte;
  if i = 0 then 
    AddInfo('Канал связи счетчика: успешно открыт')
  else
    AddInfo('Канал связи счетчика: ошибка '+IntToStr(i));
end;
    
end.


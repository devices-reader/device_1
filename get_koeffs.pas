unit get_koeffs;

interface

procedure BoxGetTrans;
procedure ShowGetTrans;

procedure BoxGetPulse;
procedure ShowGetPulse;

var
  kE:     extended;

implementation

uses SysUtils, support, soutput, timez, realz, box;

var
  kI,kU:  longword;
  kP:     word;

const
  quGetTrans:   querys = (Action: acGetTrans; cwOut: 2+1+2; cwIn: 1+10+2; bNumber: 0);
  quGetPulse:   querys = (Action: acGetPulse; cwOut: 2+1+2; cwIn:  1+3+2; bNumber: 0);

procedure QueryGetTrans;
begin
  InitPushZero;
  PushByte(GetDeviceAddr);
  PushByte(8);
  PushByte(2);
  Query(quGetTrans, True);
end;

procedure QueryGetPulse;
begin
  InitPushZero;
  PushByte(GetDeviceAddr);
  PushByte(8);
  PushByte($12);
  Query(quGetPulse, True);
end;

procedure BoxGetTrans;
begin
  AddInfo('');
  AddInfo('');
  AddInfo('К. трансформации');
  QueryGetTrans;
end;

procedure BoxGetPulse;
begin
  AddInfo('');
  AddInfo('');
  AddInfo('К. преобразования');
  QueryGetPulse;
end;

procedure ShowGetTrans;
begin
  Stop;
  InitPop(1);

  kU := PopByte*$100 + PopByte;
  kI := PopByte*$100 + PopByte;

  AddInfo('Ki*Ku = '+IntToStr(kI)+'*'+IntToStr(kU)+' = '+IntToStr(kI*kU));

  BoxRun;
end;

procedure ShowGetPulse;
begin
  Stop;
  InitPop(2);

  case (PopByte and $0F) of 
    0:  kP := 5000;
    1:  kP := 25000;
    2:  kP := 1250;
    3:  kP := 6250;
    else begin kP := 1; AddInfo('Ошибка при чтении К. преобразования !'); end;
  end;
  
  kE := kI*kU/(kP*2);  
  AddInfo('Kp = '+IntToStr(kP)+'*2 = '+IntToStr(kP*2));
  AddInfo('*для использования в сумматоре СЭМ+2 К. преобразования необходимо умножать на 2');

  AddInfo('');  
  AddInfo('К. пропорциональности');  
  AddInfo('Ke = Ki*Ku/Kp*2 = '+Reals2Str(kE));
  
  BoxRun;
end;

end.

unit get_open;

interface

procedure BoxGetOpen;
procedure ShowGetOpen;

implementation

uses SysUtils, support, soutput, timez, box;

const
  quGetOpen:  querys = (Action: acGetOpen; cwOut: 2+6+2; cwIn: 1+1+2; bNumber: 0);

procedure QueryGetOpen;
var
  s:  string;
begin
  try
    s := GetDevicePass;
    if Length(s) <> 6 then raise Exception.Create('Неправильная длина пароля !');    
    if not 
      ((s[1] in ['0'..'9']) and
       (s[2] in ['0'..'9']) and    
       (s[3] in ['0'..'9']) and    
       (s[4] in ['0'..'9']) and    
       (s[5] in ['0'..'9']) and    
       (s[6] in ['0'..'9'])) then raise Exception.Create('Неправильные символы пароля !');    
       
    InitPushZero;
    PushByte(GetDeviceAddr);
    PushByte(1);
  
    PushByte(Ord(s[1]));
    PushByte(Ord(s[2]));
    PushByte(Ord(s[3]));
    PushByte(Ord(s[4]));
    PushByte(Ord(s[5]));
    PushByte(Ord(s[6]));
    Query(quGetOpen, True);
  except
    ErrBox('Пароль задан неправильно !');
  end;    
end;

procedure BoxGetOpen;
begin
  AddInfo('');
  AddInfo('Открытие канала');
  QueryGetOpen;
end;

procedure ShowGetOpen;
var
  i:    byte;
begin
  Stop;
  InitPop(1);

  i := PopByte;
  if i = 0 then begin
    AddInfo('Канал открыт успешно');
    BoxRun;
  end  
  else
    WrnBox('Ошибка открытия канала - код '+IntToHex(i,2));  
end;

end.

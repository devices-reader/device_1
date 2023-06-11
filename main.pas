unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  basic, ComCtrls, ToolWin, StdCtrls, IniFiles, ExtCtrls, Math,
  Buttons, Mask, Grids, Menus, FileCtrl, OoMisc, AdPort, ImgList, CheckLst,
  AdTapi, AdTStat;

type
  TfrmMain = class(TfrmBasic)
    ComPort: TApdComPort;
    timTimeout: TTimer;
    timNow: TTimer;
    sd_RichToFile: TSaveDialog;
    stbMain: TStatusBar;
    panClient: TPanel;
    TapiDevice: TApdTapiDevice;
    TapiLog: TApdTapiLog;
    pgcMain: TPageControl;
    tbsFirst: TTabSheet;
    lblComNumber: TLabel;
    lblBaud: TLabel;
    lblParity: TLabel;
    lblConnect: TLabel;
    lblTimeout: TLabel;
    cmbComNumber: TComboBox;
    cmbBaud: TComboBox;
    edtTimeout: TEdit;
    updTimeout: TUpDown;
    cmbParity: TComboBox;
    tbsLast: TTabSheet;
    panTop3: TPanel;
    panRight3: TPanel;
    btbClearTerminal: TBitBtn;
    btbSaveTerminal: TBitBtn;
    chbTerminal: TCheckBox;
    lblDevice: TLabel;
    panTAPI: TPanel;
    memDial: TMemo;
    btbSelectDevice: TBitBtn;
    btbShowConfigDialog: TBitBtn;
    btbDial: TBitBtn;
    btbCancelCall: TBitBtn;
    edtDial: TEdit;
    rgrTAPI: TRadioGroup;
    lblSelectedDevice: TLabel;
    lblServerAddr: TLabel;
    edtServerAddr: TEdit;
    updServerAddr: TUpDown;
    chbPacket: TCheckBox;
    tbsParams: TTabSheet;
    panBottom2: TPanel;
    panRigth2: TPanel;
    btbCrealInfo: TBitBtn;
    btbSaveInfo: TBitBtn;
    btbStopInfo: TBitBtn;
    btbStopTerminal: TBitBtn;
    prbMain: TProgressBar;
    panClient2: TPanel;
    panTop2: TPanel;
    memInfo: TMemo;
    ppmMain: TPopupMenu;
    mitVersion: TMenuItem;
    ppmList: TPopupMenu;
    itmSetAll: TMenuItem;
    itmClearAll: TMenuItem;
    lblDeviceAddr: TLabel;
    edtDeviceAddr: TEdit;
    updDeviceAddr: TUpDown;
    lblDevicePass: TLabel;
    chbTunnel: TCheckBox;
    cmbTunnel: TComboBox;
    lblColWidth: TLabel;
    lblDigits: TLabel;
    edtColWidth: TEdit;
    updColWidth: TUpDown;
    edtDigits: TEdit;
    updDigits: TUpDown;
    lblSetting: TLabel;
    lblMonthFrom: TLabel;
    lblMonthsTo: TLabel;
    edtMonthsMin: TEdit;
    edtMonthsMax: TEdit;
    lblDaysFrom: TLabel;
    lblDaysTo: TLabel;
    edtDaysMin: TEdit;
    edtDaysMax: TEdit;
    lblMonthName: TLabel;
    lblDaysName: TLabel;
    lblDaysFrom2: TLabel;
    lblDaysTo2: TLabel;
    edtDaysMin2: TEdit;
    edtDaysMax2: TEdit;
    lblDaysName2: TLabel;
    btbRun: TBitBtn;
    btbTransit: TBitBtn;
    medDevicePass: TMaskEdit;
    pgcFunctions: TPageControl;
    tbsFunction1: TTabSheet;
    tbsFunction2: TTabSheet;
    splMain: TSplitter;
    clbMain: TCheckListBox;
    btbGetTime2: TBitBtn;
    btbSetupTime2: TBitBtn;
    btbCorrectTime2: TBitBtn;
    chbCancelCall: TCheckBox;
    lblProtocol: TLabel;
    redTerminal: TMemo;
    lblGraphTop: TLabel;
    edtGraphOffset: TEdit;
    updGraphOffset: TUpDown;
    lblGraphOffset: TLabel;
    edtGraphCount: TEdit;
    updGraphCount: TUpDown;
    lblGraphCount: TLabel;
    btbDisableSeasonTime: TBitBtn;
    btbEnableSeasonTime: TBitBtn;
    procedure ShowConnect;
    procedure SetBaud(dwBaud: longword);
    procedure SetComNumber(wComNumber: word);
    procedure cmbComNumberChange(Sender: TObject);
    procedure cmbBaudChange(Sender: TObject);
    procedure SetParity(ibParity: byte);
    function GetParity: byte;
    function GetParityStr: string;
    procedure SetTimeout(wTimeout: word);
    function GetTimeout: word;
    procedure FormShow(Sender: TObject);
    procedure ComPortTriggerAvail(CP: TObject; Count: Word);
    procedure timTimeoutTimer(Sender: TObject);
    procedure timNowTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure cmbParityChange(Sender: TObject);
    procedure FocusTerminal;
    procedure ClearTerminal;
    //procedure InsTerminal(stT: string; clOut: TColor);
    procedure AddTerminal(stT: string; clOut: TColor);
    procedure ComTerminal(stT: string);
    procedure AddInfo(stT: string);
    procedure AddInfoAll(stT: TStrings);
    procedure ClearInfo;
    procedure ClearDial;
    procedure AddDial(stT: string);
    //procedure InsByte(bT: byte; clT: TColor);    
    //procedure InsChar(bT: byte; clT: TColor);    
    procedure ShowSelectedDevice;
    procedure ShowTAPI(Flag: boolean);
    procedure TAPIoff;
    procedure TAPIon;
    procedure TapiDeviceTapiStatus(CP: TObject; First, Last: Boolean;
      Device, Message, Param1, Param2, Param3: Integer);
    procedure TapiDeviceTapiLog(CP: TObject; Log: TTapiLogCode);
    procedure TapiDeviceTapiPortOpen(Sender: TObject);
    procedure TapiDeviceTapiPortClose(Sender: TObject);
    procedure TapiDeviceTapiConnect(Sender: TObject);
    procedure TapiDeviceTapiFail(Sender: TObject);
    procedure btbClearTerminalClick(Sender: TObject);
    procedure rgrTAPIClick(Sender: TObject);
    procedure btbSelectDeviceClick(Sender: TObject);
    procedure btbShowConfigDialogClick(Sender: TObject);
    procedure btbDialClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure redTerminalKeyPress(Sender: TObject; var Key: Char);
    procedure btbCancelCallClick(Sender: TObject);
    procedure btbStopInfoClick(Sender: TObject);
    procedure btbSaveTerminalClick(Sender: TObject);
    procedure SaveRich(Rich: TRichEdit; stName: string);
    procedure SaveMemo(Memo: TMemo; stName: string);
    procedure SaveLog(Memo: TMemo; stName: string);
    procedure ShowRepeat;
    procedure btbCrealInfoClick(Sender: TObject);
    procedure btbSaveInfoClick(Sender: TObject);
    procedure itmClearAllClick(Sender: TObject);
    procedure itmSetAllClick(Sender: TObject);
    procedure btbRunClick(Sender: TObject);
    procedure btbTransitClick(Sender: TObject);
    procedure btbGetTime2Click(Sender: TObject);
    procedure btbCorrectTime2Click(Sender: TObject);
    procedure btbSetupTime2Click(Sender: TObject);
    procedure pgcFunctionsChange(Sender: TObject);
    procedure clbMainMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure btbDisableSeasonTimeClick(Sender: TObject);
    procedure btbEnableSeasonTimeClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain:      TfrmMain;

implementation

{$R *.DFM}

uses support, kernel, soutput, sinput, ports, box, get_open2, setup2;

var
  FIni:         TIniFile;
  stIni:        string;

procedure TfrmMain.ShowConnect;
begin
  with ComPort do
    stbMain.Panels[panCOMPORT].Text :=
      ' COM' + IntToStr(ComNumber) + ': ' + IntToStr(Baud) + ', ' + GetParityStr;
end;

procedure TfrmMain.SetComNumber(wComNumber: word);
begin
  try
    with ComPort do ComNumber := wComNumber;
    ShowConnect;
  except
    ErrBox('Ошибка при изменении номера порта: COM' + IntToStr(wComNumber));
  end;
end;

procedure TfrmMain.SetBaud(dwBaud: longword);
begin
  try
    with ComPort do begin
//      AutoOpen := False;

      Baud := dwBaud;
//      Open := True;
    end;

    ShowConnect;
  except
    ErrBox('Ошибка при изменении скорости обмена: ' + IntToStr(dwBaud) + ' бод');
  end;
end;

procedure TfrmMain.SetParity(ibParity: byte);
begin
  try
    with ComPort do case ibParity of
      1:   Parity := pEven;
      2:   Parity := pOdd;
      3:   Parity := pMark;
      4:   Parity := pSpace;
      else Parity := pNone;
    end;

    ShowConnect;
  except
    ErrBox('Ошибка при изменениии контроля чётности: ' + GetParityStr);
  end;
end;

function TfrmMain.GetParity: byte;
begin
  with ComPort do case Parity of
    pEven:  Result := 1;
    pOdd:   Result := 2;
    pMark:  Result := 3;
    pSpace: Result := 4;
    else    Result := 0;
  end;
end;

function TfrmMain.GetParityStr: string;
begin
  with ComPort do case Parity of
    pEven:  Result := 'even';
    pOdd:   Result := 'odd';
    pMark:  Result := 'mark';
    pSpace: Result := 'space';
    else    Result := 'none';
  end;
end;

procedure TfrmMain.SetTimeout(wTimeout: word);
begin
  updTimeout.Position := wTimeout;
end;

function TfrmMain.GetTimeout: word;
begin
  Result := updTimeout.Position;
end;

procedure TfrmMain.cmbComNumberChange(Sender: TObject);
begin
  inherited;
  try
    with cmbComNumber do SetComNumber(ItemIndex+1);
  except
    ErrBox('Фатальная ошибка при изменении номера порта !');
  end;
end;

procedure TfrmMain.cmbBaudChange(Sender: TObject);
begin
  inherited;
  try
    with cmbBaud do SetBaud( GetBaudSize(ItemIndex) );
  except
    ErrBox('Фатальная ошибка при изменении скорости обмена !');
  end;
end;

procedure TfrmMain.cmbParityChange(Sender: TObject);
begin
  inherited;
  try
    with cmbParity do SetParity(ItemIndex);
  except
    ErrBox('Фатальная ошибка при изменении контроля чётности !');
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  i:  word;
begin
  inherited;
  LoadCmbBauds(cmbBaud.Items);
  LoadCmbParitys(cmbParity.Items);

  try
    stIni := ChangeFileExt(ParamStr(0),'.ini');
    FileSetAttr(stIni, FileGetAttr(stIni) and not faReadOnly);
  except
  end;

  try
    FIni := TIniFile.Create(ChangeFileExt(ParamStr(0),'.ini'));

    with FIni do begin
      SetComNumber( ReadInteger(stSETTING, stCOMNUMBER, 1)    );
      SetBaud(      ReadInteger(stSETTING, stBAUD,      9600) );
      SetParity(    ReadInteger(stSETTING, stPARITY,    0)    );

      updServerAddr.Position := FIni.ReadInteger(stSETTING, stSER_ADDR, 0);
      SetTimeout(ReadInteger(stSETTING, stTIMEOUT, 500));
      edtDial.Text := ReadString(stSETTING, stDIAL, '');

      TapiDevice.SelectedDevice := ReadString(stSETTING, stDEVICE, '');
      ShowSelectedDevice;

      updDeviceAddr.Position := FIni.ReadInteger(stPARAMS, stDEV_ADDR, 0);
      medDevicePass.Text := FIni.ReadString(stPARAMS, stDEV_PASS, '000000');
      
      edtDaysMin.Text   := ReadString(stPARAMS, stDAYS_MIN1, IntToStr(0));
      edtDaysMax.Text   := ReadString(stPARAMS, stDAYS_MAX1, IntToStr(DAYS-1));
      edtDaysMin2.Text  := ReadString(stPARAMS, stDAYS_MIN2, IntToStr(0));
      edtDaysMax2.Text  := ReadString(stPARAMS, stDAYS_MAX2, IntToStr(1));
      edtMonthsMin.Text := ReadString(stPARAMS, stMONTHS_MIN, IntToStr(0));
      edtMonthsMax.Text := ReadString(stPARAMS, stMONTHS_MAX, IntToStr(MONTHS-1));
      
      updDigits.Position     := FIni.ReadInteger(stPARAMS, stDIGITS, 4);
      updColWidth.Position   := FIni.ReadInteger(stPARAMS, stCOLWIDTH, 12);
      chbTunnel.Checked      := FIni.ReadBool(stPARAMS, stIS_TUNNEL, True);
      cmbTunnel.ItemIndex    := FIni.ReadInteger(stPARAMS, stTUNNEL, 2);

      BoxCreate;

      for i := 0 to clbMain.Count-1 do
        clbMain.Checked[i] := ReadBool(stOPTIONS, stINQUIRY+IntTOStr(i), False);
    end;
  except
    ErrBox('Ошибка при чтении настроек программы !');
  end;

  with ComPort do begin
    if (ComNumber < 1) or (ComNumber > 8) then begin
      ErrBox('Ошибочный номер порта: COM' + IntToStr(ComNumber));
      ComNumber := 0;
    end;
    cmbComNumber.ItemIndex := ComNumber-1;

    if cmbBaud.Items.IndexOf( IntToStr(Baud) ) = -1 then begin
      ErrBox('Ошибочная скорость обмена: ' + IntToStr(Baud)  + ' бод');
      Baud := 9600;
    end;
    cmbBaud.ItemIndex := cmbBaud.Items.IndexOf( IntToStr(Baud) );
  end;

  cmbParity.ItemIndex := GetParity;

  TAPIoff;
  Stop;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  inherited;
  pgcMain.ActivePage := tbsFirst;
  pgcFunctions.ActivePage := tbsFunction1;
  Application.Title := Caption;
  Resize;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
var
  i:  word;
begin
  inherited;
  Stop;

  try
    with FIni do begin
      WriteInteger(stSETTING, stCOMNUMBER,  ComPort.ComNumber);
      WriteInteger(stSETTING, stBAUD,       ComPort.Baud);
      WriteInteger(stSETTING, stPARITY,     GetParity);

      WriteInteger(stSETTING, stSER_ADDR,   updServerAddr.Position);
      WriteInteger(stSETTING, stTIMEOUT,    GetTimeout);

      WriteString(stSETTING, stDIAL,        edtDial.Text);
      WriteString(stSETTING, stDEVICE,      TapiDevice.SelectedDevice);

      WriteInteger(stPARAMS, stDEV_ADDR,    updDeviceAddr.Position);
      WriteString(stPARAMS,  stDEV_PASS,    medDevicePass.Text);

      WriteString(stPARAMS,  stDAYS_MIN1,   edtDaysMin.Text);
      WriteString(stPARAMS,  stDAYS_MAX1,   edtDaysMax.Text);
      WriteString(stPARAMS,  stDAYS_MIN2,   edtDaysMin2.Text);
      WriteString(stPARAMS,  stDAYS_MAX2,   edtDaysMax2.Text);
      WriteString(stPARAMS,  stMONTHS_MIN,  edtMonthsMin.Text);
      WriteString(stPARAMS,  stMONTHS_MAX,  edtMonthsMax.Text);
      
      WriteInteger(stPARAMS, stDIGITS,      updDigits.Position);
      WriteInteger(stPARAMS, stCOLWIDTH,    updColWidth.Position);
      WriteBool(stPARAMS,    stIS_TUNNEL,   chbTunnel.Checked);
      WriteInteger(stPARAMS, stTUNNEL,      cmbTunnel.ItemIndex);

      for i := 0 to clbMain.Count-1 do
        WriteBool(stOPTIONS, stINQUIRY+IntTOStr(i), clbMain.Checked[i]);
    end;
  except
    ErrBox('Ошибка при записи настроек программы !');
  end;
end;

procedure TfrmMain.ComPortTriggerAvail(CP: TObject; Count: Word);
begin
  inherited;
  timTimeout.Enabled := False;    // перезапуск таймера
  timTimeout.Enabled := True;

  with ComPort do if InBuffUsed >= quCurr.cwIn then begin
    ComTerminal('// приём по количеству байт: ' + IntToStr(InBuffUsed) + ' из ' + IntToStr(quCurr.cwIn));
    PostInput;
  end;
end;

procedure TfrmMain.timTimeoutTimer(Sender: TObject);
begin
  inherited;
  timTimeout.Enabled := False;

  ComTerminal('// приём по таймауту: ' + IntToStr(GetTimeout) + ' мс');
  PostInput;
end;

procedure TfrmMain.timNowTimer(Sender: TObject);
begin
  inherited;
  stbMain.Panels[panNOW].Text := ' ' + FormatDateTime('hh:mm:ss dd.mm.yyyy',Now);

  if TapiDevice.TapiState = tsConnected then begin
    Inc(cwConnect);
    stbMain.Panels[panCONNECT].Text := ' соединение: ' + IntToStr(timNow.Interval * cwConnect div 1000) + ' сек';
  end;
end;

procedure TfrmMain.FormResize(Sender: TObject);
var
  i,j:  word;
begin
  inherited;
  with prbMain do begin
    Top := stbMain.Top;

    j := 0;
    for i := 0 to panPROGRESS-1 do j := j + stbMain.Panels[i].Width;

    Left := j;
    Width := stbMain.Width - j;
  end;
end;

procedure TfrmMain.FocusTerminal;
begin
  if chbTerminal.Checked then begin
    try
      with redTerminal do if CanFocus and Visible then SetFocus;
    except
    end;
  end;
end;

procedure TfrmMain.ClearTerminal;
begin
  redTerminal.Clear;
end;
{
procedure TfrmMain.InsTerminal(stT: string; clOut: TColor);
begin
  if chbTerminal.Checked then begin
    try
      FocusTerminal;
      with redTerminal do begin
        SelAttributes.Color := clOut;
        SelText := stT;
      end;
    except
    end;
  end;
end;
}
procedure TfrmMain.AddTerminal(stT: string; clOut: TColor);
begin
  if chbTerminal.Checked then begin
    try
      FocusTerminal;
      with redTerminal do begin
        //SelAttributes.Color := clOut;
        Lines.Append(stT);
      end;
    except
    end;
  end;
end;

procedure TfrmMain.ComTerminal(stT: string);
//var
//  Charset: TFontCharset;
begin
  if chbTerminal.Checked then begin
    try
      FocusTerminal;
      with redTerminal do begin
        //SelAttributes.Color := clGray;

        //Charset := SelAttributes.CharSet;
        //SelAttributes.CharSet := RUSSIAN_CHARSET;
        Lines.Append(stT);
        //SelAttributes.CharSet := Charset;
      end;
    except
    end;
  end;
end;

procedure TfrmMain.AddInfo(stT: string);
begin
  try
    memInfo.Lines.Append(stT);
    AddTerminal(stT, clGray);
  except
  end
end;

procedure TfrmMain.AddInfoAll(stT: TStrings);
begin
  try
    memInfo.Lines.AddStrings(stT);
    memInfo.Lines.Append(' ');
    redTerminal.Lines.AddStrings(stT);
    redTerminal.Lines.Append(' ');
    stT.Free;
  except
  end
end;

procedure TfrmMain.ClearInfo;
begin
  memInfo.Clear;
end;

procedure TfrmMain.ClearDial;
begin
  memDial.Clear;
end;

procedure TfrmMain.AddDial(stT: string);
begin
  try
    memDial.Lines.Append(stT);
  except
  end
end;
{
procedure TfrmMain.InsByte(bT: byte; clT: TColor);
begin
  InsTerminal(IntToHex(bT,2) + ' ', clT);
end;

procedure TfrmMain.InsChar(bT: byte; clT: TColor);
begin
  if bT > $20 then
    InsTerminal(Chr(bT), clT)
  else  
    InsTerminal('_', clSilver);
end;
}
procedure TfrmMain.ShowSelectedDevice;
begin
  lblSelectedDevice.Caption := TapiDevice.SelectedDevice;
end;

procedure TfrmMain.ShowTAPI(Flag: boolean);
begin
  btbSelectDevice.Enabled       := Flag;
  btbShowConfigDialog.Enabled   := Flag;
  lblSelectedDevice.Enabled     := Flag;
  btbDial.Enabled               := Flag;
  edtDial.Enabled               := Flag;
  btbCancelCall.Enabled         := Flag;
  memDial.Enabled               := Flag;
  chbCancelCall.Enabled         := Flag;

  lblConnect.Enabled            := not Flag;
  lblComNumber.Enabled          := not Flag;
  cmbComNumber.Enabled          := not Flag;
  lblBaud.Enabled               := not Flag;
  cmbBaud.Enabled               := not Flag;
  lblParity.Enabled             := not Flag;
  cmbParity.Enabled             := not Flag;
end;

procedure TfrmMain.TAPIoff;
begin
  inherited;
  try
    with ComPort do begin
      TapiMode := tmOff;

      AutoOpen := False;
      Open := True;

      updTimeout.Position := 1000;
    end;
    ShowSelectedDevice; ShowTAPI(ComPort.TapiMode <> tmOff);
  except
    ErrBox('Ошибка при открытии порта COM' + IntToStr(ComPort.ComNumber));
  end;
end;

procedure TfrmMain.TAPIon;
begin
  inherited;
  with ComPort do begin
    TapiMode := tmOn;

    AutoOpen := False;
    Open := False;

    updTimeout.Position := 4000;
  end;
  ShowSelectedDevice; ShowTAPI(ComPort.TapiMode <> tmOff);
end;

procedure TfrmMain.TapiDeviceTapiStatus(CP: TObject; First,
  Last: Boolean; Device, Message, Param1, Param2, Param3: Integer);
begin
  inherited;
  AddTerminal('OnTapiStatus event',clGray);

  if First then
    AddTerminal('First event',clGray)
  else if Last then
    AddTerminal('Last event',clGray)
  else with TapiDevice do begin
    AddTerminal('событие: ' + TapiStatusMsg(Message,Param1,Param2) + ' ' + Number,clGray);
    AddDial('событие: ' + TapiStatusMsg(Message,Param1,Param2) + ' ' + Number);
  end;
end;

procedure TfrmMain.TapiDeviceTapiLog(CP: TObject; Log: TTapiLogCode);
begin
  inherited;
//  AddTerminal('OnTapiLog event',clGray);
end;

procedure TfrmMain.TapiDeviceTapiPortOpen(Sender: TObject);
begin
  inherited;
  AddTerminal('OnTapiPortOpen event',clGray);
  AddDial('порт открыт');
end;

procedure TfrmMain.TapiDeviceTapiPortClose(Sender: TObject);
begin
  inherited;
  AddTerminal('OnTapiPortClose event',clGray);
  AddDial('порт закрыт');
end;

procedure TfrmMain.TapiDeviceTapiConnect(Sender: TObject);
begin
  inherited;
  AddTerminal('OnTapiConnect event',clGray);

  with TapiDevice do begin
    AddTerminal('connect at ' + IntToStr(BPSRate),clGray);
    AddDial('соединение на скорости ' + IntToStr(BPSRate) + ' бод');

    AddInfo('Телефон: '+edtDial.Text);
    
    InfBox('Установлено соединение на скорости ' + IntToStr(BPSRate) + ' бод');
  end;
end;

procedure TfrmMain.TapiDeviceTapiFail(Sender: TObject);
begin
  inherited;
  AddTerminal('OnTapiFail event',clGray);

  with TapiDevice do begin
    AddTerminal('fail: ' + FailureCodeMsg(FailureCode),clGray);
    AddDial('ошибка: ' + FailureCodeMsg(FailureCode));

    InfBox('Ошибка: ' + FailureCodeMsg(FailureCode));
  end;
end;

procedure TfrmMain.btbClearTerminalClick(Sender: TObject);
begin
  inherited;
  SaveLog(redTerminal, 'Терминал ' + DateTime2Str + ' ');
  ClearTerminal;
end;

procedure TfrmMain.rgrTAPIClick(Sender: TObject);
begin
  inherited;
  with rgrTAPI do begin
    if ItemIndex = 0 then TAPIoff else TAPIon;
  end;
end;

procedure TfrmMain.btbSelectDeviceClick(Sender: TObject);
begin
  inherited;
  try
    TapiDevice.SelectDevice;
    ClearDial;
  except
    ErrBox('Ошибка при выборе модема');
  end;

  ShowSelectedDevice;
end;

procedure TfrmMain.btbShowConfigDialogClick(Sender: TObject);
begin
  inherited;
  try
    TapiDevice.ShowConfigDialog;
  except
    ErrBox('Ошибка при настройке модема');
  end;
end;

procedure TfrmMain.btbDialClick(Sender: TObject);
begin
  inherited;
  try
    TapiDevice.Dial(edtDial.Text);
  except
    ErrBox('Ошибка при установлении соединения');
  end;
end;

procedure TfrmMain.btbCancelCallClick(Sender: TObject);
begin
  inherited;
  try
    TapiDevice.CancelCall;
    AddDial('отбой !');
  except
    ErrBox('Ошибка при разрыве связи');
  end;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if TapiDevice.TapiState = tsConnected then begin
    WrnBox('Модем находится в состоянии соединения.'+ #10#13 +
           'Перед выходом из программы необходимо разорвать связь !');
    Abort;
  end;

  timNow.Enabled := False;
  Stop;
  
  btbClearTerminalClick(nil);
end;

procedure TfrmMain.redTerminalKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  //InsByte(Ord(Key), clRed);
  AddTerminal(Key, clRed);
  try
    ComPort.PutChar(Key);
  except
    Abort;
  end;
end;

procedure TfrmMain.btbStopInfoClick(Sender: TObject);
begin
  inherited;
  Stop;
end;

procedure TfrmMain.SaveRich(Rich: TRichEdit; stName: string);
begin
  with sd_RichToFile,Rich do begin
    try
      InitialDir := ExtractFileDir(ParamStr(0));

      ForceDirectories(InitialDir);
      FileName := stName + '.rtf';

      if Execute then Rich.Lines.SaveToFile(FileName);
    except
      ErrBox('Ошибка при сохранении отчёта !')
    end;
  end;
end;

procedure TfrmMain.SaveMemo(Memo: TMemo; stName: string);
begin
  with sd_RichToFile,Memo do begin
    try
      InitialDir := ExtractFileDir(ParamStr(0));

      ForceDirectories(InitialDir);
      FileName := stName + '.txt';

      if Execute then Memo.Lines.SaveToFile(FileName);
    except
      ErrBox('Ошибка при сохранении отчёта !')
    end;
  end;
end;

procedure TfrmMain.SaveLog(Memo: TMemo; stName: string);
var
  s: string;
begin
  with Memo do if Lines.Count > 0 then begin
    try
      s := ExtractFileDir(ParamStr(0)) + '\'+ LOGS_DIR + '\'+ FormatDateTime('dd_mm_yyyy',Now) + '\';
      ForceDirectories(s);
      
      Memo.Lines.Append('');
      Memo.Lines.Append('// '+mitVersion.Caption);
      
      Memo.Lines.SaveToFile(s + stName + '.log');
    except
      ErrBox('Ошибка при сохранении отчёта !')
    end;
  end;
end;

procedure TfrmMain.btbSaveTerminalClick(Sender: TObject);
begin
  inherited;
  SaveLog(redTerminal, 'Терминал ' + DateTime2Str + ' ');
  SaveMemo(redTerminal, 'Терминал ' + DateTime2Str + ' ');
end;

procedure TfrmMain.ShowRepeat;
begin
  inherited;
  stbMain.Panels[panREPEATS].Text := ' повтор: ' + IntToStr(cbMaxRepeat);
end;

procedure TfrmMain.btbCrealInfoClick(Sender: TObject);
begin
  inherited;
  SaveLog(redTerminal, 'Терминал ' + DateTime2Str + ' ');
  ClearInfo;
end;

procedure TfrmMain.btbSaveInfoClick(Sender: TObject);
begin
  inherited;
  SaveLog(redTerminal, 'Терминал ' + DateTime2Str + ' ');
  SaveMemo(memInfo, 'Отчет ' + DateTime2Str + ' ');
end;

procedure TfrmMain.itmSetAllClick(Sender: TObject);
var
  i:  byte;
begin
  inherited;
  with clbMain do for i := 0 to Count-1 do Checked[i] := True;
end;

procedure TfrmMain.itmClearAllClick(Sender: TObject);
var
  i:  byte;
begin
  inherited;
  with clbMain do for i := 0 to Count-1 do Checked[i] := False;
end;

procedure TfrmMain.btbRunClick(Sender: TObject);
begin
  inherited;
  BoxRead;  
end;

procedure TfrmMain.btbTransitClick(Sender: TObject);
begin
  inherited;
  QueryTransit;
end;

procedure TfrmMain.btbGetTime2Click(Sender: TObject);
begin
  inherited;
  BoxGetOpen2(acGetTime2);
end;

procedure TfrmMain.btbCorrectTime2Click(Sender: TObject);
begin
  inherited;
  if (Application.MessageBox(
      PChar('Коррекция времени разрешена при следующих условиях:' + #10#13 +
      '1) один раз в сутки' + #10#13 +
      '2) на величину плюс/минус 2 минуты' + #10#13 +
      '3) без перехода в другой час' + #10#13 +
      'Продолжить ?'),
      'Информация',mb_IconAsterisk + mb_YesNo + mb_DefButton2) <> idYes) then Exit;

  BoxGetOpen2(acGetCorrect2);
end;

procedure TfrmMain.btbSetupTime2Click(Sender: TObject);
begin
  inherited;
  if (Application.MessageBox(
      PChar('Установка времени может может вызвать нарушение в работе счетчика !' + #10#13 +
      'Для получения дополнительных сведений обратитесь с документации' + #10#13 + 
      'Продолжить ?'),
      'Внимание',mb_IconWarning + mb_YesNo + mb_DefButton2) <> idYes) then Exit;

  if not Assigned(frmSetup2) then frmSetup2 := TfrmSetup2.Create(Self);
  frmSetup2.ShowModal;
end;

procedure TfrmMain.pgcFunctionsChange(Sender: TObject);
begin
  inherited;
  btbRun.Enabled := pgcFunctions.ActivePage = tbsFunction1;
end;

procedure TfrmMain.clbMainMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
const
  a: Longint = -1;
var
  b: Longint;
begin
  inherited;
  with Sender as TCheckListBox do begin
    b := ItemAtPos(Point(x,y),True);
    if (b < 0) or (b = a) then Exit;
    Application.ProcessMessages; 
    Application.CancelHint;
    a := b;
    Hint := '';
    //if Canvas.TextWidth(Items[b]) > Width - 4 then 
      Hint := Items[b];
  end;
end;

procedure TfrmMain.btbDisableSeasonTimeClick(Sender: TObject);
begin
  inherited;
  if (Application.MessageBox(
      PChar('Запретить переход на летнее/зимнее время ?'),
      'Информация',mb_IconAsterisk + mb_YesNo + mb_DefButton2) <> idYes) then Exit;

  BoxGetOpen2(acGetDisableSeasonTime);
end;

procedure TfrmMain.btbEnableSeasonTimeClick(Sender: TObject);
begin
  inherited;
  if (Application.MessageBox(
      PChar('Разрешить переход на летнее/зимнее время ?'),
      'Информация',mb_IconAsterisk + mb_YesNo + mb_DefButton2) <> idYes) then Exit;

  BoxGetOpen2(acGetEnableSeasonTime);
end;

end.


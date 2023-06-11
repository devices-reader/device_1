program device_1;

{%ToDo 'device_1.todo'}

uses
  Forms,
  Windows,
  basic in 'basic.pas' {frmBasic},
  main in 'main.pas' {frmMain},
  box in 'box.pas',
  crc in 'crc.pas',
  kernel in 'kernel.pas',
  ports in 'ports.pas',
  progress in 'progress.pas',
  sinput in 'sinput.pas',
  soutput in 'soutput.pas',
  support in 'support.pas',
  terminal in 'terminal.pas',
  timez in 'timez.pas',
  realz in 'realz.pas',
  calendar in 'calendar.pas',
  borders in 'borders.pas',
  get_time in 'get_time.pas',
  get_open in 'get_open.pas',
  get_koeffs in 'get_koeffs.pas',
  get_engabs in 'get_engabs.pas',
  get_engabstar in 'get_engabstar.pas',
  get_calc1 in 'get_calc1.pas',
  get_engdaycurtar in 'get_engdaycurtar.pas',
  get_info in 'get_info.pas',
  get_time2 in 'get_time2.pas',
  get_open2 in 'get_open2.pas',
  get_correct2 in 'get_correct2.pas',
  get_setup2 in 'get_setup2.pas',
  ok in 'ok.pas' {frmOK},
  yesno in 'yesno.pas' {frmYesNo},
  setup2 in 'setup2.pas' {frmSetup2},
  get_summer in 'get_summer.pas',
  get_winter in 'get_winter.pas',
  get_summer2 in 'get_summer2.pas',
  get_winter2 in 'get_winter2.pas',
  get_flags in 'get_flags.pas',
  get_flags2 in 'get_flags2.pas',
  get_graph_top in 'get_graph_top.pas',
  get_graph_header in 'get_graph_header.pas',
  get_graph_data in 'get_graph_data.pas',
  get_engmon in 'get_engmon.pas',
  get_calc2 in 'get_calc2.pas',
  get_engdaycur in 'get_engdaycur.pas',
  get_id in 'get_id.pas',
  get_version in 'get_version.pas',
  get_disable_season_time in 'get_disable_season_time.pas',
  get_enable_season_time in 'get_enable_season_time.pas',
  get_engdayprev in 'get_engdayprev.pas',
  t_profile2 in 't_profile2.pas';

{$R *.RES}

var
  hMutex: THandle;

begin
  hMutex := CreateMutex(nil, True, 'device_1');
  if GetLastError <> 0 then
  begin
    WrnBox('Программа ''device_1'' уже запущена !');
    ReleaseMutex(hMutex);
    Exit;
  end;

  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmSetup2, frmSetup2);
  Application.Run;

  ReleaseMutex(hMutex);
  if GetLastError <> 0 then ;
end.

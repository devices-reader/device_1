�
 TFRMMAIN 0;1  TPF0�TfrmMainfrmMainLeftETop:BorderStylebsSingleCaptionB   Чтение параметров счетчика СЭТ-4ТМ.02ClientHeight�ClientWidth�WindowStatewsMaximizedOnClose	FormCloseOnCreate
FormCreate	OnDestroyFormDestroyOnResize
FormResizeOnShowFormShowPixelsPerInchx
TextHeight 
TStatusBarstbMainLeft Top�Width�HeightPanelsWidth�  Width�  Width�  Width�  Width�  Width,  SizeGrip  TPanel	panClientLeft Top Width�Height�AlignalClient
BevelOuterbvNoneTabOrder TPageControlpgcMainLeft Top Width�Height�
ActivePage	tbsParamsAlignalClientTabOrder  	TTabSheettbsFirstCaption
   !>548=5=85	PopupMenuppmMain TLabellblComNumberLeftTop+Width%HeightCaption   >@B  TLabellblBaudLeftTopQWidthDHeightCaption   !:>@>ABL  TLabel	lblParityLeftTopwWidthCHeightCaption   'QB=>ABL  TLabel
lblConnectLeftTopWidth� HeightCaption   Параметры порта  TLabel
lblTimeoutLeftTop� Width=HeightCaption   "09<0CBParentShowHintShowHint	  TLabel	lblDeviceLeftTop� Width� HeightCaption   Параметры обмена  TLabellblServerAddrLeft� Top� WidthHHeightCaption   !C<<0B>@  TLabellblColWidthLeft� TopQWidth� HeightCaption*   Ширина столбца таблицы  TLabel	lblDigitsLeft� Top+Width� HeightCaption;   Количество знаков после запятой  TLabel
lblSettingLeft� TopWidth� HeightCaption   Параметры отчета  TLabellblProtocolLeft� Top� Width� HeightCaption%   Параметры протокола  	TComboBoxcmbComNumberLeftmTop&WidthVHeightStylecsDropDownListDropDownCount
ItemHeightTabOrder OnChangecmbComNumberChangeItems.StringsCOM1COM2COM3COM4COM5COM6COM7COM8   	TComboBoxcmbBaudLeftmTopLWidthVHeightStylecsDropDownListDropDownCount
ItemHeightTabOrderOnChangecmbBaudChangeItems.Strings300600120024004800960019200   TEdit
edtTimeoutLeftmTop� Width@HeightParentShowHintShowHint	TabOrderText500  TUpDown
updTimeoutLeft� Top� WidthHeight	Associate
edtTimeoutMin2Max0u	Increment2ParentShowHintPosition�ShowHint	TabOrder	Thousands  	TComboBox	cmbParityLeftmToprWidthVHeightStylecsDropDownList
ItemHeightTabOrderOnChangecmbParityChangeItems.Stringsnoneevenoddmarkspace   TPanelpanTAPILeft TopSWidth�HeightAlignalBottom
BevelOuterbvNoneTabOrder TLabellblSelectedDeviceLeft�TopWidthyHeightCaptionlblSelectedDevice  TMemomemDialLeft TopvWidth�Height� AlignalBottomFont.CharsetRUSSIAN_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameLucida Console
Font.Style 
ParentFontReadOnly	
ScrollBarsssBothTabOrder  TBitBtnbtbSelectDeviceLeft� Top
WidthwHeightCaption   >45<TabOrderOnClickbtbSelectDeviceClickMargin  TBitBtnbtbShowConfigDialogLeft:Top
WidthvHeightCaption	   0AB@>9:0TabOrderOnClickbtbShowConfigDialogClickMargin	NumGlyphs  TBitBtnbtbDialLeft� Top9WidthwHeightCaption   K7>2TabOrderOnClickbtbDialClickMargin	NumGlyphs  TBitBtnbtbCancelCallLeft�Top9WidthwHeightCaption   Отбой !TabOrderOnClickbtbCancelCallClickMargin  TEditedtDialLeft:Top9WidthvHeightTabOrder  TRadioGrouprgrTAPILeftTop
WidthwHeightMCaption    Модем 	ItemIndex Items.Strings   нет   да TabOrder OnClickrgrTAPIClick  	TCheckBoxchbCancelCallLeftTop]Width�HeightCaptionb   автоматически разъединиться после завершения опросаChecked	State	cbCheckedTabOrder   TEditedtServerAddrLeftHTop� Width@HeightTabOrderText0  TUpDownupdServerAddrLeft�Top� WidthHeight	AssociateedtServerAddrMax� TabOrder	Thousands  	TCheckBox	chbPacketLeft� TopWidth� HeightCaption   Заголовок пакетаChecked	State	cbCheckedTabOrder  	TCheckBox	chbTunnelLeft� Top� Width`HeightCaption   "C==5;LTabOrder	  	TComboBox	cmbTunnelLeftHTop� WidthUHeightStylecsDropDownList
ItemHeightTabOrder
Items.Strings
   порт 1
   порт 2
   порт 3
   порт 4   TEditedtColWidthLeft�TopLWidth"HeightTabOrderText10  TUpDownupdColWidthLeftTopLWidthHeight	AssociateedtColWidthMinPosition
TabOrder	Thousands  TEdit	edtDigitsLeft�Top&Width"HeightTabOrderText4  TUpDown	updDigitsLeftTop&WidthHeight	Associate	edtDigitsMax
PositionTabOrder	Thousands   	TTabSheet	tbsParamsCaption	   0@0<5B@K
ImageIndex 	TSplittersplMainLeft�Top WidthHeight?AutoSnapMinSizex  TPanel
panBottom2Left Top?Width�Height0AlignalBottom
BevelOuterbvNoneTabOrder  TPanel	panRigth2Left5Top Width�Height0AlignalRight
BevelOuterbvNoneTabOrder  TBitBtnbtbCrealInfoLeft� Top
WidthwHeightCaption   G8AB8BLTabOrderOnClickbtbCrealInfoClickMargin  TBitBtnbtbSaveInfoLeftTop
WidthwHeightCaption   В файл  TabOrder OnClickbtbSaveInfoClickMargin	NumGlyphs  TBitBtnbtbStopInfoLeftTop
WidthwHeightCaption
   Стоп !TabOrderOnClickbtbStopInfoClickMargin    TPanel
panClient2Left�Top WidthHeight?AlignalClient
BevelOuterbvNoneTabOrder TPanelpanTop2Left Top WidthHeight� AlignalTop
BevelOuterbvNoneTabOrder  TLabellblDeviceAddrLeft� TopWidth=HeightCaption   !G5BG8:  TLabellblDevicePassLeft�TopWidth6HeightCaption   0@>;L  TLabellblMonthFromLeftTop� Width� HeightCaption(   Энергия по месяцам: отEnabled  TLabellblMonthsToLeftTop� WidthHeightCaption   4>Enabled  TLabellblDaysFromLeftTop� Width� HeightCaption&   Энергия по суткам: отEnabled  TLabel	lblDaysToLeftTop� WidthHeightCaption   4>Enabled  TLabellblMonthNameLeft`Top� Width� HeightCaption!   месяцев назад (0..11)Enabled  TLabellblDaysNameLeft`Top� Width� HeightCaption   суток назад (0..27)Enabled  TLabellblDaysFrom2LeftTop� Width� HeightCaption,   Энергия по получасам: отEnabled  TLabel
lblDaysTo2LeftTop� WidthHeightCaption   4>Enabled  TLabellblDaysName2Left`Top� Width� HeightCaption   суток назад (0..61?)Enabled  TLabellblGraphTopLeftTop9Width� HeightCaption   Энергия по часам:  TLabellblGraphOffsetLeft� Top9Width� HeightCaption.   смещение от начала, часов  TLabellblGraphCountLeft� Top_Width� HeightCaption    количество, часов  TBitBtnbtbRunLeftTop
Width� HeightCaption%   Прочитать параметрыTabOrder OnClickbtbRunClickMargin  TEditedtDeviceAddrLeft*Top
Width1HeightTabOrderText0  TUpDownupdDeviceAddrLeft[Top
WidthHeight	AssociateedtDeviceAddrMax� TabOrder	Thousands  TEditedtMonthsMinLeft� Top� Width&HeightEnabledTabOrderText0  TEditedtMonthsMaxLeft+Top� Width&HeightEnabledTabOrderText1  TEdit
edtDaysMinLeft� Top� Width&HeightEnabledTabOrderText0  TEdit
edtDaysMaxLeft+Top� Width&HeightEnabledTabOrderText1  TEditedtDaysMin2Left� Top� Width&HeightEnabledTabOrderText0  TEditedtDaysMax2Left+Top� Width&HeightEnabledTabOrder	Text60  TBitBtn
btbTransitLeft'Top
Width� HeightCaption'   Неуправляемый тразитTabOrder
OnClickbtbTransitClickMargin  	TMaskEditmedDevicePassLeft�Top
Width?HeightEditMask
000000;1;*	MaxLengthTabOrderText        TEditedtGraphOffsetLeft�Top4Width1HeightTabOrderText0  TUpDownupdGraphOffsetLeft�Top4WidthHeight	AssociateedtGraphOffsetMax�
TabOrder	Thousands  TEditedtGraphCountLeft�TopZWidth1HeightTabOrderText24  TUpDownupdGraphCountLeft�TopZWidthHeight	AssociateedtGraphCountMax�
PositionTabOrder	Thousands   TMemomemInfoLeft Top� WidthHeight�AlignalClientFont.CharsetRUSSIAN_CHARSET
Font.ColorclGrayFont.Height�	Font.NameLucida Console
Font.Style 
ParentFont
ScrollBarsssBothTabOrder   TPageControlpgcFunctionsLeft Top Width�Height?
ActivePagetbsFunction2AlignalLeftTabOrderOnChangepgcFunctionsChange 	TTabSheettbsFunction1Caption   'B5=85 TCheckListBoxclbMainLeft Top Width�HeightAlignalClient
ItemHeightParentShowHint	PopupMenuppmListShowHint	TabOrder OnMouseMoveclbMainMouseMove   	TTabSheettbsFunction2Caption   0?8AL
ImageIndex TBitBtnbtbGetTime2Left
Top
WidthHeightCaption-   Текущее время: прочитатьTabOrder OnClickbtbGetTime2ClickMargin  TBitBtnbtbSetupTime2Left
TopVWidthHeightCaption/   Текущее время: установитьTabOrderOnClickbtbSetupTime2ClickMargin  TBitBtnbtbCorrectTime2Left
Top0WidthHeightCaption7   Текущее время: корректироватьTabOrderOnClickbtbCorrectTime2ClickMargin  TBitBtnbtbDisableSeasonTimeLeft
Top� WidthXHeightCaptionK   Запретить переход на летнее/зимнее времяTabOrderWordWrap	OnClickbtbDisableSeasonTimeClickMargin  TBitBtnbtbEnableSeasonTimeLeft
Top� WidthXHeightCaptionK   Разрешить переход на летнее/зимнее времяTabOrderWordWrap	OnClickbtbEnableSeasonTimeClickMargin     	TTabSheettbsLastCaption   "5@<8=0; TPanelpanTop3Left Top:Width�Height0AlignalBottom
BevelOuterbvNoneTabOrder  TPanel	panRight3LeftTop Width�Height0AlignalRight
BevelOuterbvNoneTabOrder  TBitBtnbtbClearTerminalLeft� Top
WidthwHeightCaption   G8AB8BLTabOrderOnClickbtbClearTerminalClickMargin  TBitBtnbtbSaveTerminalLeftTop
WidthwHeightCaption   В файл  TabOrder OnClickbtbSaveTerminalClickMargin	NumGlyphs  TBitBtnbtbStopTerminalLeftTop
WidthwHeightCaption
   Стоп !TabOrderOnClickbtbStopInfoClickMargin   	TCheckBoxchbTerminalLeftTopWidth� HeightCaption)   использовать терминалChecked	State	cbCheckedTabOrder   TMemoredTerminalLeft Top Width�Height:AlignalClientFont.CharsetRUSSIAN_CHARSET
Font.ColorclGrayFont.Height�	Font.NameLucida Console
Font.Style 
ParentFontReadOnly	
ScrollBars
ssVerticalTabOrder
OnKeyPressredTerminalKeyPress     TProgressBarprbMainLeft�Top�Width� HeightTabOrder  TApdComPortComPort	ComNumberBaud�InSize  AutoOpen	TraceSize }	TraceNameAPRO.TRCLogSize��  LogNameAPRO.LOGTapiModetmOnOnTriggerAvailComPortTriggerAvailLeft�Top  TTimer
timTimeoutEnabledOnTimertimTimeoutTimerLeft�Top  TTimertimNowInterval,OnTimertimNowTimerLeft�Top  TSaveDialogsd_RichToFile
DefaultExttxtFilter!   файл формата TXT|*.txtOptionsofOverwritePromptofHideReadOnly Title   Записать файлLeft�Top  TApdTapiDevice
TapiDeviceComPortComPortTapiLogTapiLogShowTapiDevices		ShowPortsEnableVoiceOnTapiStatusTapiDeviceTapiStatus	OnTapiLogTapiDeviceTapiLogOnTapiPortOpenTapiDeviceTapiPortOpenOnTapiPortCloseTapiDeviceTapiPortCloseOnTapiConnectTapiDeviceTapiConnect
OnTapiFailTapiDeviceTapiFailLeft Top  TApdTapiLogTapiLogTapiHistoryNamesem2reader.his
TapiDevice
TapiDeviceLeftHTop  
TPopupMenuppmMainLeftpTop 	TMenuItem
mitVersionCaption2   версия от 6 сентября 2014 года   
TPopupMenuppmListLeft�Top 	TMenuItem	itmSetAllCaption(   Установить все пунктыOnClickitmSetAllClick  	TMenuItemitmClearAllCaption$   Сбросить все пунктыOnClickitmClearAllClick    
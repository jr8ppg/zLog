unit UHamlogConv;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Menus,
  System.AnsiStrings, Vcl.ComCtrls, System.IniFiles, System.DateUtils,
  UOptions, UzLogConst, UzLogQSO, HelperLib, Hamlog50, HamlogIf;

type
  THamlogConverter = class(TForm)
    dateRangeFrom: TDateTimePicker;
    dateRangeTo: TDateTimePicker;
    radioDateRange: TRadioButton;
    GroupBox1: TGroupBox;
    radioRecordNumRange: TRadioButton;
    editRecordNumFrom: TEdit;
    editRecordNumTo: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    buttonStart: TButton;
    GroupBox2: TGroupBox;
    editHamlogDatabase: TEdit;
    buttonHamlogRef: TButton;
    OpenDialog1: TOpenDialog;
    GroupBox3: TGroupBox;
    radioRcvdNr1: TRadioButton;
    radioRcvdNr2: TRadioButton;
    radioRcvdNr3: TRadioButton;
    timeRangeFrom: TDateTimePicker;
    timeRangeTo: TDateTimePicker;
    GroupBox4: TGroupBox;
    CheckBox1: TCheckBox;
    buttonPowerSetting: TButton;
    procedure buttonCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure buttonStartClick(Sender: TObject);
    procedure radioDateRangeClick(Sender: TObject);
    procedure radioRecordNumRangeClick(Sender: TObject);
    procedure buttonHamlogRefClick(Sender: TObject);
    procedure buttonPowerSettingClick(Sender: TObject);
  private
    { Private declarations }
    FHamlog: THamlogData;

    FLastFolder: string;
    FLastHdbName: string;
    FLastHamlogDatabase: string;
    procedure LoadSettings();
    procedure SaveSettings();
    procedure ImplementOptions;
    procedure ReadDateRange(Log: TLog);
    procedure ReadRecordNumRange(Log: TLog);
    function ConvQso(Q: THamlogQso; rcvdnr_no: Integer): TQSO;
    function RcvdNrNo(): Integer;
  public
    { Public declarations }
  end;

var
   HamlogConverter: THamlogConverter;

implementation

uses
  UzLogGlobal, UPowerDialog;

{$R *.DFM}

procedure THamlogConverter.FormCreate(Sender: TObject);
begin
   FHamlog := THamlogData.Create();
   LoadSettings();
   ImplementOptions();
end;

procedure THamlogConverter.FormDestroy(Sender: TObject);
begin
   FHamlog.Free();
   SaveSettings();
end;

procedure THamlogConverter.FormShow(Sender: TObject);
begin
   if radioDateRange.Checked = True then begin
      radioDateRangeClick(nil);
   end
   else begin
      radioRecordNumRangeClick(nil);
   end;
end;

procedure THamlogConverter.buttonCloseClick(Sender: TObject);
begin
   Close;
end;

procedure THamlogConverter.LoadSettings();
var
   ini: TMemIniFile;
   num: Integer;
   i: Integer;
   strKey: string;
begin
   ini := TMemIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
   try
      Self.Top := ini.ReadInteger('window', 'top', Self.Top);
      Self.Left := ini.ReadInteger('window', 'left', Self.Left);
      Self.Width := ini.ReadInteger('window', 'width', Self.Width);
      Self.Height := ini.ReadInteger('window', 'height', Self.Height);

      FLastFolder := ini.ReadString('HAMLOG', 'lastfolder', '');
      FLastHdbName := ini.ReadString('HAMLOG', 'lastfilename', '');
      FLastHamlogDatabase := ini.ReadString('HAMLOG', 'lastdatabase', '');
   finally
      ini.Free();
   end;
end;

procedure THamlogConverter.SaveSettings();
var
   ini: TMemIniFile;
   i: Integer;
   strKey: string;
begin
   ini := TMemIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
   try
      ini.WriteInteger('window', 'top', Self.Top);
      ini.WriteInteger('window', 'left', Self.Left);
      ini.WriteInteger('window', 'width', Self.Width);
      ini.WriteInteger('window', 'height', Self.Height);

      ini.WriteString('HAMLOG', 'lastfolder', FLastFolder);
      ini.WriteString('HAMLOG', 'lastfilename', FLastHdbName);
      ini.WriteString('HAMLOG', 'lastdatabase', FLastHamlogDatabase);

      ini.UpdateFile();
   finally
      ini.Free();
   end;
end;

procedure THamlogConverter.ImplementOptions();
begin
   editHamlogdatabase.Text := FLastHamlogDatabase;
end;

procedure THamlogConverter.radioDateRangeClick(Sender: TObject);
begin
   dateRangeFrom.Enabled := True;
   dateRangeTo.Enabled := True;
   timeRangeFrom.Enabled := True;
   timeRangeTo.Enabled := True;
   editRecordNumFrom.Enabled := False;
   editRecordNumTo.Enabled := False;
end;

procedure THamlogConverter.radioRecordNumRangeClick(Sender: TObject);
begin
   editRecordNumFrom.Enabled := True;
   editRecordNumTo.Enabled := True;
   dateRangeFrom.Enabled := False;
   dateRangeTo.Enabled := False;
   timeRangeFrom.Enabled := False;
   timeRangeTo.Enabled := False;
end;

procedure THamlogConverter.buttonHamlogRefClick(Sender: TObject);
begin
   if editHamlogDatabase.Text = '' then begin
      OpenDialog1.InitialDir := ExtractFilePath(Application.ExeName);
   end
   else begin
      OpenDialog1.InitialDir := ExtractFilePath(editHamlogDatabase.Text);
   end;

   if OpenDialog1.Execute(Handle) = False then begin
      Exit;
   end;

   editHamlogDatabase.Text := OpenDialog1.FileName;
end;

procedure THamlogConverter.buttonPowerSettingClick(Sender: TObject);
var
   dlg: TformPowerDialog;
begin
   dlg := TformPowerDialog.Create(Self);
   try
      if dlg.ShowModal() <> mrOK then begin
         Exit;
      end;
   finally
      dlg.Release();
   end;
end;

procedure THamlogConverter.buttonStartClick(Sender: TObject);
var
   zlog_filename: string;
   Log: TLog;
   cnt: Integer;
begin
   if FHamlog.Open(editHamlogDatabase.Text) = False then begin
      Exit;
   end;

   Log := TLog.Create('HAMLOG Converter');

   if radioDateRange.Checked = True then begin
      ReadDateRange(Log);
   end;
   if radioRecordNumRange.Checked = True then begin
      ReadRecordNumRange(Log);
   end;

   zlog_filename := ChangeFileExt(editHamlogDatabase.Text, '.ZLOX');
   Log.SaveToFileEx(zlog_filename);
   cnt := Log.TotalQSO;
   Log.Free();

   FLastHamlogDatabase := editHamlogDatabase.Text;

   FHamlog.Close();

   MessageBox(Handle, PChar(IntToStr(cnt) + ' QSOを変換しました.'), PChar(Application.Title), MB_OK or MB_ICONINFORMATION);
end;

procedure THamlogConverter.ReadDateRange(Log: TLog);
var
   reccnt: Integer;
   i: Integer;
   Q: THamlogQso;
   dtFrom, dtTo: TDateTime;
   qso: TQSO;
   rcvdnr: Integer;
begin
   dtFrom := dateRangeFrom.Date + timeRangeFrom.Time;
   dtTo := dateRangeTo.Date + timeRangeTo.Time;
   rcvdnr := RcvdNrNo();
   reccnt := FHamlog.RecordCount;
   for i := 1 to reccnt do begin
      Q := FHamlog.Read(i);

      // 範囲外日付をスキップ
      if (Q.DateTime < dtFrom) or (Q.DateTime > dtTo) then begin
         Continue;
      end;

      // zLogへ変換
      qso := ConvQso(Q, rcvdnr);

      Log.Add(qso);
   end;
end;

procedure THamlogConverter.ReadRecordNumRange(Log: TLog);
var
   i: Integer;
   Q: THamlogQso;
   recnumFrom, recnumTo: Integer;
   qso: TQSO;
   rcvdnr: Integer;
begin
   recnumFrom := StrToIntDef(editRecordNumFrom.Text, 0);
   recnumTo := StrToIntDef(editRecordNumTo.Text, 0);
   rcvdnr := RcvdNrNo();

   for i := recnumFrom to recnumTo do begin
      Q := FHamlog.Read(i);

      // zLogへ変換
      qso := ConvQso(Q, rcvdnr);

      Log.Add(qso);
   end;
end;

function THamlogConverter.ConvQso(Q: THamlogQso; rcvdnr_no: Integer): TQSO;
var
   qso: TQSO;
   defrst: Integer;
   band: Integer;

   function ConvMode(S: string): TMode;
   var
      m: TMode;
   begin
      for m := Low(ModeString) to High(ModeString) do begin
         if ModeString[m] = S then begin
            Result := m;
            Exit;
         end;
      end;

      Result := mOther;
   end;
begin
   qso := TQSO.Create();
   qso.Callsign := Q.Callsign;
   qso.Time := Q.DateTime;
   qso.Mode := ConvMode(Q.Mode);

   band := Q.Band;
   if band <= Ord(b5600) then begin
      qso.Band := TBand(band);
   end
   else begin
      qso.Band := bUnknown;
   end;
   qso.Freq := Q.Freq;

   if (qso.Mode = mCW) or (qso.Mode = mRTTY) then begin
      defrst := 599;
   end
   else begin
      defrst := 59;
   end;

   qso.RSTSent := StrToIntDef(Q.HisRst, defrst);
   qso.RSTRcvd := StrToIntDef(Q.MyRst, defrst);

   case rcvdnr_no of
      0: qso.NrRcvd := Q.Code;
      1: qso.NrRcvd := Q.Rmk1;
      2: qso.NrRcvd := Q.Rmk2;
      else qso.NrRcvd := '';
   end;

   Result := qso;
end;

function THamlogConverter.RcvdNrNo(): Integer;
begin
   if radioRcvdNr1.Checked = True then begin
      Result := 0;
   end
   else if radioRcvdNr2.Checked = True then begin
      Result := 1;
   end
   else if radioRcvdNr3.Checked = True then begin
      Result := 2;
   end
   else begin
      Result := 0;
   end;
end;

end.

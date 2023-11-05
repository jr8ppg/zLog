unit UELogCabrillo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.IniFiles, System.UITypes,
  UzLogGlobal;

type
  TformELogCabrillo = class(TForm)
    Panel1: TPanel;
    buttonCreateLog: TButton;
    buttonSave: TButton;
    buttonCancel: TButton;
    editCallsign: TEdit;
    comboAssisted: TComboBox;
    comboBand: TComboBox;
    comboMode: TComboBox;
    comboOperator: TComboBox;
    comboPower: TComboBox;
    comboStation: TComboBox;
    comboTime: TComboBox;
    comboTransmitter: TComboBox;
    comboOverlay: TComboBox;
    Label1: TLabel;
    comboCertificate: TComboBox;
    Label2: TLabel;
    editClaimedScore: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label15: TLabel;
    editClub: TEdit;
    editEmail: TEdit;
    Label17: TLabel;
    editGridLocator: TEdit;
    Label18: TLabel;
    comboLocation: TComboBox;
    Label19: TLabel;
    editName: TEdit;
    Label20: TLabel;
    editAddress: TEdit;
    Label21: TLabel;
    editAddressCity: TEdit;
    editAddressStateProvince: TEdit;
    Label22: TLabel;
    Label23: TLabel;
    editAddressPostalcode: TEdit;
    editAddressCountry: TEdit;
    Label24: TLabel;
    Label25: TLabel;
    editOperators: TEdit;
    Label26: TLabel;
    editOfftime: TEdit;
    editSoapbox: TEdit;
    Label27: TLabel;
    Label28: TLabel;
    GroupBox1: TGroupBox;
    radioUTC: TRadioButton;
    radioJST: TRadioButton;
    comboContest: TComboBox;
    Label29: TLabel;
    SaveDialog1: TSaveDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure buttonSaveClick(Sender: TObject);
    procedure buttonCancelClick(Sender: TObject);
    procedure buttonCreateLogClick(Sender: TObject);
  private
    { Private 宣言 }
    procedure InitializeFields();
  public
    { Public 宣言 }
  end;

implementation

uses
  Main;

{$R *.dfm}

procedure TformELogCabrillo.FormCreate(Sender: TObject);
begin
   InitializeFields();
end;

procedure TformELogCabrillo.FormDestroy(Sender: TObject);
begin
//
end;

procedure TformELogCabrillo.buttonCancelClick(Sender: TObject);
begin
   Close();
end;

procedure TformELogCabrillo.buttonCreateLogClick(Sender: TObject);
var
   nTimeZoneOffset: Integer;
   slSummaryInfo: TStringList;
   fname: string;
begin
   slSummaryInfo := TStringList.Create();
   try
      // TimeZoneオフセット
      if radioUTC.Checked = True then begin
         nTimeZoneOffset := 0;
      end
      else begin
         nTimeZoneOffset := 9;
      end;

      // ヘッダー部
      slSummaryInfo.Add('CALLSIGN: ' +            editCallsign.Text);
      slSummaryInfo.Add('CONTEST: ' +             comboContest.Text);
      slSummaryInfo.Add('CATEGORY-ASSISTED: ' +   comboAssisted.Text);
      slSummaryInfo.Add('CATEGORY-BAND: ' +       comboBand.Text);
      slSummaryInfo.Add('CATEGORY-MODE: ' +       comboMode.Text);
      slSummaryInfo.Add('CATEGORY-OPERATOR: ' +   comboOperator.Text);
      slSummaryInfo.Add('CATEGORY-POWER: ' +      comboPower.Text);
      slSummaryInfo.Add('CATEGORY-STATION: ' +    comboStation.Text);
      slSummaryInfo.Add('CATEGORY-TIME: ' +       comboTime.Text);
      slSummaryInfo.Add('CATEGORY-TRANSMITTER: ' + comboTransmitter.Text);
      slSummaryInfo.Add('CATEGORY-OVERLAY: ' +    comboOverlay.Text);
      slSummaryInfo.Add('CERTIFICATE: ' +         comboCertificate.Text);
      slSummaryInfo.Add('CLAIMED-SCORE: ' +       editClaimedScore.Text);
      slSummaryInfo.Add('CLUB: ' +                editClub.Text);
      slSummaryInfo.Add('CREATED-BY: ZLOG');
      slSummaryInfo.Add('EMAIL: ' +               editEmail.Text);
      slSummaryInfo.Add('GRID-LOCATOR: ' +        editGridLocator.Text);
      slSummaryInfo.Add('LOCATION: ' +            comboLocation.Text);
      slSummaryInfo.Add('NAME: ' +                editName.Text);
      slSummaryInfo.Add('ADDRESS: ' +             editAddress.Text);
      slSummaryInfo.Add('ADDRESS-CITY: ' +        editAddressCity.Text);
      slSummaryInfo.Add('ADDRESS-STATE-PROVINCE: ' + editAddressStateProvince.Text);
      slSummaryInfo.Add('ADDRESS-POSTALCODE: ' +  editAddressPostalCode.Text);
      slSummaryInfo.Add('ADDRESS-COUNTRY: ' +     editAddressCountry.Text);
      slSummaryInfo.Add('OPERATORS: ' +           editOperators.Text);
      slSummaryInfo.Add('OFFTIME: ' +             editOffTime.Text);
      slSummaryInfo.Add('SOAPBOX: ' +             editSoapbox.Text);

      if CurrentFileName <> '' then begin
         SaveDialog1.InitialDir := ExtractFilePath(CurrentFileName);
         SaveDialog1.FileName := ChangeFileExt(ExtractFileName(CurrentFileName), '.CBR');
      end;

      if SaveDialog1.Execute() = False then begin
         Exit;
      end;

      fname := SaveDialog1.FileName;

      // 既にファイルがある場合は上書き確認
      if FileExists(fname) = True then begin
         if MessageDlg('[' + fname + '] file already exists. overwrite?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then begin
            Exit;
         end;
      end;

      // Cabrillo出力
      Log.SaveToFileByCabrillo(fname, nTimeZoneOffset, slSummaryInfo);
   finally
      slSummaryInfo.Free();
   end;
end;

procedure TformELogCabrillo.buttonSaveClick(Sender: TObject);
var
   ini: TMemIniFile;
begin
   ini := TMemIniFile.Create(ExtractFilePath(Application.ExeName) + 'zlog_cbr.ini');
   try
      ini.WriteString('SummaryInfo', 'CALLSIGN',            editCallsign.Text);
      ini.WriteString('SummaryInfo', 'CONTEST',             comboContest.Text);
      ini.WriteString('SummaryInfo', 'CATEGORY-ASSISTED',   comboAssisted.Text);
      ini.WriteString('SummaryInfo', 'CATEGORY-BAND',       comboBand.Text);
      ini.WriteString('SummaryInfo', 'CATEGORY-MODE',       comboMode.Text);
      ini.WriteString('SummaryInfo', 'CATEGORY-OPERATOR',   comboOperator.Text);
      ini.WriteString('SummaryInfo', 'CATEGORY-POWER',      comboPower.Text);
      ini.WriteString('SummaryInfo', 'CATEGORY-STATION',    comboStation.Text);
      ini.WriteString('SummaryInfo', 'CATEGORY-TIME',       comboTime.Text);
      ini.WriteString('SummaryInfo', 'CATEGORY-TRANSMITTER', comboTransmitter.Text);
      ini.WriteString('SummaryInfo', 'CATEGORY-OVERLAY',    comboOverlay.Text);
      ini.WriteString('SummaryInfo', 'CERTIFICATE',         comboCertificate.Text);
      ini.WriteString('SummaryInfo', 'CLAIMED-SCORE',       editClaimedScore.Text);
      ini.WriteString('SummaryInfo', 'CLUB',                editClub.Text);
      ini.WriteString('SummaryInfo', 'EMAIL',               editEmail.Text);
      ini.WriteString('SummaryInfo', 'GRID-LOCATOR',        editGridLocator.Text);
      ini.WriteString('SummaryInfo', 'LOCATION',            comboLocation.Text);
      ini.WriteString('SummaryInfo', 'NAME',                editName.Text);
      ini.WriteString('SummaryInfo', 'ADDRESS',             editAddress.Text);
      ini.WriteString('SummaryInfo', 'ADDRESS-CITY',        editAddressCity.Text);
      ini.WriteString('SummaryInfo', 'ADDRESS-STATE-PROVINCE', editAddressStateProvince.Text);
      ini.WriteString('SummaryInfo', 'ADDRESS-POSTALCODE',  editAddressPostalCode.Text);
      ini.WriteString('SummaryInfo', 'ADDRESS-COUNTRY',     editAddressCountry.Text);
      ini.WriteString('SummaryInfo', 'OPERATORS',           editOperators.Text);
      ini.WriteString('SummaryInfo', 'OFFTIME',             editOffTime.Text);
      ini.WriteString('SummaryInfo', 'SOAPBOX',             editSoapbox.Text);

      ini.UpdateFile();
   finally
      ini.Free();
   end;
end;

procedure TformELogCabrillo.InitializeFields();
var
   ini: TMemIniFile;

   procedure SetCombo(C: TComboBox; K: string);
   var
      S: string;
   begin
      S := ini.ReadString('SummaryInfo', K, '');
      if S = '' then begin
         C.ItemIndex := -1;
      end
      else begin
         C.ItemIndex := C.Items.IndexOf(S);
      end;
   end;
begin
   ini := TMemIniFile.Create(ExtractFilePath(Application.ExeName) + 'zlog_cbr.ini');
   try
      editCallsign.Text := ini.ReadString('SummaryInfo', 'CALLSIGN', '');

      SetCombo(comboContest,     'CONTEST');
      SetCombo(comboAssisted,    'CATEGORY-ASSISTED');
      SetCombo(comboBand,        'CATEGORY-BAND');
      SetCombo(comboMode,        'CATEGORY-MODE');
      SetCombo(comboOperator,    'CATEGORY-OPERATOR');
      SetCombo(comboPower,       'CATEGORY-POWER');
      SetCombo(comboStation,     'CATEGORY-STATION');
      SetCombo(comboTime,        'CATEGORY-TIME');
      SetCombo(comboTransmitter, 'CATEGORY-TRANSMITTER');
      SetCombo(comboOverlay,     'CATEGORY-OVERLAY');
      SetCombo(comboCertificate, 'CERTIFICATE');

      editClaimedScore.Text := IntToStr(MyContest.ScoreForm.Score);

      editClub.Text :=        ini.ReadString('SummaryInfo', 'CLUB', '');
      editEmail.Text :=       ini.ReadString('SummaryInfo', 'EMAIL', '');
      editGridLocator.Text := ini.ReadString('SummaryInfo', 'GRID-LOCATOR', '');
      SetCombo(comboLocation, 'LOCATION');
      editName.Text :=        ini.ReadString('SummaryInfo', 'NAME', '');
      editAddress.Text :=     ini.ReadString('SummaryInfo', 'ADDRESS', '');
      editAddressCity.Text := ini.ReadString('SummaryInfo', 'ADDRESS-CITY', '');
      editAddressStateProvince.Text := ini.ReadString('SummaryInfo', 'ADDRESS-STATE-PROVINCE', '');
      editAddressPostalCode.Text :=    ini.ReadString('SummaryInfo', 'ADDRESS-POSTALCODE', '');
      editAddressCountry.Text :=       ini.ReadString('SummaryInfo', 'ADDRESS-COUNTRY', '');
      editOperators.Text :=   ini.ReadString('SummaryInfo', 'OPERATORS', '');
      editOffTime.Text :=     ini.ReadString('SummaryInfo', 'OFFTIME', '');
      editSoapbox.Text :=     ini.ReadString('SummaryInfo', 'SOAPBOX', '');
   finally
      ini.Free();
   end;
end;

end.

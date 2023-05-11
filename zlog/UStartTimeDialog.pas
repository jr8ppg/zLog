unit UStartTimeDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.WinXPickers, Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TStartTimeDialog = class(TForm)
    TimePicker1: TTimePicker;
    DatePicker1: TDatePicker;
    OKBtn: TButton;
    CancelBtn: TButton;
    Label1: TLabel;
    panelTimeZone: TPanel;
    procedure FormCreate(Sender: TObject);
  private
    { Private êÈåæ }
    FUseUTC: Boolean;
    function GetBaseTime(): TDateTime;
    procedure SetBaseTime(v: TDateTime);
    function GetUseUTC(): Boolean;
    procedure SetUseUTC(v: Boolean);
  public
    { Public êÈåæ }
    property BaseTime: TDateTime read GetBaseTime write SetBaseTime;
    property UseUTC: Boolean read GetUseUTC write SetUseUTC;
  end;

implementation

{$R *.dfm}

procedure TStartTimeDialog.FormCreate(Sender: TObject);
begin
   FUseUTC := False;
end;

function TStartTimeDialog.GetBaseTime(): TDateTime;
var
   yy, mm, dd, hh, nn, ss, ms: Word;
begin
   DecodeDate(DatePicker1.Date, yy, mm, dd);
   DecodeTime(TimePicker1.Time, hh, nn, ss, ms);
   Result := EncodeDate(yy, mm, dd) + EncodeTime(hh, nn, 0, 0);
end;

procedure TStartTimeDialog.SetBaseTime(v: TDateTime);
var
   hh, mm, ss, ms: Word;
begin
   DatePicker1.Date := Trunc(v);
   DecodeTime(v, hh, mm, ss, ms);
   TimePicker1.Time := EncodeTime(hh, mm, 0, 0);
end;

function TStartTimeDialog.GetUseUTC(): Boolean;
begin
   Result:= FUseUTC;
end;

procedure TStartTimeDialog.SetUseUTC(v: Boolean);
begin
   FUseUtc := v;
   if FUseUTC = True then begin
      panelTimeZone.Caption := 'UTC';
   end
   else begin
      panelTimeZone.Caption := 'JST';
   end;
end;

end.

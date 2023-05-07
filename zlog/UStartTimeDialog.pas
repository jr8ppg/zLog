unit UStartTimeDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.WinXPickers, Vcl.StdCtrls;

type
  TStartTimeDialog = class(TForm)
    TimePicker1: TTimePicker;
    DatePicker1: TDatePicker;
    OKBtn: TButton;
    CancelBtn: TButton;
    Label1: TLabel;
  private
    { Private êÈåæ }
    function GetBaseTime(): TDateTime;
    procedure SetBaseTime(v: TDateTime);
  public
    { Public êÈåæ }
    property BaseTime: TDateTime read GetBaseTime write SetBaseTime;
  end;

implementation

{$R *.dfm}

function TStartTimeDialog.GetBaseTime(): TDateTime;
var
   yy, mm, dd, hh, nn, ss, ms: Word;
begin
   DecodeDate(DatePicker1.Date, yy, mm, dd);
   DecodeTime(TimePicker1.Time, hh, nn, ss, ms);
   Result := EncodeDate(yy, mm, dd) + EncodeTime(hh, 0, 0, 0);
end;

procedure TStartTimeDialog.SetBaseTime(v: TDateTime);
var
   hh, mm, ss, ms: Word;
begin
   DatePicker1.Date := Trunc(v);
   DecodeTime(v, hh, mm, ss, ms);
   TimePicker1.Time := EncodeTime(hh, 0, 0, 0);
end;

end.

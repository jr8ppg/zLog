unit UExportCabrillo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TformExportCabrillo = class(TForm)
    buttonOK: TButton;
    buttonCancel: TButton;
    GroupBox1: TGroupBox;
    radioUTC: TRadioButton;
    radioJST: TRadioButton;
  private
    { Private êÈåæ }
    function GetTimeZoneOffset(): Integer;
  public
    { Public êÈåæ }
    property TimeZoneOffset: Integer read GetTimeZoneOffset;
  end;

implementation

{$R *.dfm}

function TformExportCabrillo.GetTimeZoneOffset(): Integer;
begin
   if radioUTC.Checked = True then begin
      Result := 0;
   end
   else begin
      Result := 9;
   end;
end;

end.

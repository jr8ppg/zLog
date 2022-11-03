unit UFreqTest;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls;

type
  TformFreqTest = class(TForm)
    editFreq: TEdit;
    updownFreq: TUpDown;
    GroupBox1: TGroupBox;
    radioStep100: TRadioButton;
    radioStep1000: TRadioButton;
    radioStep10000: TRadioButton;
    radioStep100000: TRadioButton;
    radioStep1000000: TRadioButton;
    procedure radioStepClick(Sender: TObject);
    procedure updownFreqClick(Sender: TObject; Button: TUDBtnType);
  private
    { Private êÈåæ }
  public
    { Public êÈåæ }
  end;

implementation

{$R *.dfm}

uses
  UBandScope2;

procedure TformFreqTest.radioStepClick(Sender: TObject);
begin
   updownFreq.Increment := TRadioButton(Sender).Tag;
end;

procedure TformFreqTest.updownFreqClick(Sender: TObject; Button: TUDBtnType);
begin
   CurrentRigFrequency := Int64(updownFreq.Position) * 100;
end;

end.

unit USpotForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, UzLogConst, UzLogGlobal, UzLogQSO, URigControl;

type
  TSpotForm = class(TForm)
    FreqEdit: TEdit;
    CallsignEdit: TEdit;
    CommentEdit: TEdit;
    Panel1: TPanel;
    SendButton: TButton;
    CancelButton: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure CancelButtonClick(Sender: TObject);
    procedure SendButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Open(aQSO : TQSO);
  end;

implementation

uses
  Main, UComm;

{$R *.DFM}

procedure TSpotForm.Open(aQSO: TQSO);
var
   str: string;
begin
   str := 'Frequency';
   case aQSO.Band of
      b19:
         str := '19';
      b35:
         str := '35';
      b7:
         str := '7';
      b10:
         str := '10';
      b14:
         str := '14';
      b18:
         str := '18';
      b21:
         str := '21';
      b24:
         str := '24';
      b28:
         str := '28';
      b50:
         str := '50';
      b144:
         str := '144';
      b430:
         str := '43';
      b1200:
         str := '12';
      b2400:
         str := '24';
      b5600:
         str := '56';
      b10g:
         str := '10';
   end;
   FreqEdit.Text := str;
   CallsignEdit.Text := aQSO.CallSign;
   CommentEdit.Text := '';
end;

procedure TSpotForm.CancelButtonClick(Sender: TObject);
begin
   Close;
end;

procedure TSpotForm.SendButtonClick(Sender: TObject);
var
   sendstr: string;
begin
   sendstr := 'DX ' + FreqEdit.Text + ' ' + CallsignEdit.Text + ' ' + CommentEdit.Text;
   // CommForm.WriteLine(sendstr);
   MainForm.CommForm.TransmitSpot(sendstr);
   Close;
end;

end.

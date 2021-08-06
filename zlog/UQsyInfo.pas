unit UQsyInfo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls;

type
  TformQsyInfo = class(TForm)
    Panel1: TPanel;
    procedure FormCreate(Sender: TObject);
  private
    { Private êÈåæ }
  public
    { Public êÈåæ }
    procedure SetQsyInfo(qsyok: Boolean; S: string);
  end;


implementation

{$R *.dfm}

procedure TformQsyInfo.FormCreate(Sender: TObject);
begin
   Panel1.Color := clBtnFace;
   Panel1.Font.Color := clWindow;
   Panel1.Caption := '';
end;

procedure TformQsyInfo.SetQsyInfo(qsyok: Boolean; S: string);
begin
   if S = '' then begin
      Panel1.Color := clBtnFace;
      Panel1.Font.Color := clWindow;
   end
   else begin
      if qsyok = True then begin
         Panel1.Color := clLime;
         Panel1.Font.Color := clBlue;
      end
      else begin
         Panel1.Color := clYellow;
         Panel1.Font.Color := clRed;
      end;

      if Visible = False then begin
         Show();
      end;
   end;
   Panel1.Caption := S;
end;

end.

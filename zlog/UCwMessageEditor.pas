unit UCwMessageEditor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UTextEditor, System.Actions,
  Vcl.ActnList, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TCwMessageEditor = class(TTextEditor)
    procedure buttonOKClick(Sender: TObject);
    procedure Memo1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private 宣言 }
    function IsValidChar(strMessage: string): Boolean;
  public
    { Public 宣言 }
  end;

implementation

{$R *.dfm}

procedure TCwMessageEditor.buttonOKClick(Sender: TObject);
var
   i: Integer;
   strLine: string;

   procedure SelText(strSel: string);
   var
      p: Integer;
   begin
      p := Pos(strSel, Memo1.Text);
      if (p > 0) then begin
         Memo1.SelStart := p - 1;
         Memo1.SelLength := Length(strSel);
      end;
      Memo1.SetFocus();
   end;
begin
   inherited;

   for i := 0 to Memo1.Lines.Count - 1 do begin
      strLine := Memo1.Lines[i];
      if strLine[1] = Chr($09) then begin
         strLine := Copy(strLine, 2);
         if IsValidChar(strLine) = False then begin
            Application.MessageBox(PChar('使えない文字があります. 使用できる文字は A-Z,0-9,$,/,? です.'), PChar(Application.Title), MB_OK or MB_ICONEXCLAMATION);
            SelText(strLine);
            ModalResult := mrNone;
            Exit;
         end;

         if Length(strLine) > 100 then begin
            Application.MessageBox(PChar('メッセージが長すぎます。100文字以内にして下さい.'), PChar(Application.Title), MB_OK or MB_ICONEXCLAMATION);
            SelText(strLine);
            ModalResult := mrNone;
            Exit;
         end;
      end;
   end;

   ModalResult := mrOK;
end;

function TCwMessageEditor.IsValidChar(strMessage: string): Boolean;
var
   i: Integer;
   ch: Char;
begin
   for i := 1 to Length(strMessage) do begin
      ch := strMessage[i];
      if CharInSet(ch, ['A'..'Z', '0'..'9', '$', '/', '?', '[', ']', '~', ' ']) = False then begin
         Result := False;
         Exit;
      end;
   end;

   Result := True;
end;

procedure TCwMessageEditor.Memo1KeyPress(Sender: TObject; var Key: Char);
begin
   inherited;
   if CharInSet(Key, ['a'..'z']) = True then begin
      Key := UpCase(Key);
   end;
end;

end.

unit UConsolePad;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TConsolePad = class(TForm)
    ListBox: TListBox;
    Panel1: TPanel;
    Edit: TEdit;
    procedure FormShow(Sender: TObject);
    procedure EditKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure CreateParams(var Params: TCreateParams); override;
  private
    { Private declarations }
  public
    { Public declarations }
    MaxLines : integer;
    procedure AddLine(S : string); virtual;
  end;

implementation

uses Main;

{$R *.DFM}

procedure TConsolePad.CreateParams(var Params: TCreateParams);
begin
   inherited CreateParams(Params);
   Params.ExStyle := Params.ExStyle or WS_EX_APPWINDOW;
end;

procedure TConsolePad.FormShow(Sender: TObject);
begin
   Left := MainForm.Left + 30;
   Top := MainForm.Top + MainForm.Height - 150;
   Edit.SetFocus;
end;

procedure TConsolePad.EditKeyPress(Sender: TObject; var Key: Char);
var
   str: string;
begin
   case Key of
      Chr($0D): begin
         str := Edit.Text;
         if str <> '' then
            if str[1] <> ',' then
               str := ',' + str;
         Edit.Text := '';
         MainForm.ProcessConsoleCommand(str);
         Key := #0;
      end;

      Chr($1B): begin
         MainForm.SetLastFocus();
         Key := #0;
      end;
   end;
end;

procedure TConsolePad.AddLine(S: string);
var
   _VisRows, _TopRow: integer;
begin
   if ListBox.Items.Count > MaxLines then
      ListBox.Items.Delete(0);
   ListBox.Items.Add(S);

   _VisRows := ListBox.ClientHeight div ListBox.ItemHeight;
   _TopRow := ListBox.Items.Count - _VisRows + 1;
   if _TopRow > 0 then
      ListBox.TopIndex := _TopRow
   else
      ListBox.TopIndex := 0;
end;

procedure TConsolePad.FormCreate(Sender: TObject);
begin
   MaxLines := 10;
end;

end.

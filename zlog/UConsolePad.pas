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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    MaxLines : integer;
    procedure AddLine(S : string); virtual;
  end;

implementation

uses
  Main;

{$R *.DFM}

procedure TConsolePad.FormShow(Sender: TObject);
begin
   if MainForm.TaskbarList <> nil then begin
      MainForm.TaskBarList.AddTab(Self.Handle);
      MainForm.TaskBarList.ActivateTab(Self.Handle);
   end;

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

procedure TConsolePad.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if MainForm.TaskBarList <> nil then begin
      MainForm.TaskBarList.DeleteTab(Self.Handle);
   end;
end;

procedure TConsolePad.FormCreate(Sender: TObject);
begin
   MaxLines := 10;
end;

end.

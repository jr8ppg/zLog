unit UScratchSheet;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UConsolePad, StdCtrls, ExtCtrls, Menus;

type
  TScratchSheet = class(TConsolePad)
    PopupMenu: TPopupMenu;
    LocalOnly: TMenuItem;
    Clear1: TMenuItem;
    procedure EditKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure LocalOnlyClick(Sender: TObject);
    procedure Clear1Click(Sender: TObject);
  private
    { Private declarations }
    Buffer : TStringList;
  public
    procedure AddBuffer(S : string);
    procedure AddLine(S : string); override;
    procedure UpdateData;
    { Public declarations }
  end;

var
  ScratchSheet: TScratchSheet;

implementation

uses Main, UZLinkForm;

{$R *.DFM}

procedure TScratchSheet.AddBuffer(S : string);
begin
  Buffer.Add(S);
end;

procedure TScratchSheet.EditKeyPress(Sender: TObject; var Key: Char);
begin
  case Key of
    Chr($0D) :
      begin
        //AddLine(Edit.Text);
        Buffer.Add('&'+Edit.Text);
        ZLinkForm.SendScratchMessage(Edit.Text);
        UpdateData;
        Edit.Text := '';
        //MainForm.ProcessConsoleCommand(str);
        Key := #0;
      end;
    Chr($1B) :
      begin
        MainForm.LastFocus.SetFocus;
        Key := #0;
      end;
  end;

end;

procedure TScratchSheet.AddLine(S : string);
//var _VisRows, _TopRow : integer;
begin
  inherited;
end;


procedure TScratchSheet.FormCreate(Sender: TObject);
begin
  inherited;
  MaxLines := 25;
  Buffer := TStringList.Create;
end;

procedure TScratchSheet.UpdateData;
var i, _VisRows, _TopRow : integer;
    str : string;
    count : integer;
begin
  ListBox.Clear;
  count := 0;
  for i := Buffer.Count - 1 downto 0 do
    begin
      str := Buffer[i];
      if LocalOnly.Checked then
        begin
          if str <> '' then
            if str[1] = '&' then
              begin
                Delete(str, 1, 1);
                inc(count);
                ListBox.Items.Insert(0,str);
              end;
        end
      else
        begin
          if str <> '' then
            if str[1] = '&' then
              Delete(str, 1, 1);
          ListBox.Items.Insert(0,str);
          inc(count);
        end;
      if count >= MaxLines then
        break;
    end;

  _VisRows := ListBox.ClientHeight div ListBox.ItemHeight;
  _TopRow := ListBox.Items.Count - _VisRows + 1;
  if _TopRow > 0 then
    ListBox.TopIndex := _TopRow
  else
    ListBox.TopIndex := 0;

end;

procedure TScratchSheet.LocalOnlyClick(Sender: TObject);
begin
  //inherited;
  LocalOnly.Checked := Not(LocalOnly.Checked);
  UpdateData;
end;

procedure TScratchSheet.Clear1Click(Sender: TObject);
begin
  inherited;
  Buffer.Clear;
  UpdateData;
end;

end.

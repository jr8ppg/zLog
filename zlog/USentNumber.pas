unit USentNumber;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  UzLogForm, Vcl.Menus, System.IniFiles, System.UITypes;

type
  TformSentNumber = class(TzLogForm)
    panelSentNumber: TPanel;
    Panel1: TPanel;
    StayOnTop: TCheckBox;
    PopupMenu1: TPopupMenu;
    menuFont: TMenuItem;
    FontDialog1: TFontDialog;
    procedure StayOnTopClick(Sender: TObject);
    procedure menuFontClick(Sender: TObject);
  private
    { Private êÈåæ }
    function GetSentNumber(): string;
    procedure SetSentNumber(v: string);
  public
    { Public êÈåæ }
    property SentNumber: string read GetSentNumber write SetSentNumber;
    procedure SaveSettings(ini: TMemIniFile);
    procedure LoadSettings(ini: TMemIniFile);
  end;

implementation

{$R *.dfm}

uses
  UzLogGlobal;

procedure TformSentNumber.StayOnTopClick(Sender: TObject);
begin
   if StayOnTop.Checked then begin
      FormStyle := fsStayOnTop;
   end
   else begin
      FormStyle := fsNormal;
   end;
end;

procedure TformSentNumber.menuFontClick(Sender: TObject);
begin
   FontDialog1.Font := panelSentNumber.Font;

   if FontDialog1.Execute(Handle) = False then begin
      Exit;
   end;

   panelSentNumber.Font := FontDialog1.Font;
end;

function TformSentNumber.GetSentNumber(): string;
begin
   Result := panelSentNumber.Caption;
end;

procedure TformSentNumber.SetSentNumber(v: string);
begin
   panelSentNumber.Caption := v;
end;

procedure TformSentNumber.SaveSettings(ini: TMemIniFile);
var
   section: string;
begin
   section := Self.Name;
   dmZLogGlobal.WriteWindowState(ini, Self, section);

   ini.WriteString(section, 'FontFace', panelSentNumber.Font.Name);
   ini.WriteInteger(section, 'FontSize', panelSentNumber.Font.Size);
   ini.WriteBool(section, 'FontBold', panelSentNumber.Font.Style = [fsBold]);
   ini.WriteBool(section, 'FontItalic', panelSentNumber.Font.Style = [fsItalic]);
   ini.WriteBool(section, 'FontUnderline', panelSentNumber.Font.Style = [fsUnderLine]);
   ini.WriteBool(section, 'FontStrikeOut', panelSentNumber.Font.Style = [fsStrikeOut]);
   ini.WriteInteger(section, 'FontColor', panelSentNumber.Font.Color);
end;

procedure TformSentNumber.LoadSettings(ini: TMemIniFile);
var
   section: string;
begin
   section := Self.Name;

   dmZLogGlobal.ReadWindowState(ini, Self, section);

   panelSentNumber.Font.Name := ini.ReadString(section, 'FontFace', 'ÇlÇr ÇoÉSÉVÉbÉN');
   panelSentNumber.Font.Size := ini.ReadInteger(section, 'FontSize', 24);
   if ini.ReadBool(section, 'FontBold', False) = True then begin
      panelSentNumber.Font.Style := panelSentNumber.Font.Style + [fsBold];
   end;
   if ini.ReadBool(section, 'FontItalic', False) = True then begin
      panelSentNumber.Font.Style := panelSentNumber.Font.Style + [fsItalic];
   end;
   if ini.ReadBool(section, 'FontUnderline', False) = True then begin
      panelSentNumber.Font.Style := panelSentNumber.Font.Style + [fsUnderline];
   end;
   if ini.ReadBool(section, 'FontStrikeOut', False) = True then begin
      panelSentNumber.Font.Style := panelSentNumber.Font.Style + [fsStrikeOut];
   end;
   panelSentNumber.Font.Color := ini.ReadInteger(section, 'FontColor', 0);
end;

end.

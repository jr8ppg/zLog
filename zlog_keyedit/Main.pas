unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.ValEdit, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Menus, System.IniFiles, System.StrUtils;

type
  TformMain = class(TForm)
    PageControl1: TPageControl;
    Panel1: TPanel;
    buttonOK: TButton;
    buttonCancel: TButton;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    vleLogging: TValueListEditor;
    vleCWKeying: TValueListEditor;
    vleRigControl: TValueListEditor;
    vleInformation: TValueListEditor;
    vleEdit: TValueListEditor;
    vlePostContest: TValueListEditor;
    vleOther: TValueListEditor;
    buttonAllReset: TButton;
    TabSheet8: TTabSheet;
    vleSo2r: TValueListEditor;
    procedure vleDblClick(Sender: TObject);
    procedure buttonOKClick(Sender: TObject);
    procedure buttonCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure buttonAllResetClick(Sender: TObject);
  private
    { Private 宣言 }
    function IsShortcutUsed(strKey: string; var strFuncName: string): Boolean;
    procedure ClearKeymap(strFuncName: string);
    procedure ReadKeymap(ini: TIniFile; vle: TValueListEditor);
    procedure WriteKeymap(ini: TIniFile; vle: TValueListEditor);
    procedure ResetKeymap(vle: TValueListEditor);
    procedure ResetKeymapAll();
    procedure CreateHelpFile();
    procedure CreateHelp2(SL: TStringList; strTitle: string; vle: TValueListEditor);
  public
    { Public 宣言 }
  end;

var
  formMain: TformMain;

implementation

{$R *.dfm}

uses
  KeyEditDlg, UzLogConst;

procedure TformMain.FormCreate(Sender: TObject);
var
   ini: TIniFile;
   filename: string;
begin
   PageControl1.ActivePageIndex := 0;

   filename := ExtractFilePath(Application.ExeName) + 'zlog_key.ini';
   if FileExists(filename) = False then begin
      ResetKeymapAll();
      Exit;
   end;

   ini := TIniFile.Create(filename);
   try
      ReadKeymap(ini, vleLogging);
      ReadKeymap(ini, vleInformation);
      ReadKeymap(ini, vleCwKeying);
      ReadKeymap(ini, vleRigControl);
      ReadKeymap(ini, vleEdit);
      ReadKeymap(ini, vlePostContest);
      ReadKeymap(ini, vleOther);
      ReadKeymap(ini, vleSo2r);
   finally
      ini.Free();
   end;
end;

procedure TformMain.vleDblClick(Sender: TObject);
var
   dlg: TformKeyEditDlg;
   R: Integer;
   strKey: string;
   strKeyBackup: string;
   strFuncName: string;
   slText: TStringList;
begin
   slText := TStringList.Create();
   slText.StrictDelimiter := True;
   dlg := TformKeyEditDlg.Create(Self);
   try
      R := TValueListEditor(Sender).Row;

      strKeyBackup := TValueListEditor(Sender).Cells[1, R];
      slText.CommaText := strKeyBackup + ',,';

      TValueListEditor(Sender).Cells[1, R] := '';
      dlg.PrimaryKey := slText.Strings[0];
      dlg.SecondaryKey := slText.Strings[1];
      dlg.DispText := slText.Strings[2];

      if dlg.ShowModal() <> mrOK then begin
         TValueListEditor(Sender).Cells[1, R] := strKeyBackup;
         Exit;
      end;

      strKey := dlg.PrimaryKey;

      if (strKey <> '') and (IsShortcutUsed(strKey, strFuncName) = True) then begin
         if MessageBox(Handle, PChar(strKey + ' キーは既に ' + strFuncName + ' で使用されています。横取りしますか？'), PChar(Application.Title), MB_YESNO or MB_DEFBUTTON2 or MB_ICONEXCLAMATION) = IDNO then begin
            TValueListEditor(Sender).Cells[1, R] := strKeyBackup;
            Exit;
         end;

         ClearKeymap(strFuncName);
      end;

      TValueListEditor(Sender).Cells[1, R] := strKey + ',' + dlg.SecondaryKey + ',' + dlg.DispText;
   finally
      dlg.Release();
      slText.Free();
   end;
end;

procedure TformMain.buttonOKClick(Sender: TObject);
var
   ini: TIniFile;
begin
   ini := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'zlog_key.ini');
   try
      WriteKeymap(ini, vleLogging);
      WriteKeymap(ini, vleInformation);
      WriteKeymap(ini, vleCwKeying);
      WriteKeymap(ini, vleRigControl);
      WriteKeymap(ini, vleEdit);
      WriteKeymap(ini, vlePostContest);
      WriteKeymap(ini, vleOther);
      WriteKeymap(ini, vleSo2r);

      CreateHelpFile();

      Close();
   finally
      ini.Free();
   end;
end;

procedure TformMain.buttonCancelClick(Sender: TObject);
begin
   Close();
end;

procedure TformMain.buttonAllResetClick(Sender: TObject);
begin
   if MessageBox(Handle, PChar('全ての設定を初期値に戻します。よろしいですか？'), PChar(Application.Title), MB_YESNO or MB_DEFBUTTON2 or MB_ICONEXCLAMATION) = IDNO then begin
      Exit;
   end;

   ResetKeymapAll();
end;

function TformMain.IsShortcutUsed(strKey: string; var strFuncName: string): Boolean;
var
   i: Integer;
   sl: TStringList;
begin
   sl := TStringList.Create();
   try
      for i := 1 to vleLogging.RowCount - 1 do begin
         sl.CommaText := vleLogging.Cells[1, i] + ',';
         if sl[0] = strKey then begin
            strFuncName := vleLogging.Cells[0, i];
            Result := True;
            Exit;
         end;
      end;

      for i := 1 to vleInformation.RowCount - 1 do begin
         sl.CommaText := vleInformation.Cells[1, i] + ',';
         if sl[0] = strKey then begin
            strFuncName := vleInformation.Cells[0, i];
            Result := True;
            Exit;
         end;
      end;

      for i := 1 to vleCwKeying.RowCount - 1 do begin
         sl.CommaText := vleCwKeying.Cells[1, i] + ',';
         if sl[0] = strKey then begin
            strFuncName := vleCwKeying.Cells[0, i];
            Result := True;
            Exit;
         end;
      end;

      for i := 1 to vleRigControl.RowCount - 1 do begin
         sl.CommaText := vleRigControl.Cells[1, i] + ',';
         if sl[0] = strKey then begin
            strFuncName := vleRigControl.Cells[0, i];
            Result := True;
            Exit;
         end;
      end;

      for i := 1 to vleEdit.RowCount - 1 do begin
         sl.CommaText := vleEdit.Cells[1, i] + ',';
         if sl[0] = strKey then begin
            strFuncName := vleEdit.Cells[0, i];
            Result := True;
            Exit;
         end;
      end;

      for i := 1 to vlePostContest.RowCount - 1 do begin
         sl.CommaText := vlePostContest.Cells[1, i] + ',';
         if sl[0] = strKey then begin
            strFuncName := vlePostContest.Cells[0, i];
            Result := True;
            Exit;
         end;
      end;

      for i := 1 to vleOther.RowCount - 1 do begin
         sl.CommaText := vleOther.Cells[1, i] + ',';
         if sl[0] = strKey then begin
            strFuncName := vleOther.Cells[0, i];
            Result := True;
            Exit;
         end;
      end;

      for i := 1 to vleSo2r.RowCount - 1 do begin
         sl.CommaText := vleSo2r.Cells[1, i] + ',';
         if sl[0] = strKey then begin
            strFuncName := vleSo2r.Cells[0, i];
            Result := True;
            Exit;
         end;
      end;

      strFuncName := '';
      Result := False;
   finally
      sl.Free();
   end;
end;

procedure TformMain.ClearKeymap(strFuncName: string);
var
   i: Integer;
begin
   for i := 1 to vleLogging.RowCount - 1 do begin
      if vleLogging.Cells[0, i] = strFuncName then begin
         vleLogging.Cells[1, i] := '';
         Exit;
      end;
   end;

   for i := 1 to vleInformation.RowCount - 1 do begin
      if vleInformation.Cells[0, i] = strFuncName then begin
         vleInformation.Cells[1, i] := '';
         Exit;
      end;
   end;

   for i := 1 to vleCwKeying.RowCount - 1 do begin
      if vleCwKeying.Cells[0, i] = strFuncName then begin
         vleCwKeying.Cells[1, i] := '';
         Exit;
      end;
   end;

   for i := 1 to vleRigControl.RowCount - 1 do begin
      if vleRigControl.Cells[0, i] = strFuncName then begin
         vleRigControl.Cells[1, i] := '';
         Exit;
      end;
   end;

   for i := 1 to vleEdit.RowCount - 1 do begin
      if vleEdit.Cells[0, i] = strFuncName then begin
         vleEdit.Cells[1, i] := '';
         Exit;
      end;
   end;

   for i := 1 to vlePostContest.RowCount - 1 do begin
      if vlePostContest.Cells[0, i] = strFuncName then begin
         vlePostContest.Cells[1, i] := '';
         Exit;
      end;
   end;

   for i := 1 to vleOther.RowCount - 1 do begin
      if vleOther.Cells[0, i] = strFuncName then begin
         vleOther.Cells[1, i] := '';
         Exit;
      end;
   end;

   for i := 1 to vleSo2r.RowCount - 1 do begin
      if vleSo2r.Cells[0, i] = strFuncName then begin
         vleSo2r.Cells[1, i] := '';
         Exit;
      end;
   end;
end;

procedure TformMain.ReadKeymap(ini: TIniFile; vle: TValueListEditor);
var
   i: Integer;
   N: Integer;
begin
   for i := 1 to vle.RowCount - 1 do begin
      N := StrToIntDef(Copy(vle.Cells[0, i], 2, 3), -1);
      if N = -1 then begin
         Continue;
      end;

      vle.Cells[1, i] := ini.ReadString('shortcut', IntToStr(N), default_primary_shortcut[N]) +
                         ',' +
                         ini.ReadString('secondary', IntToStr(N), default_secondary_shortcut[N]) +
                         ',' +
                         ini.ReadString('text', IntToStr(N), '');
   end;
end;

procedure TformMain.WriteKeymap(ini: TIniFile; vle: TValueListEditor);
var
   i: Integer;
   N: Integer;
   slText: TStringList;
begin
   slText := TStringList.Create();
   slText.StrictDelimiter := True;
   try
      for i := 1 to vle.RowCount - 1 do begin
         N := StrToIntDef(Copy(vle.Cells[0, i], 2, 3), -1);
         if N = -1 then begin
            Continue;
         end;

         slText.CommaText := vle.Cells[1, i] + ',,';
         ini.WriteString('shortcut', IntToStr(N), slText[0]);
         ini.WriteString('secondary', IntToStr(N), slText[1]);
         if slText[2] <> '' then begin
            ini.WriteString('text', IntToStr(N), slText[2]);
         end;
      end;
   finally
      slText.Free();
   end;
end;

procedure TformMain.ResetKeymap(vle: TValueListEditor);
var
   i: Integer;
   N: Integer;
begin
   for i := 1 to vle.RowCount - 1 do begin
      N := StrToIntDef(Copy(vle.Cells[0, i], 2, 3), -1);
      if N = -1 then begin
         Continue;
      end;

      vle.Cells[1, i] := default_primary_shortcut[N] +
                         ',' +
                         default_secondary_shortcut[N];
   end;
end;

procedure TformMain.ResetKeymapAll();
begin
   ResetKeymap(vleLogging);
   ResetKeymap(vleInformation);
   ResetKeymap(vleCwKeying);
   ResetKeymap(vleRigControl);
   ResetKeymap(vleEdit);
   ResetKeymap(vlePostContest);
   ResetKeymap(vleOther);
   ResetKeymap(vleSo2r);
end;

procedure TformMain.CreateHelpFile();
var
   SL: TStringList;
begin
   SL := TStringList.Create();
   try
      CreateHelp2(SL, TabSheet1.Caption, vleLogging);
      CreateHelp2(SL, TabSheet2.Caption, vleInformation);
      CreateHelp2(SL, TabSheet3.Caption, vleCwKeying);
      CreateHelp2(SL, TabSheet4.Caption, vleRigControl);
      CreateHelp2(SL, TabSheet5.Caption, vleEdit);
      CreateHelp2(SL, TabSheet6.Caption, vlePostContest);
      CreateHelp2(SL, TabSheet7.Caption, vleOther);
      CreateHelp2(SL, TabSheet8.Caption, vleSo2r);

      SL.SaveToFile(ExtractFilePath(Application.ExeName) + '\ZLOGHELP.TXT');
   finally
      SL.Free();
   end;
end;

// 01234567890
// 入力と編集に関するキー操作
// --------------------------
// Alt+C    コールサインフィールドに移動
procedure TformMain.CreateHelp2(SL: TStringList; strTitle: string; vle: TValueListEditor);
var
   i: Integer;
   N: Integer;
   slText: TStringList;
   strText: string;
   strSjis: AnsiString;
begin
   slText := TStringList.Create();
   try
      strText := strTitle + 'に関するキー操作';
      SL.Add(strText);

      strSjis := AnsiString(strText);
      strText := DupeString('-', Length(strSjis));
      SL.Add(strText);

      for i := 1 to vle.RowCount - 1 do begin
         N := StrToIntDef(Copy(vle.Cells[0, i], 2, 3), -1);
         if N = -1 then begin
            Continue;
         end;

         slText.CommaText := vle.Cells[1, i] + ',';

         if Trim(slText[0]) = '' then begin
            Continue;
         end;

         strText := slText[0];
         strText := strText + DupeString(' ', 10);
         strText := LeftStr(strText, 10);
         strText := strText + Copy(vle.Cells[0, i], 5);
         SL.Add(strText);
      end;

      SL.Add('');
   finally
      slText.Free();
   end;
end;

end.

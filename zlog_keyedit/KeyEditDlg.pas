unit KeyEditDlg;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TformKeyEditDlg = class(TForm)
    GroupBox1: TGroupBox;
    checkFuncAndCtrl: TCheckBox;
    checkFuncAndShift: TCheckBox;
    checkFuncAndAlt: TCheckBox;
    comboFunctionKey: TComboBox;
    GroupBox2: TGroupBox;
    comboAlphabetKey: TComboBox;
    checkAlphabetAndCtrl: TCheckBox;
    checkAlphabetAndAlt: TCheckBox;
    GroupBox3: TGroupBox;
    comboOtherKey: TComboBox;
    buttonOK: TButton;
    buttonCancel: TButton;
    GroupBox4: TGroupBox;
    radioSecondary0: TRadioButton;
    radioSecondary1: TRadioButton;
    radioSecondary2: TRadioButton;
    radioSecondary3: TRadioButton;
    radioSecondary4: TRadioButton;
    radioSecondary5: TRadioButton;
    radioSecondary6: TRadioButton;
    checkAlphabetAndShift: TCheckBox;
    procedure buttonOKClick(Sender: TObject);
    procedure comboFunctionKeyClick(Sender: TObject);
    procedure comboAlphabetKeyClick(Sender: TObject);
    procedure comboOtherKeyClick(Sender: TObject);
  private
    { Private 宣言 }
    procedure SetPrimaryKey(v: string);
    function GetPrimaryKey(): string;
    procedure SetSecondaryKey(v: string);
    function GetSecondaryKey(): string;
  public
    { Public 宣言 }
    property PrimaryKey: string read GetPrimaryKey write SetPrimaryKey;
    property Secondarykey: string read GetSecondaryKey write SetSecondaryKey;
  end;

implementation

{$R *.dfm}

procedure TformKeyEditDlg.buttonOKClick(Sender: TObject);
begin
   if comboAlphabetKey.ItemIndex >= 0 then begin
      if (checkAlphabetAndCtrl.Checked = False) and
         (checkAlphabetAndShift.Checked = True) and
         (checkAlphabetAndAlt.Checked = False) then begin
         MessageBox(Handle, PChar('A～ZキーはShiftキーのみとは組み合わせできません'), PChar(Application.Title), MB_OK or MB_ICONEXCLAMATION);
         Exit;
      end;
   end;

   ModalResult := mrOK
end;

procedure TformKeyEditDlg.SetPrimaryKey(v: string);
var
   sl: TStringList;
   i: Integer;
   fCtrl: Boolean;
   fShift: Boolean;
   fAlt: Boolean;
   Index: Integer;
begin
   sl := TStringList.Create();
   sl.Delimiter := '+';
   try
      fCtrl := False;
      fShift := False;
      fAlt := False;
      sl.DelimitedText := v;
      for i := 0 to sl.Count - 1 do begin
         if sl[i] = 'Ctrl' then begin
            fCtrl := True;
         end
         else if sl[i] = 'Shift' then begin
            fShift := True;
         end
         else if sl[i] = 'Alt' then begin
            fAlt := True;
         end
         else begin
            Index := comboFunctionKey.Items.IndexOf(sl[i]);
            if Index <= 0 then begin
               comboFunctionKey.ItemIndex := 0;
            end
            else begin
               comboFunctionKey.ItemIndex := Index;
            end;

            Index := comboAlphabetKey.Items.IndexOf(sl[i]);
            if Index <= 0 then begin
               comboAlphabetKey.ItemIndex := 0;
            end
            else begin
               comboAlphabetKey.ItemIndex := Index;
            end;

            Index := comboOtherKey.Items.IndexOf(sl[i]);
            if Index <= 0 then begin
               comboOtherKey.ItemIndex := 0;
            end
            else begin
               comboOtherKey.ItemIndex := Index;
            end;
         end;
      end;

      if comboFunctionKey.ItemIndex > 0 then begin
         if fCtrl = True then begin
            checkFuncAndCtrl.Checked := True;
         end;
         if fShift = True then begin
            checkFuncAndShift.Checked := True;
         end;
         if fAlt = True then begin
            checkFuncAndAlt.Checked := True;
         end;
      end;

      if comboAlphabetKey.ItemIndex > 0 then begin
         if fCtrl = True then begin
            checkAlphabetAndCtrl.Checked := True;
         end;
         if fShift = True then begin
            checkAlphabetAndShift.Checked := True;
         end;
         if fAlt = True then begin
            checkAlphabetAndAlt.Checked := True;
         end;
      end;
   finally
      sl.Free();
   end;
end;

procedure TformKeyEditDlg.comboFunctionKeyClick(Sender: TObject);
begin
   if TComboBox(Sender).ItemIndex > 0 then begin
      comboAlphabetKey.ItemIndex := 0;
      comboOtherKey.ItemIndex := 0;
   end;
end;

procedure TformKeyEditDlg.comboAlphabetKeyClick(Sender: TObject);
begin
   if TComboBox(Sender).ItemIndex > 0 then begin
      comboFunctionKey.ItemIndex := 0;
      comboOtherKey.ItemIndex := 0;
   end;
end;

procedure TformKeyEditDlg.comboOtherKeyClick(Sender: TObject);
begin
   if TComboBox(Sender).ItemIndex > 0 then begin
      comboFunctionKey.ItemIndex := 0;
      comboAlphabetKey.ItemIndex := 0;
   end;
end;

function TformKeyEditDlg.GetPrimaryKey(): string;
var
   sl: TStringList;
begin
   sl := TStringList.Create();
   sl.Delimiter := '+';
   try
      if comboFunctionKey.ItemIndex > 0 then begin
         if checkFuncAndCtrl.Checked = True then begin
            sl.Add('Ctrl');
         end;
         if checkFuncAndShift.Checked = True then begin
            sl.Add('Shift');
         end;
         if checkFuncAndAlt.Checked = True then begin
            sl.Add('Alt');
         end;
         sl.Add(comboFunctionKey.Items[comboFunctionKey.ItemIndex]);
      end
      else if comboAlphabetKey.ItemIndex > 0 then begin
         if checkAlphabetAndCtrl.Checked = True then begin
            sl.Add('Ctrl');
         end;
         if checkAlphabetAndShift.Checked = True then begin
            sl.Add('Shift');
         end;
         if checkAlphabetAndAlt.Checked = True then begin
            sl.Add('Alt');
         end;
         sl.Add(comboAlphabetKey.Items[comboAlphabetKey.ItemIndex]);
      end
      else if comboOtherKey.ItemIndex > 0 then begin
         sl.Add(comboOtherKey.Items[comboOtherKey.ItemIndex]);
      end;

      Result := sl.DelimitedText;
   finally
      sl.Free();
   end;
end;

procedure TformKeyEditDlg.SetSecondaryKey(v: string);
begin
   if v = ';' then begin
      radioSecondary1.Checked := True;
   end
   else if v = ':' then begin
      radioSecondary2.Checked := True;
   end
   else if v = '@' then begin
      radioSecondary3.Checked := True;
   end
   else if v = '[' then begin
      radioSecondary4.Checked := True;
   end
   else if v = ']' then begin
      radioSecondary5.Checked := True;
   end
   else if v = '\' then begin
      radioSecondary6.Checked := True;
   end
   else begin
      radioSecondary0.Checked := True;
   end;
end;

function TformKeyEditDlg.GetSecondaryKey(): string;
begin
   if radioSecondary1.Checked = True then begin
      Result := ';';
   end
   else if radioSecondary2.Checked = True then begin
      Result := ':';
   end
   else if radioSecondary3.Checked = True then begin
      Result := '@';
   end
   else if radioSecondary4.Checked = True then begin
      Result := '[';
   end
   else if radioSecondary5.Checked = True then begin
      Result := ']';
   end
   else if radioSecondary6.Checked = True then begin
      Result := '\';
   end
   else begin
      Result := '';
   end;
end;

end.

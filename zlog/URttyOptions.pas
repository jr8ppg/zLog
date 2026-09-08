unit URttyOptions;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls,
  System.UITypes, UzColorCoding;

type
  TformRttyOptions = class(TForm)
    Panel1: TPanel;
    buttonOK: TButton;
    buttonCancel: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    groupDefaultColor: TGroupBox;
    radioNormal: TRadioButton;
    radioDark: TRadioButton;
    radioGreen: TRadioButton;
    radioAmber: TRadioButton;
    groupColorCoding: TGroupBox;
    editCCSample: TEdit;
    buttonCCFgColor: TButton;
    checkCCBold: TCheckBox;
    checkCCItalic: TCheckBox;
    editCCKeyword: TEdit;
    buttonCCAdd: TButton;
    buttonCCEdit: TButton;
    groupColorCodingList: TGroupBox;
    buttonCCDelete: TButton;
    listColorCoding: TListBox;
    ColorDialog1: TColorDialog;
    editConsoleSample: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure checkCCBoldClick(Sender: TObject);
    procedure checkCCItalicClick(Sender: TObject);
    procedure buttonCCFgColorClick(Sender: TObject);
    procedure buttonCCBgColorClick(Sender: TObject);
    procedure radioNormalClick(Sender: TObject);
    procedure radioDarkClick(Sender: TObject);
    procedure radioGreenClick(Sender: TObject);
    procedure radioAmberClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure buttonCCAddClick(Sender: TObject);
    procedure buttonCCEditClick(Sender: TObject);
    procedure buttonCCDeleteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure listColorCodingClick(Sender: TObject);
    procedure editCCKeywordChange(Sender: TObject);
    procedure listColorCodingDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
  private
    { Private 宣言 }
    FColorCodingList: TColorCodingList;
    procedure ShowColorCodingList();
    procedure SetBackColor(COL: TColor);
    function GetDefaultColor(): Integer;
    procedure SetDefaultColor(v: Integer);
    function GetBackColor(): TColor;
    function GetForeColor(): TColor;
  public
    { Public 宣言 }
    property DefaultColor: Integer read GetDefaultColor write SetDefaultColor;
    property BackColor: TColor read GetBackColor;
    property ForeColor: TColor read GetForeColor;
    property ColorCodingList: TColorCodingList read FColorCodingList;
  end;

implementation

{$R *.dfm}

procedure TformRttyOptions.FormCreate(Sender: TObject);
begin
   FColorCodingList := TColorCodingList.Create();
end;

procedure TformRttyOptions.FormDestroy(Sender: TObject);
begin
   FColorCodingList.Free();
end;

procedure TformRttyOptions.FormShow(Sender: TObject);
begin
   if radioNormal.Checked then begin
      radioNormalClick(nil);
   end;
   if radioDark.Checked then begin
      radioDarkClick(nil);
   end;
   if radioGreen.Checked then begin
      radioGreenClick(nil);
   end;
   if radioAmber.Checked then begin
      radioAmberClick(nil);
   end;

   editCCKeywordChange(nil);
   checkCCBoldClick(nil);
   checkCCItalicClick(nil);

   ShowColorCodingList();
end;

procedure TformRttyOptions.editCCKeywordChange(Sender: TObject);
begin
   if editCCKeyword.Text = '' then begin
      buttonCCAdd.Enabled := False;
   end
   else begin
      buttonCCAdd.Enabled := True;
   end;
end;

procedure TformRttyOptions.buttonCCFgColorClick(Sender: TObject);
begin
   ColorDialog1.Color := editCCKeyword.Font.Color;
   if ColorDialog1.Execute = True then begin
      editCCSample.Font.Color := ColorDialog1.Color;
   end;
end;

procedure TformRttyOptions.buttonCCBgColorClick(Sender: TObject);
begin
   ColorDialog1.Color := editCCKeyword.Color;
   if ColorDialog1.Execute = True then begin
      editCCSample.Color := ColorDialog1.Color;
   end;
end;

procedure TformRttyOptions.checkCCBoldClick(Sender: TObject);
begin
   if checkCCBold.Checked = True then begin
      editCCSample.Font.Style := editCCSample.Font.Style + [fsBold];
   end
   else begin
      editCCSample.Font.Style := editCCSample.Font.Style - [fsBold];
   end;
end;

procedure TformRttyOptions.checkCCItalicClick(Sender: TObject);
begin
   if checkCCItalic.Checked = True then begin
      editCCSample.Font.Style := editCCSample.Font.Style + [fsItalic];
   end
   else begin
      editCCSample.Font.Style := editCCSample.Font.Style - [fsItalic];
   end;
end;

procedure TformRttyOptions.radioNormalClick(Sender: TObject);
begin
   editConsoleSample.Font.Color := clBlack;
   editConsoleSample.Color := clWhite;
   editCCSample.Font.Color := editConsoleSample.Font.Color;
   SetBackColor(editConsoleSample.Color);
end;

procedure TformRttyOptions.radioDarkClick(Sender: TObject);
begin
   editConsoleSample.Font.Color := $DCDCDC;
   editConsoleSample.Color := $1E1E1E;
   editCCSample.Font.Color := editConsoleSample.Font.Color;
   SetBackColor(editConsoleSample.Color);
end;

procedure TformRttyOptions.radioGreenClick(Sender: TObject);
begin
   editConsoleSample.Font.Color := $40E040;
   editConsoleSample.Color := $001000;
   editCCSample.Font.Color := editConsoleSample.Font.Color;
   SetBackColor(editConsoleSample.Color);
end;

procedure TformRttyOptions.radioAmberClick(Sender: TObject);
begin
   editConsoleSample.Font.Color := RGB(255, 176, 48);
   editConsoleSample.Color := $160B00;
   editCCSample.Font.Color := editConsoleSample.Font.Color;
   SetBackColor(editConsoleSample.Color);
end;

procedure TformRttyOptions.buttonCCAddClick(Sender: TObject);
var
   CC: TColorCoding;
begin
   CC := FColorCodingList.ObjectOf(editCCKeyword.Text);
   if CC = nil then begin
      CC := TColorCoding.Create();
      CC.Keyword := editCCKeyword.Text;
      CC.ForeColor := editCCSample.Font.Color;
      CC.BackColor := editCCSample.Color;
      CC.Bold := checkCCBold.Checked;
      CC.Italic := checkCCItalic.Checked;
      FColorCodingList.Add(CC);
   end
   else begin
      CC.ForeColor := editCCSample.Font.Color;
      CC.Bold := checkCCBold.Checked;
      CC.Italic := checkCCItalic.Checked;
   end;

   listColorCoding.ItemIndex := -1;
   ShowColorCodingList();

   // 初期値に戻す
   editCCKeyword.Text := '';
   editCCSample.Font.Color := editConsoleSample.FOnt.Color;
   checkCCBold.Checked := False;
   checkCCBoldClick(nil);
   checkCCItalic.Checked := False;
   checkCCItalicClick(nil);
end;

procedure TformRttyOptions.buttonCCEditClick(Sender: TObject);
var
   Index: Integer;
   CC: TColorCoding;
begin
   Index := listColorCoding.ItemIndex;
   if Index = -1 then begin
      Exit;
   end;
   CC := FColorCodingList[Index];
   editCCKeyword.Text := CC.Keyword;
   editCCSample.Font.Color := CC.ForeColor;
   checkCCBold.Checked := CC.Bold;
   checkCCBoldClick(nil);
   checkCCItalic.Checked := CC.Italic;
   checkCCItalicClick(nil);
end;

procedure TformRttyOptions.buttonCCDeleteClick(Sender: TObject);
var
   Index: Integer;
   CC: TColorCoding;
begin
   Index := listColorCoding.ItemIndex;
   if Index = -1 then begin
      Exit;
   end;
//   CC := FColorCodingList[Index];
   FColorCodingList.Delete(Index);
//   CC.Free();
   listColorCoding.ItemIndex := -1;
   ShowColorCodingList();
end;

procedure TformRttyOptions.listColorCodingClick(Sender: TObject);
var
   Index: Integer;
begin
   Index := listColorCoding.ItemIndex;
   if Index = -1 then begin
      buttonCCEdit.Enabled := False;
      buttonCCDelete.Enabled := False;
   end
   else begin
      buttonCCEdit.Enabled := True;
      buttonCCDelete.Enabled := True;
   end;
end;

procedure TformRttyOptions.listColorCodingDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
   CC: TColorCoding;
   L: TListBox;
   fg: TColor;
   bg: TColor;
   fs: TFontStyles;
begin
   L := TListBox(Control);
   CC := TColorCoding(L.Items.Objects[Index]);

   fg := CC.ForeColor;
   bg := CC.BackColor;
   fs := [];
   if CC.Bold then begin
      fs := fs + [fsBold];
   end;
   if CC.Italic then begin
      fs := fs + [fsItalic];
   end;

   with L.Canvas do begin
      Pen.Style := psSolid;
      Pen.Color := bg;
      Pen.Width := 1;
      Brush.Style := bsSolid;
      Brush.Color := bg;
      FillRect(Rect);

      // キーワード描画
      Font.Color := fg;
      Brush.Color := bg;
      Font.Style := fs;
      TextOut(Rect.Left + 2, Rect.Top + 2, CC.Keyword);
   end;
end;

procedure TformRttyOptions.ShowColorCodingList();
var
   i: Integer;
   CC: TColorCoding;
begin
   listColorCoding.Items.Clear();
   for i := 0 to FColorCodingList.Count - 1 do begin
      CC := FColorCodingList[i];
      listColorCoding.Items.AddObject(CC.Keyword, CC);
   end;
end;

procedure TformRttyOptions.SetBackColor(COL: TColor);
var
   i: Integer;
   CC: TColorCoding;
begin
   editCCSample.Color := COL;
   listColorCoding.Color := COL;
   for i := 0 to FColorCodingList.Count - 1 do begin
      CC := FColorCodingList[i];
      CC.BackColor := COL;
   end;
end;

function TformRttyOptions.GetDefaultColor(): Integer;
begin
   if radioNormal.Checked = True then begin
      Result := 0;
   end
   else if radioDark.Checked = True then begin
      Result := 1;
   end
   else if radioGreen.Checked = True then begin
      Result := 2;
   end
   else if radioAmber.Checked = True then begin
      Result := 3;
   end
   else begin
      Result := 0;
   end;
end;

procedure TformRttyOptions.SetDefaultColor(v: Integer);
begin
   case v of
      0: radioNormal.Checked := True;
      1: radioDark.Checked := True;
      2: radioGreen.Checked := True;
      3: radioAmber.Checked := True;
      else radioNormal.Checked := True;
   end;
end;

function TformRttyOptions.GetBackColor(): TColor;
begin
   Result := editConsoleSample.Color;
end;

function TformRttyOptions.GetForeColor(): TColor;
begin
   Result := editConsoleSample.Font.Color;
end;

end.

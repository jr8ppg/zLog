unit UPartials;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, Spin,
  UzLogConst, UzLogGlobal, UzLogQSO, System.ImageList, Vcl.ImgList;

type
  TPartialCheck = class(TForm)
    ListBox: TListBox;
    Panel: TPanel;
    CheckBox1: TCheckBox;
    ShowMaxEdit: TSpinEdit;
    Label1: TLabel;
    SortByGroup: TGroupBox;
    rbTime: TRadioButton;
    rbBand: TRadioButton;
    rbCall: TRadioButton;
    MoreButton: TSpeedButton;
    StayOnTop: TCheckBox;
    panelExtend: TPanel;
    panelBody: TPanel;
    checkShowCurrentBandFirst: TCheckBox;
    ImageList1: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CheckBox1Click(Sender: TObject);
    procedure MoreButtonClick(Sender: TObject);
    procedure ShowMaxEditChange(Sender: TObject);
    procedure rbSortClick(Sender: TObject);
    procedure ListBoxDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure ListBoxDblClick(Sender: TObject);
    procedure StayOnTopClick(Sender: TObject);
    procedure ListBoxMeasureItem(Control: TWinControl; Index: Integer;
      var Height: Integer);
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
    TempQSO : TQSO;
    DispMax : word;
    procedure RenewListBox(QSOList : TQSOList);
    function SortBy: TSortMethod;
    function GetFontSize(): Integer;
    procedure SetFontSize(v: Integer);
  public
    { Public declarations }
    _CheckCall : boolean;
    AllBand : boolean;
    HitNumber : integer;
    HitCall : string;
    procedure CheckPartial(aQSO : TQSO);
    procedure CheckPartialNumber(aQSO : TQSO);
    procedure UpdateData(aQSO : TQSO); // calls either checkpartial or checkpartialnumber
                                   // depending on _CheckCall value;
    property FontSize: Integer read GetFontSize write SetFontSize;
  end;

implementation

uses
  Main;

{$R *.DFM}

function TPartialCheck.SortBy(): TSortMethod;
begin
   Result := soTime;

   if rbBand.Checked then begin
      Result := soBand;
   end;

   if rbCall.Checked then begin
      Result := soCallsign;
   end;
end;

procedure TPartialCheck.CreateParams(var Params: TCreateParams);
begin
   inherited CreateParams(Params);
   Params.ExStyle := Params.ExStyle or WS_EX_APPWINDOW;
end;

procedure TPartialCheck.CheckPartialNumber(aQSO: TQSO);
var
   PartialStr: string;
   i: LongInt;
   _count: Integer;
   TempList: TQSOList;
label
   disp;
begin
   TempList := TQSOList.Create(False);
   try
      _CheckCall := False;
      _count := 0;
      TempQSO := aQSO;

      PartialStr := aQSO.NrRcvd;

      if PartialStr <> '' then begin
         for i := 1 to Log.TotalQSO do begin
            if Pos(PartialStr, Log.QsoList[i].NrRcvd) > 0 then begin
               if AllBand or (not(AllBand) and (aQSO.Band = Log.QsoList[i].Band)) then begin
                  TempList.Add(Log.QsoList[i]);
                  if _count >= DispMax then
                     goto disp
                     // exit
                  else
                     inc(_count);
               end;
            end;
         end;
      end
      else begin
         ListBox.Clear;
         exit;
      end;

   disp:
      if TempList.Count = 0 then begin
         ListBox.Clear;
         exit;
      end;

      TempList.Sort(SortBy);

      RenewListBox(TempList);
   finally
      TempList.Free;
   end;
end;

procedure TPartialCheck.RenewListBox(QSOList: TQSOList);
var
   i: Integer;
   S: string;
begin
   ListBox.Items.Clear;

   if QSOList.Count = 0 then begin
      exit;
   end;

   for i := 0 to QSOList.Count - 1 do begin
      S := QSOList[i].PartialSummary(dmZlogGlobal.Settings._displaydatepartialcheck);
      if QSOList[i].Band = Main.CurrentQSO.Band then begin
         S := '*' + S;

         if checkShowCurrentBandFirst.Checked = True then begin
            ListBox.Items.Insert(0, S);
         end
         else begin
            ListBox.Items.Add(S);
         end;
      end
      else begin
         ListBox.Items.Add(S);
      end;
   end;
end;

procedure TPartialCheck.CheckPartial(aQSO: TQSO);
var
   PartialStr: string;
   i: LongInt;
   _count: Integer;
   TempList: TQSOList;
label
   disp;
begin
   HitNumber := 0;
   HitCall := '';
   _CheckCall := True;
   _count := 0;
   TempQSO := aQSO;
   // ListBox.Items.Clear;
   PartialStr := aQSO.Callsign;
   if dmZlogGlobal.Settings._searchafter >= length(PartialStr) then begin
      ListBox.Items.Clear;
      exit;
   end;

   if Pos(',', PartialStr) = 1 then
      exit;

   TempList := TQSOList.Create(False);
   try
      if (PartialStr <> '') then begin
         for i := 1 to Log.TotalQSO do
            // if Pos(PartialStr, TQSO(Log.List[i]).QSO.Callsign) > 0 then
            if PartialMatch(PartialStr, Log.QsoList[i].Callsign) then
               if AllBand or (not(AllBand) and (aQSO.Band = Log.QsoList[i].Band)) then begin
                  // ListBox.Items.Add(TQSO(Log.List[i]).PartialSummary);
                  TempList.Add(Log.QsoList[i]);
                  if _count >= DispMax then
                     goto disp
                     // exit
                  else
                     inc(_count);
               end;
      end
      else begin { PartialStr = '' }
         ListBox.Clear;
         TempList.Free;
         exit;
      end;

   disp:
      if TempList.Count = 0 then begin
         ListBox.Clear;
         exit;
      end;

      HitNumber := TempList.Count;

      TempList.Sort(SortBy);

      RenewListBox(TempList);

      HitCall := TempList.Items[0].Callsign;
   finally
      TempList.Free;
   end;
end;

procedure TPartialCheck.FormCreate(Sender: TObject);
begin
   ListBox.Font.Name := dmZLogGlobal.Settings.FBaseFontName;
   AllBand := True;
   _CheckCall := True;
   DispMax := 200;
   ShowMaxEdit.Value := DispMax;
end;

procedure TPartialCheck.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   case Key of
      VK_ESCAPE:
         MainForm.SetLastFocus();
   end;
end;

procedure TPartialCheck.FormShow(Sender: TObject);
begin
   MoreButton.ImageIndex := 0;
   panelExtend.Visible := False;
end;

procedure TPartialCheck.CheckBox1Click(Sender: TObject);
begin
   AllBand := CheckBox1.Checked;
   if _CheckCall then
      CheckPartial(TempQSO)
   else
      CheckPartialNumber(TempQSO);
end;

procedure TPartialCheck.MoreButtonClick(Sender: TObject);
begin
   if MoreButton.ImageIndex = 0 then begin
      MoreButton.ImageIndex := 1;
      panelExtend.Visible := True;
   end
   else begin
      MoreButton.ImageIndex := 0;
      panelExtend.Visible := False;
   end;
end;

procedure TPartialCheck.ShowMaxEditChange(Sender: TObject);
begin
   DispMax := ShowMaxEdit.Value;
end;

procedure TPartialCheck.UpdateData(aQSO: TQSO);
begin
   if _CheckCall then
      CheckPartial(aQSO)
   else
      CheckPartialNumber(aQSO);
end;

procedure TPartialCheck.rbSortClick(Sender: TObject);
begin
   UpdateData(Main.CurrentQSO);
end;

procedure TPartialCheck.ListBoxDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
   XOffSet: Integer;
   YOffSet: Integer;
   S: string;
   H: Integer;
begin
   with (Control as TListBox).Canvas do begin
      XOffSet := 2; { provide default offset }

      H := Rect.Bottom - Rect.Top;
      YOffset := (H - Abs(TListBox(Control).Font.Height)) div 2;
      S := (Control as TListBox).Items[Index];

      if S[1] = '*' then begin
         Delete(S, 1, 1);
         if odSelected in State then begin
            Font.Color := clYellow;
            //Brush.Color := clWhite;
         end
         else begin
            Font.Color := dmZLogGlobal.Settings.FPartialCheck.FCurrentBandForeColor;
            // Font.Style := [fsBold];
            Brush.Color := dmZLogGlobal.Settings.FPartialCheck.FCurrentBandBackColor
         end;
      end
      else begin
         if odSelected in State then begin
            Font.Color := clWhite;
         end
         else begin
            Font.Color := clWindowText;
         end;
         //Brush.Color := clWhite;
      end;

      FillRect(Rect); { clear the rectangle }

      TextOut(Rect.Left + XOffSet, Rect.Top + YOffSet, S) { display the text }
   end;
end;

procedure TPartialCheck.ListBoxMeasureItem(Control: TWinControl; Index: Integer;
  var Height: Integer);
begin
   Height := Abs(TListBox(Control).Font.Height) + 4;
end;

procedure TPartialCheck.ListBoxDblClick(Sender: TObject);
var
   i: Integer;
   str: string;
begin
   i := ListBox.ItemIndex;
   str := copy(ListBox.Items[i], 7, 12);
   str := TrimRight(str);

   MainForm.SetYourCallsign(str, '');
end;

procedure TPartialCheck.StayOnTopClick(Sender: TObject);
begin
   If StayOnTop.Checked then
      FormStyle := fsStayOnTop
   else
      FormStyle := fsNormal;
end;

function TPartialCheck.GetFontSize(): Integer;
begin
   Result := ListBox.Font.Size;
end;

procedure TPartialCheck.SetFontSize(v: Integer);
begin
   ListBox.Font.Size := v;
end;

end.

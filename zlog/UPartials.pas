unit UPartials;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, Spin,
  UzLogConst, UzLogGlobal, UzLogQSO;

const sortTime = 1;
      sortBand = 2;
      sortCall = 3;

type
  TPartialCheck = class(TForm)
    ListBox: TListBox;
    Panel: TPanel;
    Button3: TButton;
    CheckBox1: TCheckBox;
    ShowMaxEdit: TSpinEdit;
    Label1: TLabel;
    SortByGroup: TGroupBox;
    rbTime: TRadioButton;
    rbBand: TRadioButton;
    rbCall: TRadioButton;
    MoreButton: TSpeedButton;
    StayOnTop: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
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

  private
    TempQSO : TQSO;
    DispMax : word;
    { Private declarations }
    function SortBy : byte;
  public
    _CheckCall : boolean;
    AllBand : boolean;
    HitNumber : integer;
    HitCall : string;
    procedure RenewListBox(QSOList : TList);
    procedure CheckPartial(aQSO : TQSO);
    procedure CheckPartialNumber(aQSO : TQSO);
    procedure SortByCall(var QSOList : TList);
    procedure SortByTime(var QSOList : TList);
    procedure SortByBand(var QSOList : TList);
    procedure UpdateData(aQSO : TQSO); // calls either checkpartial or checkpartialnumber
                                   // depending on _CheckCall value;
    { Public declarations }
  end;

var
  PartialCheck: TPartialCheck;

implementation

uses Main, UOptions;

{$R *.DFM}

procedure TPartialCheck.SortByCall(var QSOList: TList);

   procedure QuickSortCall(var QSOList: TList; iLo, iHi: Integer);
   var
      Lo, Hi: Integer;
      Mid: string;
   begin
      Lo := iLo;
      Hi := iHi;
      Mid := TQSO(QSOList[(Lo + Hi) div 2]).Callsign;
      repeat
         while CompareText(TQSO(QSOList[Lo]).Callsign, Mid) < 0 do
            inc(Lo);
         while CompareText(TQSO(QSOList[Hi]).Callsign, Mid) > 0 do
            dec(Hi);
         if Lo <= Hi then begin
            QSOList.Exchange(Lo, Hi);
            inc(Lo);
            dec(Hi);
         end;
      until Lo > Hi;
      if Hi > iLo then
         QuickSortCall(QSOList, iLo, Hi);
      if Lo < iHi then
         QuickSortCall(QSOList, Lo, iHi);
   end;
begin
   QuickSortCall(QSOList, 0, QSOList.Count - 1);
end;

procedure TPartialCheck.SortByTime(var QSOList: TList);

   procedure QuickSortTime(var QSOList: TList; iLo, iHi: Integer);
   var
      Lo, Hi: Integer;
      Mid: TDateTime;
   begin
      Lo := iLo;
      Hi := iHi;
      Mid := TQSO(QSOList[(Lo + Hi) div 2]).Time;
      repeat
         while (TQSO(QSOList[Lo]).Time < Mid) do
            inc(Lo);
         while (TQSO(QSOList[Hi]).Time > Mid) do
            dec(Hi);
         if Lo <= Hi then begin
            QSOList.Exchange(Lo, Hi);
            inc(Lo);
            dec(Hi);
         end;
      until Lo > Hi;
      if Hi > iLo then
         QuickSortTime(QSOList, iLo, Hi);
      if Lo < iHi then
         QuickSortTime(QSOList, Lo, iHi);
   end;

begin
   QuickSortTime(QSOList, 0, QSOList.Count - 1);
end;

procedure TPartialCheck.SortByBand(var QSOList: TList);
var
   BandOrder: array [b19 .. b10g] of Integer;
   b: TBand;

   procedure QuickSortBand(var QSOList: TList; iLo, iHi: Integer);
   var
      Lo, Hi: Integer;
      Mid: Integer { TBand };
   begin
      Lo := iLo;
      Hi := iHi;
      Mid := BandOrder[TQSO(QSOList[(Lo + Hi) div 2]).Band];
      repeat
         while (BandOrder[TQSO(QSOList[Lo]).Band] < Mid) do
            inc(Lo);
         while (BandOrder[TQSO(QSOList[Hi]).Band] > Mid) do
            dec(Hi);
         if Lo <= Hi then begin
            QSOList.Exchange(Lo, Hi);
            inc(Lo);
            dec(Hi);
         end;
      until Lo > Hi;
      if Hi > iLo then
         QuickSortBand(QSOList, iLo, Hi);
      if Lo < iHi then
         QuickSortBand(QSOList, Lo, iHi);
   end;
begin
   for b := b19 to b10g do
      BandOrder[b] := ord(b) + 1;
   BandOrder[Main.CurrentQSO.Band] := 0;

   QuickSortBand(QSOList, 0, QSOList.Count - 1);
end;

function TPartialCheck.SortBy: byte;
begin
   Result := sortTime;
   if rbBand.Checked then
      Result := sortBand;
   if rbCall.Checked then
      Result := sortCall;
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
   TempList: TList;
label
   disp;
begin
   _CheckCall := False;
   _count := 0;
   TempQSO := aQSO;
   TempList := TList.Create;
   // ListBox.Items.Clear;
   PartialStr := aQSO.NrRcvd;

   if PartialStr <> '' then begin
      for i := 1 to Log.TotalQSO do begin
         if Pos(PartialStr, TQSO(Log.List[i]).NrRcvd) > 0 then begin
            if AllBand or (not(AllBand) and (aQSO.Band = TQSO(Log.List[i]).Band)) then begin
               TempList.Add(TQSO(Log.List[i]));
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
      TempList.Free;
      exit;
   end;

disp:
   if TempList.Count = 0 then begin
      ListBox.Clear;
      TempList.Free;
      exit;
   end;

   case SortBy of
      sortTime:
         SortByTime(TempList);
      sortBand: begin
            SortByBand(TempList);
            // PushUpCurrentBand(TempList,aQSO.QSO.Band);
         end;
      sortCall:
         SortByCall(TempList);
   end;

   RenewListBox(TempList);
   TempList.Free;
end;

procedure TPartialCheck.RenewListBox(QSOList: TList);
var
   i: Integer;
   S: string;
begin
   ListBox.Items.Clear;
   if QSOList.Count = 0 then
      exit;
   for i := 0 to QSOList.Count - 1 do begin
      S := TQSO(QSOList[i]).PartialSummary(dmZlogGlobal.Settings._displaydatepartialcheck);
      if TQSO(QSOList[i]).Band = Main.CurrentQSO.Band then
         S := '*' + S;
      ListBox.Items.Add(S);
   end;
end;

procedure TPartialCheck.CheckPartial(aQSO: TQSO);
var
   PartialStr: string;
   i: LongInt;
   _count: Integer;
   TempList: TList;
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

   TempList := TList.Create;
   if (PartialStr <> '') then begin
      for i := 1 to Log.TotalQSO do
         // if Pos(PartialStr, TQSO(Log.List[i]).QSO.Callsign) > 0 then
         if PartialMatch(PartialStr, TQSO(Log.List[i]).Callsign) then
            if AllBand or (not(AllBand) and (aQSO.Band = TQSO(Log.List[i]).Band)) then begin
               // ListBox.Items.Add(TQSO(Log.List[i]).PartialSummary);
               TempList.Add(TQSO(Log.List[i]));
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
      TempList.Free;
      exit;
   end;

   HitNumber := TempList.Count;

   case SortBy of
      sortTime:
         SortByTime(TempList);
      sortBand:
         SortByBand(TempList);
      sortCall:
         SortByCall(TempList);
   end;

   RenewListBox(TempList);

   HitCall := TQSO(TempList.Items[0]).Callsign;

   TempList.Free;
end;

procedure TPartialCheck.FormCreate(Sender: TObject);
begin
   AllBand := True;
   // CheckBox1.Checked := AllBand;
   _CheckCall := True;
   DispMax := 200;
   ShowMaxEdit.Value := DispMax;
end;

procedure TPartialCheck.Button3Click(Sender: TObject);
begin
   Close;
end;

procedure TPartialCheck.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   case Key of
      VK_ESCAPE:
         MainForm.LastFocus.SetFocus;
   end;
end;

{ procedure TPartialCheck.CheckBox1Click(Sender: TObject);
  begin
  end; }

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
   if MoreButton.Caption = 'More..' then begin
      MoreButton.Caption := 'Hide';
      Panel.Height := 64;
   end
   else begin
      MoreButton.Caption := 'More..';
      Panel.Height := 32;
   end;
end;

procedure TPartialCheck.ShowMaxEditChange(Sender: TObject);
begin
   DispMax := ShowMaxEdit.Value;
end;

procedure TPartialCheck.UpdateData(aQSO: TQSO);
begin
   // MainForm.PartialClick(Self);
   { if MainForm.ActiveControl = MainForm.NumberEdit then
     CheckPartialNumber(Main.CurrentQSO)
     else
     CheckPartial(Main.CurrentQSO); }
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
   OffSet: Integer;
   S: string;
begin
   with (Control as TListBox).Canvas do begin
      FillRect(Rect); { clear the rectangle }
      OffSet := 2; { provide default offset }
      S := (Control as TListBox).Items[Index];
      if S[1] = '*' then begin
         Delete(S, 1, 1);
         Font.Color := clPurple;
         // Font.Style := [fsBold];
      end
      else
         Font.Color := clWindowText;
      // Font.Style := [];
      { if Index = ListBox.ItemIndex then
        Font.Color := clHighlightText
        else
        Font.Color := clWindowText; }
      TextOut(Rect.Left + OffSet, Rect.Top, S) { display the text }
   end;
end;

procedure TPartialCheck.ListBoxDblClick(Sender: TObject);
var
   i: Integer;
   str: string;
begin
   i := ListBox.ItemIndex;
   str := copy(ListBox.Items[i], 7, 12);
   str := TrimRight(str);
   MainForm.CallsignEdit.Text := str;
end;

procedure TPartialCheck.StayOnTopClick(Sender: TObject);
begin
   If StayOnTop.Checked then
      FormStyle := fsStayOnTop
   else
      FormStyle := fsNormal;
end;

end.

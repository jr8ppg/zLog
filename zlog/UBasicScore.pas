unit UBasicScore;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UzLogConst, UzLogGlobal, UzLogQSO, StdCtrls, ExtCtrls, Buttons, Math, Grids,
  Vcl.Menus;

type
  TBasicScore = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    StayOnTop: TCheckBox;
    CWButton: TSpeedButton;
    popupExtraInfo: TPopupMenu;
    menuMultiRate: TMenuItem;
    menuPtsPerMulti: TMenuItem;
    menuPtsPerQSO: TMenuItem;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure StayOnTopClick(Sender: TObject);
    procedure CWButtonClick(Sender: TObject);
    procedure menuExtraInfoClick(Sender: TObject);
  protected
    FFontSize: Integer;
    FExtraInfo: Integer;
    function GetFontSize(): Integer; virtual;
    procedure SetFontSize(v: Integer); virtual;
    procedure Draw_GridCell(Grid: TStringGrid; ACol, ARow: Integer; Rect: TRect);
    procedure AdjustGridSize(Grid: TStringGrid; ColCount, RowCount: Integer);
    procedure SetGridFontSize(Grid: TStringGrid; font_size: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
    QSO : array[b19..HiBand] of LongInt;
    CWQSO : array[b19..HiBand] of LongInt;
    FMQSO : array[b19..HiBand] of LongInt;
    Points : array[b19..HiBand] of LongInt;
    Multi : array[b19..HiBand] of LongInt;
    ShowCWRatio : boolean;
    constructor Create(AOwner: TComponent); override;
    procedure Renew; virtual;
    procedure UpdateData; virtual;
    procedure AddNoUpdate(var aQSO : TQSO); virtual;
    procedure Add(var aQSO : TQSO); virtual; {calculates points}
    procedure Reset; virtual;
    procedure SaveSummary(FileName : string); virtual;
    procedure SummaryWriteScore(FileName : string); virtual;
    function TotalCWQSOs : integer;
    function TotalQSOs : integer;
    function QPMStr(B: TBand) : string; // returns QSO,Pts,Mult for JARL E-log
    function TotalQPMStr: string;
    function _TotalMulti : integer;
    function _TotalPoints : integer;
    function IntToStr3(v: Integer): string;
    property FontSize: Integer read GetFontSize write SetFontSize;
  end;

const
  EXTRAINFO_CAPTION: array[0..2] of string = ( 'Multi%', 'Pts/M', 'Pts/Q' );

implementation

uses
  Main, USummaryInfo;

{$R *.DFM}

procedure TBasicScore.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.ExStyle := Params.ExStyle or WS_EX_APPWINDOW;
end;

procedure TBasicScore.SummaryWriteScore(FileName: string);
var
   f: textfile;
   TQSO, tpts, tmulti: LongInt;
   B: TBand;
begin
   TQSO := 0;
   tpts := 0;
   tmulti := 0;
   AssignFile(f, FileName);
   Append(f);
   writeln(f, 'MHz           QSOs    Points    Multis');
   for B := b19 to HiBand do begin
      if NotWARC(B) then begin
         writeln(f, FillRight(MHzString[B], 8) + FillLeft(IntToStr(QSO[B]), 10) + FillLeft(IntToStr(Points[B]), 10) +
           FillLeft(IntToStr(Multi[B]), 10));
         TQSO := TQSO + QSO[B];
         tpts := tpts + Points[B];
         tmulti := tmulti + Multi[B];
      end;
   end;
   writeln(f, FillRight('Total :', 8) + FillLeft(IntToStr(TQSO), 10) + FillLeft(IntToStr(tpts), 10) + FillLeft(IntToStr(tmulti), 10));
   writeln(f, 'Total score : ' + IntToStr(tpts * tmulti));
   CloseFile(f);
end;

procedure TBasicScore.SaveSummary(FileName: string);
var
   f: textfile;
   DLG: TSummaryInfo;
begin
   DLG := TSummaryInfo.Create(Self);
   try
      if DLG.ShowModal <> mrOK then begin
         exit;
      end;

      AssignFile(f, FileName);
      Rewrite(f);

      with DLG do begin
         writeln(f, ContestNameEdit.Text);
         writeln(f);
         writeln(f, 'Call sign: ' + CallEdit.Text);
         writeln(f);
         writeln(f, 'Category: ' + CategoryEdit.Text);
         writeln(f);
         if CountryEdit.Text <> '' then begin
            writeln(f, 'Country: ' + CountryEdit.Text);
            writeln(f);
         end;

         CloseFile(f);
         SummaryWriteScore(FileName);
         Append(f);

         writeln(f);

         if MiscMemo.Text <> '' then begin
            write(f, MiscMemo.Text);
            writeln(f);
         end;
         if RemMemo.Text <> '' then begin
            writeln(f, 'Remarks:');
            write(f, RemMemo.Text);
            writeln(f);
         end;
         write(f, DecMemo.Text);
         writeln(f);
         writeln(f, 'Name: ' + NameEdit.Text);
         writeln(f);
         writeln(f, 'Address:');
         writeln(f);
         write(f, AddrMemo.Text);
         writeln(f);
      end;

      CloseFile(f);
   finally
      DLG.Release();
   end;
end;

constructor TBasicScore.Create(AOwner: TComponent);
begin
   Inherited Create(AOwner);
   ShowCWRatio := False;
   Reset;

   case dmZLogGlobal.Settings.FLastScoreExtraInfo of
      0: menuMultiRate.Checked := True;
      1: menuPtsPerMulti.Checked := True;
      2: menuPtsPerQSO.Checked := True;
      else menuMultiRate.Checked := True;
   end;
end;

procedure TBasicScore.Renew;
var
   i: Word;
   band: TBand;
begin
   Reset;
   for i := 1 to Log.TotalQSO do begin
      band := Log.QsoList[i].band;
      inc(QSO[band]);
      inc(Points[band], Log.QsoList[i].Points);
      if Log.QsoList[i].NewMulti1 then
         inc(Multi[band]);
   end;
end;

procedure TBasicScore.UpdateData;
begin
   if menuMultiRate.Checked = True then begin
      FExtraInfo := 0;
   end
   else if menuPtsPerMulti.Checked = True then begin
      FExtraInfo := 1;
   end
   else if menuPtsPerQSO.Checked = True then begin
      FExtraInfo := 2;
   end
   else begin
      FExtraInfo := 0;
   end;
   dmZLogGlobal.Settings.FLastScoreExtraInfo := FExtraInfo;
end;

procedure TBasicScore.AddNoUpdate(var aQSO: TQSO);
var
   B: TBand;
begin
   B := aQSO.band;
   inc(QSO[B]);

   if aQSO.mode = mCW then
      inc(CWQSO[B]);

   if aQSO.mode = mFM then
      inc(FMQSO[B]);

   if aQSO.NewMulti1 then
      inc(Multi[B]);

   { if aQSO.NewMulti2 then
     inc(Multi2[B]); }
end;

procedure TBasicScore.Add(var aQSO: TQSO);
begin
   AddNoUpdate(aQSO);
   UpdateData;
end;

procedure TBasicScore.Reset;
var
   band: TBand;
begin
   for band := b19 to HiBand do begin
      QSO[band] := 0;
      CWQSO[band] := 0;
      FMQSO[band] := 0;
      Points[band] := 0;
      Multi[band] := 0;
   end;
end;

procedure TBasicScore.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   case Key of
      VK_ESCAPE:
         MainForm.LastFocus.SetFocus;
      // VK_ALT
   end;
end;

procedure TBasicScore.Button1Click(Sender: TObject);
begin
   Close;
end;

procedure TBasicScore.FormCreate(Sender: TObject);
begin
   FFontSize := 9;
   StayOnTop.Checked := False;
end;

procedure TBasicScore.StayOnTopClick(Sender: TObject);
begin
   If StayOnTop.Checked then
      FormStyle := fsStayOnTop
   else
      FormStyle := fsNormal;
end;

function TBasicScore.TotalCWQSOs: integer;
var
   B: TBand;
   i: integer;
begin
   i := 0;
   for B := b19 to HiBand do
      i := i + CWQSO[B];
   Result := i;
end;

function TBasicScore.TotalQSOs: integer;
var
   B: TBand;
   i: integer;
begin
   i := 0;
   for B := b19 to HiBand do
      i := i + QSO[B];
   Result := i;
end;

procedure TBasicScore.CWButtonClick(Sender: TObject);
begin
   if CWButton.Down then
      ShowCWRatio := True
   else
      ShowCWRatio := False;

   UpdateData;
end;

function TBasicScore.QPMStr(B: TBand): string; // returns QSO,Pts,Mult for JARL E-log
begin
   Result := IntToStr(QSO[B]) + ',' + IntToStr(Points[B]) + ',' + IntToStr(Multi[B]);
end;

function TBasicScore.TotalQPMStr: string; // returns QSO,Pts,Mult for JARL E-log
begin
   Result := IntToStr(TotalQSOs) + ',' + IntToStr(_TotalPoints) + ',' + IntToStr(_TotalMulti);
end;

function TBasicScore._TotalMulti: integer;
var
   B: TBand;
   i: integer;
begin
   i := 0;
   for B := b19 to HiBand do
      i := i + Multi[B];
   Result := i;
end;

function TBasicScore._TotalPoints: integer;
var
   B: TBand;
   i: integer;
begin
   i := 0;
   for B := b19 to HiBand do
      i := i + Points[B];
   Result := i;
end;

function TBasicScore.IntToStr3(v: integer): string;
var
   i: integer;
   c: integer;
   strText: string;
   strFormatedText: string;
begin
   strText := IntToStr(v);
   strFormatedText := '';

   c := 0;
   for i := Length(strText) downto 1 do begin
      if c >= 3 then begin
         strFormatedText := ',' + strFormatedText;
         c := 0;
      end;
      strFormatedText := Copy(strText, i, 1) + strFormatedText;
      inc(c);
   end;

   Result := strFormatedText;
end;

procedure TBasicScore.menuExtraInfoClick(Sender: TObject);
begin
   UpdateData();
end;

function TBasicScore.GetFontSize(): Integer;
begin
   Result := FFontSize;
end;

procedure TBasicScore.SetFontSize(v: Integer);
begin
   FFontSize := v;
end;


procedure TBasicScore.Draw_GridCell(Grid: TStringGrid; ACol, ARow: Integer; Rect: TRect);
var
   strText: string;
begin
   strText := Grid.Cells[ACol, ARow];

   with Grid.Canvas do begin
      Font.Name := 'ÇlÇr ÉSÉVÉbÉN';
      Brush.Color := Grid.Color;
      Brush.Style := bsSolid;
      FillRect(Rect);

      Font.Size := FFontSize;

      if Copy(strText, 1, 1) = '*' then begin
         strText := Copy(strText, 2);
         Font.Color := clBlue;
      end
      else begin
         Font.Color := clBlack;
      end;

      TextRect(Rect, strText, [tfRight,tfVerticalCenter,tfSingleLine]);
   end;
end;

procedure TBasicScore.AdjustGridSize(Grid: TStringGrid; ColCount, RowCount: Integer);
var
   i: Integer;
   h: Integer;
   w: Integer;
begin
   // ïùí≤êÆ
   w := 0;
   for i := 0 to ColCount - 1 do begin
      w := w + Grid.ColWidths[i];
   end;
   w := w + (Grid.ColCount * Grid.GridLineWidth) + 2;
   ClientWidth := Max(w, 200);

   // çÇÇ≥í≤êÆ
   h := 0;
   for i := 0 to RowCount - 1 do begin
      h := h + Grid.RowHeights[i];
   end;
   h := h + (Grid.RowCount * Grid.GridLineWidth) + Panel1.Height + 4;
   ClientHeight := h;
end;

procedure TBasicScore.SetGridFontSize(Grid: TStringGrid; font_size: Integer);
var
   i: Integer;
   h: Integer;
begin
   Grid.Font.Size := font_size;
   Grid.Canvas.Font.size := font_size;

   h := Abs(Grid.Font.Height) + 6;

   Grid.DefaultRowHeight := h;

   for i := 0 to Grid.RowCount - 1 do begin
      Grid.RowHeights[i] := h;
   end;
end;

end.

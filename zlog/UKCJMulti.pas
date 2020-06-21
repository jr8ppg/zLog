unit UKCJMulti;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UBasicMulti, Grids, StdCtrls, ExtCtrls,
  UzLogConst, UzLogGlobal, UzLogQSO, UKCJZone;

const maxindex = 70;

const KenNames : array[0..maxindex] of string =
('SY @’J','RM —¯–G','KK ãì','AB –Ô‘–','SC ‹ó’m','IS Îë','NM ªº',
 'SB Œãu','TC \Ÿ','KR ‹ú˜H','HD “ú‚','IR ’_U','HY •OR','OM “n“‡',
 'AM ÂX','IT Šâè','AT H“c','YM RŒ`','MG ‹{é','FS •Ÿ“‡','NI VŠƒ',
 'NN ’·–ì','TK “Œ‹','KN _“Şì','CB ç—t','ST é‹Ê','IB ˆïé','TG “È–Ø',
 'GM ŒQ”n','YN R—œ','OH ‘å“‡','MY O‘î','HJ ”ªä',
 'SO Ã‰ª','GF Šò•Œ','AC ˆ¤’m','ME Od','KT ‹“s',
 'SI  ‰ê','NR “Ş—Ç','OS ‘åã','WK ˜a‰ÌR','HG •ºŒÉ','TY •xR','FI •Ÿˆä',
 'IK Îì','OY ‰ªR','SN “‡ª','YG RŒû','TT ’¹æ','HS L“‡','KA ì',
 'TS “¿“‡','EH ˆ¤•Q','KC ‚’m','FO •Ÿ‰ª','SG ²‰ê','NS ’·è','KM ŒF–{',
 'OT ‘å•ª','MZ ‹{è','KG ­™“‡','TM ‘Î”n','ON ‰«“ê','OG ¬Š}Œ´',
 'AS ƒAƒWƒA','NA –kƒAƒƒŠƒJ','SA “ìƒAƒƒŠƒJ','EU ƒˆ[ƒƒbƒp','AF ƒAƒtƒŠƒJ',
 'OC ƒIƒZƒAƒjƒA');

type
  TKCJMulti = class(TBasicMulti)
    Panel1: TPanel;
    Button1: TButton;
    cbStayOnTop: TCheckBox;
    combBand: TComboBox;
    Button2: TButton;
    Grid: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure combBandChange(Sender: TObject);
    procedure cbStayOnTopClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    MultiMap: TKCJZone;
    function KCJCode(S : string) : integer;
    function WorkedColor(Worked: boolean): TColor;
    function GetBandNumber(Index: Integer): TBand;
    function GetBandIndex(b: TBand): Integer;
  public
    { Public declarations }
    MultiArray : array[b19..b50, 0..maxindex] of boolean;
    procedure UpdateData; override;
    procedure AddNoUpdate(var aQSO : TQSO); override;
    procedure Reset; override;
    procedure CheckMulti(aQSO : TQSO); override;
    function ValidMulti(aQSO : TQSO) : boolean; override;
  end;

implementation

uses
  Main;

{$R *.DFM}

function TKCJMulti.KCJCode(S : string) : integer;
var
   i: Integer;
begin
   if length(S) = 2 then begin
      for i := 0 to maxindex do begin
         if pos(S, KenNames[i]) = 1 then begin
            Result := i;
            Exit;
         end;
      end;
   end;

   Result := -1;
end;

function TKCJMulti.WorkedColor(Worked: boolean): TColor;
begin
   if Worked then begin
      Result := clRed;
   end
   else begin
      Result := clBlack;
   end;
end;

procedure TKCJMulti.UpdateData;
var
   B: TBand;
begin
   B := Main.CurrentQSO.Band;

   combBand.ItemIndex := GetBandIndex(B);

   if MultiMap.Visible then begin
      MultiMap.UpdateData;
   end;

   Grid.Refresh();
end;

procedure TKCJMulti.AddNoUpdate(var aQSO: TQSO);
var
   str: string;
   K: Integer;
begin
   aQSO.NewMulti1 := False;
   str := aQSO.NrRcvd;
   aQSO.Multi1 := str;

   if aQSO.Dupe then begin
      Exit;
   end;

   if not(NotWARC(aQSO.Band)) then begin
      Exit;
   end;

   K := KCJCode(str);
   if K = -1 then begin
      Exit;
   end;

   if MultiArray[aQSO.Band, K] = False then begin
      MultiArray[aQSO.Band, K] := True;
      aQSO.NewMulti1 := True;
   end;
end;

function TKCJMulti.ValidMulti(aQSO: TQSO): boolean;
var
   str: string;
begin
   str := aQSO.NrRcvd;
   Result := (KCJCode(str) >= 0)
end;

procedure TKCJMulti.Reset;
var
   i: Integer;
   B: TBand;
begin
   for i := 0 to maxindex do begin
      for B := b19 to b50 do begin
         MultiArray[B, i] := False;
      end;
   end;
end;

procedure TKCJMulti.CheckMulti(aQSO: TQSO);
var
   str: string;
   M: Integer;
   B: TBand;
begin
   str := aQSO.NrRcvd;

   if str = '' then begin
      Exit;
   end;

   M := KCJCode(str);

   if M = -1 then begin
      MainForm.WriteStatusLine('Invalid number', False);
      Exit;
   end;

   str := KenNames[M];
   if MultiArray[aQSO.Band, M] = True then begin
      str := str + '   Worked on this band. Worked on : ';
   end
   else begin
      str := str + '   Needed on this band. Worked on : ';
   end;

   for B := b19 to b50 do begin
      if MultiArray[B, M] then begin
         str := str + MHzString[B] + ' ';
      end
      else begin
         str := str + '';
      end;
   end;

   MainForm.WriteStatusLine(str, False);
end;

procedure TKCJMulti.FormCreate(Sender: TObject);
begin
   inherited;
   Reset;
   combBand.ItemIndex := 0;
   MultiMap := TKCJZone.Create(Self);
   MultiMap.MultiForm := Self;
end;

procedure TKCJMulti.FormDestroy(Sender: TObject);
begin
   inherited;
   MultiMap.Release();
end;

procedure TKCJMulti.FormShow(Sender: TObject);
var
   i: Integer;
   r: Integer;
   c: Integer;
begin
   inherited;
   Grid.RowCount := 12;
   Grid.ColCount := 7;

   for i := 0 to maxindex do begin
      c := i mod 7;
      r := i div 7;
      Grid.Cells[c, r] := KenNames[i];
   end;

   ClientWidth := (Grid.DefaultColWidth * Grid.ColCount) + (Grid.ColCount * Grid.GridLineWidth);
   ClientHeight := (Grid.DefaultRowHeight * Grid.RowCount) + (Grid.RowCount * Grid.GridLineWidth) + Panel1.Height + 4;
end;

procedure TKCJMulti.Button1Click(Sender: TObject);
begin
   // inherited;
   Close;
end;

procedure TKCJMulti.combBandChange(Sender: TObject);
begin
   Grid.Invalidate();
end;

procedure TKCJMulti.cbStayOnTopClick(Sender: TObject);
begin
   if cbStayOnTop.Checked then begin
      FormStyle := fsStayOnTop;
   end
   else begin
      FormStyle := fsNormal;
   end;
end;

procedure TKCJMulti.Button2Click(Sender: TObject);
begin
   MultiMap.Show;
end;

procedure TKCJMulti.GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
   strText: string;
   i: Integer;
   b: TBand;
   col: TColor;
begin
   inherited;
   strText := TStringGrid(Sender).Cells[ACol, ARow];

   i := (ARow * 7) + ACol;
   if (i >= 0) and (i <= maxindex) then begin
      b := GetBandNumber(combBand.ItemIndex);
      col := WorkedColor(MultiArray[b, i]);
   end
   else begin
      col := clBlack;
   end;

   with TStringGrid(Sender).Canvas do begin
      Brush.Color := TStringGrid(Sender).Color;
      Brush.Style := bsSolid;
      FillRect(Rect);

      Font.Name := '‚l‚r ƒSƒVƒbƒN';
      Font.Size := 11;
      Font.Color := col;

      TextRect(Rect, strText, [tfLeft, tfVerticalCenter, tfSingleLine]);
   end;
end;

function TKCJMulti.GetBandNumber(Index: Integer): TBand;
begin
   case Index of
      0: Result := b19;
      1: Result := b35;
      2: Result := b7;
      3: Result := b14;
      4: Result := b21;
      5: Result := b28;
      6: Result := b50;
      else Result := b19;
   end;
end;

function TKCJMulti.GetBandIndex(b: TBand): Integer;
begin
   case b of
      b19: Result := 0;
      b35: Result := 1;
      b7:  Result := 2;
      b14: Result := 3;
      b21: Result := 4;
      b28: Result := 5;
      b50: Result := 6;
      else Result := 0;
   end;
end;

end.

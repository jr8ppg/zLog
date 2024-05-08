unit UGeneralScore;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UBasicScore, StdCtrls, ExtCtrls, Menus, Grids, UITypes, Buttons, Math,
  UzLogConst, UzLogGlobal, UzLogQSO, UMultipliers, UGeneralMulti2,
  UserDefinedContest;

type
  TGeneralScore = class(TBasicScore)
    Grid: TStringGrid;
    procedure FormShow(Sender: TObject);
    procedure GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
  protected
    function GetFontSize(): Integer; override;
    procedure SetFontSize(v: Integer); override;
  private
    { Private declarations }
    FConfig: TUserDefinedContest;
  public
    { Public declarations }
    formMulti: TGeneralMulti2;
    procedure CalcPoints(var aQSO : TQSO);
    procedure AddNoUpdate(var aQSO : TQSO); override;
    procedure UpdateData; override;
    procedure Reset; override;
    procedure Add(var aQSO : TQSO); override; {calculates points}
    property FontSize: Integer read GetFontSize write SetFontSize;
    property Config: TUserDefinedContest read FConfig write FConfig;
  end;

implementation

uses
  Main, UzLogExtension;

{$R *.DFM}

procedure TGeneralScore.FormShow(Sender: TObject);
begin
   inherited;
   Button1.SetFocus;
   Grid.Col := 1;
   Grid.row := 1;
end;

procedure TGeneralScore.GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
   inherited;
   Draw_GridCell(TStringGrid(Sender), ACol, ARow, Rect);
end;

procedure TGeneralScore.UpdateData;
var
   band: TBand;
   TotQSO, TotPoints, TotMulti1, TotMulti2: LongInt;
   row: Integer;
   w: Integer;
   strScore: string;
   DispColCount: Integer;
   strExtraInfo: string;
   nScore: Integer;
begin
   Inherited;

   TotQSO := 0;
   TotPoints := 0;
   TotMulti1 := 0;
   TotMulti2 := 0;
   row := 1;

   // ���o���s
   Grid.Cells[0, 0] := 'MHz';
   Grid.Cells[1, 0] := 'QSOs';
   Grid.Cells[2, 0] := 'Points';
   Grid.Cells[3, 0] := 'Multi1';
   Grid.Cells[4, 0] := 'Multi2';
   Grid.Cells[5, 0] := EXTRAINFO_CAPTION[FExtraInfo];

   if ShowCWRatio then begin
      Grid.Cells[6, 0] := 'CW Q''s';
      Grid.Cells[7, 0] := 'CW %';
      DispColCount := 8;
   end
   else begin
      Grid.Cells[6, 0] := '';
      Grid.Cells[7, 0] := '';
      DispColCount := 6;
   end;

   // �o���h�ʃX�R�A�s
   for band := b19 to HiBand do begin
      TotQSO := TotQSO + QSO[band];
      TotPoints := TotPoints + Points[band];
      TotMulti1 := TotMulti1 + Multi[band];
      TotMulti2 := TotMulti2 + Multi2[band];

      if (MainForm.BandMenu.Items[Ord(band)].Visible = True) and
         (dmZlogGlobal.Settings._activebands[band] = True) then begin

         Grid.Cells[0, row] := '*' + MHzString[band];
         Grid.Cells[1, row] := IntToStr3(QSO[band]);
         Grid.Cells[2, row] := IntToStr3(Points[band]);

         if FConfig.NoMulti then begin
            Grid.Cells[3, row] := '-';
            Grid.Cells[4, row] := '-';
         end
         else begin
            Grid.Cells[3, row] := IntToStr3(Multi[band]);
            Grid.Cells[4, row] := IntToStr3(Multi2[band]);
         end;

         // Multi��
         strExtraInfo := '';
         case FExtraInfo of
            0: begin
               if QSO[band] > 0 then begin
                  strExtraInfo := FloatToStrF((Multi[band] / QSO[band] * 100), ffFixed, 1000, 1);
               end;
            end;

            1: begin
               if Multi[band] > 0 then begin
                  strExtraInfo := FloatToStrF((Points[band] / Multi[band]), ffFixed, 1000, 1);
               end;
            end;

            2: begin
               if QSO[band] > 0 then begin
                  strExtraInfo := FloatToStrF((Points[band] * Multi[band] / QSO[band]), ffFixed, 1000, 1);
               end;
            end;
         end;
         Grid.Cells[5, row] := strExtraInfo;

         // CW��
         if ShowCWRatio then begin
            Grid.Cells[6, row] := IntToStr3(CWQSO[band]);
            if QSO[band] > 0 then begin
               Grid.Cells[7, row] := FloatToStrF(100 * (CWQSO[band] / QSO[band]), ffFixed, 1000, 1);
            end
            else begin
               Grid.Cells[7, row] := '-';
            end;
         end
         else begin
            Grid.Cells[6, row] := '';
            Grid.Cells[7, row] := '';
         end;

         Inc(row);
      end;
   end;

   // ���v�s
   Grid.Cells[0, row] := 'Total';
   Grid.Cells[1, row] := IntToStr3(TotQSO);
   Grid.Cells[2, row] := IntToStr3(TotPoints);
   if FConfig.NoMulti then begin
      Grid.Cells[3, row] := '-';
      Grid.Cells[4, row] := '-';
   end
   else begin
      Grid.Cells[3, row] := IntToStr(TotMulti1);
      Grid.Cells[4, row] := IntToStr(TotMulti2);
   end;

   // Multi��
   strExtraInfo := '';
   case FExtraInfo of
      0: begin
         if TotQSO > 0 then begin
            strExtraInfo := FloatToStrF((TotMulti1 / TotQSO * 100), ffFixed, 1000, 1);
         end;
      end;

      1: begin
         if TotMulti1 > 0 then begin
            strExtraInfo := FloatToStrF((TotPoints / TotMulti1), ffFixed, 1000, 1);
         end;
      end;

      2: begin
         if TotQSO > 0 then begin
            strExtraInfo := FloatToStrF((TotPoints * TotMulti1 / TotQSO), ffFixed, 1000, 1);
         end;
      end;
   end;
   Grid.Cells[5, row] := strExtraInfo;

   // CW��
   if ShowCWRatio then begin
      Grid.Cells[6, row] := IntToStr3(TotalCWQSOs);
      if TotQSO > 0 then begin
         Grid.Cells[7, row] := FloatToStrF(100 * (TotalCWQSOs / TotQSO), ffFixed, 1000, 1);
      end
      else begin
         Grid.Cells[7, row] := '-';
      end;
   end
   else begin
      Grid.Cells[6, row] := '';
      Grid.Cells[7, row] := '';
   end;
   Inc(row);

   // �X�R�A�s
   if FConfig.NoMulti then begin
      strScore := IntToStr3(TotPoints);
   end
   else begin
      nScore := zyloRequestTotal(TotPoints, (TotMulti1 + TotMulti2));
      if nScore = -1 then begin
         nScore := TotPoints * (TotMulti1 + TotMulti2);
      end;
      strScore := IntToStr3(nScore);
   end;

   Grid.Cells[0, row] := 'Score';
   Grid.Cells[1, row] := '';
   Grid.Cells[2, row] := '';
   Grid.Cells[3, row] := strScore;
   Grid.Cells[4, row] := '';
   Grid.Cells[5, row] := '';
   Grid.Cells[6, row] := '';
   Grid.Cells[7, row] := '';
   Inc(row);

   // �s�����Z�b�g
   Grid.RowCount := row;

   // �J���������Z�b�g
   w := Grid.Canvas.TextWidth('9');
   Grid.ColWidths[0] := w * 6;
   Grid.ColWidths[1] := w * 7;
   Grid.ColWidths[2] := w * 7;
   Grid.ColWidths[3] := w * Max(8, Length(strScore)+1);
   Grid.ColWidths[4] := w * 7;
   Grid.ColWidths[5] := w * 7;
   Grid.ColWidths[6] := w * 7;
   Grid.ColWidths[7] := w * 7;

   // �O���b�h�T�C�Y����
   AdjustGridSize(Grid, DispColCount, Grid.RowCount);
end;

procedure TGeneralScore.CalcPoints(var aQSO: TQSO);
var
   i: Integer;
   ch: Char;
   C: TCountry;
begin
   if zyloRequestScore(aQSO) = True then begin
      Exit;
   end;

   aQSO.Points := FConfig.PointsTable[aQSO.band, aQSO.Mode];

   if FConfig.UseCtyDat then begin
      if FConfig.SameCTYPoints or FConfig.SameCONTPoints then begin
         i := aQSO.Power2;
         if (i < dmZLogGlobal.CountryList.Count) and (i >= 0) then begin
            C := TCountry(dmZLogGlobal.CountryList.List[i]);
            if FConfig.SameCTYPoints and (C.Country = dmZLogGlobal.MyCountry) then
               aQSO.Points := FConfig.SameCTYPointsTable[aQSO.band, aQSO.Mode]
            else if FConfig.SameCONTPoints and (C.Continent = dmZLogGlobal.MyContinent) then
               aQSO.Points := FConfig.SameCONTPointsTable[aQSO.band, aQSO.Mode];
         end;
      end;
   end;

   if formMulti.IsLocal(aQSO) then
      aQSO.Points := FConfig.LocalPointsTable[aQSO.band, aQSO.Mode];

   if FConfig.AlphabetPoints then begin
      aQSO.Points := 0;
      i := length(aQSO.NrRcvd);
      if i > 0 then begin
         ch := aQSO.NrRcvd[i];
         if CharInSet(ch, ['0' .. 'Z']) then
            aQSO.Points := FConfig.AlphabetPointsTable[ord(ch)];
      end;
   end;

   if FConfig.SpecialCalls <> '' then begin
      if pos(',' + aQSO.Callsign + ',', ',' + FConfig.SpecialCalls + ',') > 0 then
         aQSO.Points := FConfig.SpecialCallPointsTable[aQSO.band, aQSO.Mode];
   end;
end;

procedure TGeneralScore.AddNoUpdate(var aQSO: TQSO);
var
   i: Integer;
   tempQSO: TQSO;
begin
   inherited;

   if aQSO.Dupe then
      exit;

   CalcPoints(aQSO);

   if Log.CountHigherPoints = true then begin
      i := Log.DifferentModePointer;
      If i > 0 then begin
         if Log.QsoList[i].Points < aQSO.Points then begin
            tempQSO := Log.QsoList[i];
            Dec(Points[tempQSO.band], tempQSO.Points);
            Log.QsoList[i].Points := 0;
            // NeedRefresh := True;
         end
         else
            aQSO.Points := 0;
      end;
   end;

   inc(Points[aQSO.band], aQSO.Points);
end;

procedure TGeneralScore.Reset;
begin
   inherited;
end;

procedure TGeneralScore.Add(var aQSO: TQSO);
begin
   inherited;
end;

function TGeneralScore.GetFontSize(): Integer;
begin
   Result := Grid.Font.Size;
end;

procedure TGeneralScore.SetFontSize(v: Integer);
begin
   Inherited;
   SetGridFontSize(Grid, v);
   UpdateData();
end;

end.

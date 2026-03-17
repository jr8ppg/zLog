unit UJarlWorldWideRTTYMulti2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UBasicMulti, UMultipliers, StdCtrls, JLLabel, ExtCtrls, Grids,
  UComm, USpotClass, UzLogConst, UzLogGlobal, UzLogQSO, UWWMulti;

const
  WM_ZLOG_UPDATELABEL = (WM_USER + 100);

type
  TJarlWorldWideRTTYMulti2 = class(TBasicMulti)
    Panel: TPanel;
    RotateLabel2: TRotateLabel;
    RotateLabel3: TRotateLabel;
    RotateLabel4: TRotateLabel;
    RotateLabel5: TRotateLabel;
    RotateLabel6: TRotateLabel;
    Grid: TStringGrid;
    Panel1: TPanel;
    buttonGo: TButton;
    Edit1: TEdit;
    StayOnTop: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure GoButtonClick(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure GridDrawCell(Sender: TObject; ACol, ARow: LongInt; Rect: TRect; State: TGridDrawState);
    procedure StayOnTopClick(Sender: TObject);
    procedure GridTopLeftChanged(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Edit1Enter(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
  protected
    procedure SetFontSize(v: Integer); override;
    procedure OnZLogUpdateLabel( var Message: TMessage ); message WM_ZLOG_UPDATELABEL;
    procedure UpdateLabelPos(); virtual;
  private
    { Private declarations }
    FCallAreaList: TCountryList;
    procedure GoForwardMatch(strCode: string);
  public
    { Public declarations }
    procedure RefreshGrid;
    procedure Reset; override;
    procedure AddNoUpdate(aQSO: TQSO); override;
    procedure UpdateData; override;
  end;

implementation

uses
  Main, UJarlWorldWideRTTYMulti;

{$R *.DFM}

procedure TJarlWorldWideRTTYMulti2.FormCreate(Sender: TObject);
begin
   { inherited; }
   FCallAreaList := TCountryList.Create();

   FCallAreaList.Add(TCountry.Create('Japan(Area 0):25:45:AS:::9:JA0:JA'));
   FCallAreaList.Add(TCountry.Create('Japan(Area 1):25:45:AS:::9:JA1:JA'));
   FCallAreaList.Add(TCountry.Create('Japan(Area 2):25:45:AS:::9:JA2:JA'));
   FCallAreaList.Add(TCountry.Create('Japan(Area 3):25:45:AS:::9:JA3:JA'));
   FCallAreaList.Add(TCountry.Create('Japan(Area 4):25:45:AS:::9:JA4:JA'));
   FCallAreaList.Add(TCountry.Create('Japan(Area 5):25:45:AS:::9:JA5:JA'));
   FCallAreaList.Add(TCountry.Create('Japan(Area 6):25:45:AS:::9:JA6:JA'));
   FCallAreaList.Add(TCountry.Create('Japan(Area 7):25:45:AS:::9:JA7:JA'));
   FCallAreaList.Add(TCountry.Create('Japan(Area 8):25:45:AS:::9:JA8:JA'));
   FCallAreaList.Add(TCountry.Create('Japan(Area 9):25:45:AS:::9:JA9:JA'));
   FCallAreaList.Add(TCountry.Create('United States(Area 0):04:07:NA:::0:K0:K'));
   FCallAreaList.Add(TCountry.Create('United States(Area 1):05:08:NA:::0:K1:K'));
   FCallAreaList.Add(TCountry.Create('United States(Area 2):05:08:NA:::0:K2:K'));
   FCallAreaList.Add(TCountry.Create('United States(Area 3):05:08:NA:::0:K3:K'));
   FCallAreaList.Add(TCountry.Create('United States(Area 4):05:08:NA:::0:K4:K'));
   FCallAreaList.Add(TCountry.Create('United States(Area 5):04:07:NA:::0:K5:K'));
   FCallAreaList.Add(TCountry.Create('United States(Area 6):03:06:NA:::0:K6:K'));
   FCallAreaList.Add(TCountry.Create('United States(Area 7):03:06:NA:::0:K7:K'));
   FCallAreaList.Add(TCountry.Create('United States(Area 8):04:06:NA:::0:K8:K'));
   FCallAreaList.Add(TCountry.Create('United States(Area 9):04:06:NA:::0:K9:K'));
   FCallAreaList.Add(TCountry.Create('Canada (Area 0):05:09:NA:::0:VE0:VE'));
   FCallAreaList.Add(TCountry.Create('Canada (Area 1):05:09:NA:::0:VE1:VE'));
   FCallAreaList.Add(TCountry.Create('Canada (Area 2):05:04:NA:::0:VE2:VE'));
   FCallAreaList.Add(TCountry.Create('Canada (Area 3):04:04:NA:::0:VE3:VE'));
   FCallAreaList.Add(TCountry.Create('Canada (Area 4):04:03:NA:::0:VE4:VE'));
   FCallAreaList.Add(TCountry.Create('Canada (Area 5):04:03:NA:::0:VE5:VE'));
   FCallAreaList.Add(TCountry.Create('Canada (Area 6):04:02:NA:::0:VE6:VE'));
   FCallAreaList.Add(TCountry.Create('Canada (Area 7):03:02:NA:::0:VE7:VE'));
   FCallAreaList.Add(TCountry.Create('Canada (Area 8):01:03:NA:::0:VE8:VE'));
   FCallAreaList.Add(TCountry.Create('Canada (Area 9):05:09:NA:::0:VE9:VE'));
   FCallAreaList.Add(TCountry.Create('Australia (Area 1):30:59:OC:::0:VK1:VK'));
   FCallAreaList.Add(TCountry.Create('Australia (Area 2):30:59:OC:::0:VK2:VK'));
   FCallAreaList.Add(TCountry.Create('Australia (Area 3):30:59:OC:::0:VK3:VK'));
   FCallAreaList.Add(TCountry.Create('Australia (Area 4):30:55:OC:::0:VK4:VK'));
   FCallAreaList.Add(TCountry.Create('Australia (Area 5):30:59:OC:::0:VK5:VK'));
   FCallAreaList.Add(TCountry.Create('Australia (Area 6):29:58:OC:::0:VK6:VK'));
   FCallAreaList.Add(TCountry.Create('Australia (Area 7):30:59:OC:::0:VK7:VK'));
   FCallAreaList.Add(TCountry.Create('Australia (Area 8):29:55:OC:::0:VK8:VK'));

   Reset;
end;

procedure TJarlWorldWideRTTYMulti2.FormDestroy(Sender: TObject);
begin
   inherited;
   FCallAreaList.Free();
end;

procedure TJarlWorldWideRTTYMulti2.FormResize(Sender: TObject);
begin
   Inherited;
   AdjustGridSize(Grid);
   RefreshGrid;
end;

procedure TJarlWorldWideRTTYMulti2.FormShow(Sender: TObject);
begin
   inherited;
   AdjustGridSize(Grid);
   UpdateData();
   PostMessage(Handle, WM_ZLOG_UPDATELABEL, 0, 0);
end;

procedure TJarlWorldWideRTTYMulti2.GoButtonClick(Sender: TObject);
begin
   GoForwardMatch(Edit1.Text);
end;

procedure TJarlWorldWideRTTYMulti2.GoForwardMatch(strCode: string);
var
   i: Integer;
   l: Integer;
begin
   l := Length(strCode);
   for i := 0 to dmZLogGlobal.CountryList.Count - 1 do begin
      if (strCode = Copy(TCountry(FCallAreaList.List[i]).Country, 1, l)) then begin
         Grid.TopRow := i;
         Break;
      end;
   end;
end;

procedure TJarlWorldWideRTTYMulti2.GridDrawCell(Sender: TObject; ACol, ARow: LongInt; Rect: TRect; State: TGridDrawState);
begin
   inherited;
   Draw_GridCell(Grid, ACol, ARow, Rect);
end;

procedure TJarlWorldWideRTTYMulti2.GridTopLeftChanged(Sender: TObject);
begin
   RefreshGrid;
end;

procedure TJarlWorldWideRTTYMulti2.Edit1Change(Sender: TObject);
begin
   inherited;
   GoForwardMatch(Edit1.Text);
end;

procedure TJarlWorldWideRTTYMulti2.Edit1Enter(Sender: TObject);
begin
   buttonGo.Default := True;
end;

procedure TJarlWorldWideRTTYMulti2.Edit1Exit(Sender: TObject);
begin
   buttonGo.Default := True;
end;

procedure TJarlWorldWideRTTYMulti2.RefreshGrid;
var
   i: integer;
   C: TCountry;
   B: TBand;
begin
   B := Main.CurrentQSO.Band;
   if B = bUnknown then begin
      Exit;
   end;

   BeginUpdate();

   for i := Grid.TopRow to Grid.TopRow + Grid.VisibleRowCount - 1 do begin
      if (i > Grid.RowCount - 1) then begin
         exit;
      end
      else begin
         C := TCountry(FCallAreaList.List[i]);
         if (i >= 0) and (i < FCallAreaList.Count) then begin
            if C.Worked[B] = True then begin
               Grid.Cells[0, i] := '~' + C.Summary;
            end
            else begin
               Grid.Cells[0, i] := C.Summary;
            end;
         end
         else begin
            Grid.Cells[0, i] := '';
         end;
      end;
   end;

   EndUpdate();

   Grid.Refresh();
end;

procedure TJarlWorldWideRTTYMulti2.Reset;
var
   i: Integer;
   B: TBand;
begin
   for i := 0 to FCallAreaList.Count - 1 do begin
      for B := b19 to HiBand do begin
         TCountry(FCallAreaList.List[i]).Worked[B] := False;
      end;
   end;

   Grid.RowCount := FCallAreaList.Count;
end;

procedure TJarlWorldWideRTTYMulti2.UpdateData;
begin
   RefreshGrid;
end;

procedure TJarlWorldWideRTTYMulti2.AddNoUpdate(aQSO: TQSO);
var
   C: TCountry;
   B: TBand;
   i: Integer;
begin
   if aQSO.Multi2 = '' then begin
      Exit;
   end;

   B := aQSO.Band;

   for i := 0 to FCallAreaList.Count - 1 do begin
      C := FCallAreaList[i];
      if C.Country = aQSO.Multi2 then begin
         C.Worked[B] := True;
      end;
   end;
end;

procedure TJarlWorldWideRTTYMulti2.StayOnTopClick(Sender: TObject);
begin
   if StayOnTop.Checked then
      FormStyle := fsStayOnTop
   else
      FormStyle := fsNormal;
end;

procedure TJarlWorldWideRTTYMulti2.SetFontSize(v: Integer);
begin
   Inherited;
   SetGridFontSize(Grid, v);
   UpdateLabelPos();
   UpdateData();
end;

procedure TJarlWorldWideRTTYMulti2.UpdateLabelPos();
var
   w, l: Integer;
begin
   w := Grid.Canvas.TextWidth('X');
   l := (w * 42) - 2;
   RotateLabel2.Left := l;
   RotateLabel3.Left := RotateLabel2.Left + (w * 2);
   RotateLabel4.Left := RotateLabel3.Left + (w * 2);
   RotateLabel5.Left := RotateLabel4.Left + (w * 2);
   RotateLabel6.Left := RotateLabel5.Left + (w * 2);
end;

procedure TJarlWorldWideRTTYMulti2.OnZLogUpdateLabel( var Message: TMessage );
begin
   Application.ProcessMessages();
   UpdateLabelPos();
end;

end.

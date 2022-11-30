unit UALLJAMulti;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, ComCtrls,
  UzLogConst, UzLogGlobal, UzLogQSO, UBasicMulti, JLLabel, Vcl.Grids;

const
  WM_ZLOG_UPDATEALLLIST = (WM_USER + 100);

type
  TKen = (
    m101,m102,m103,m104,m105,m106,m107,
    m108,m109,m110,m111,m112,m113,m114,
    m02,m03,m04,m05,m06,m07,m08,m09,m10,m11,
    m12,m13,m14,m15,m16,m17,m18,m19,m20,m21,
    m22,m23,m24,m25,m26,m27,m28,m29,m30,m31,
    m32,m33,m34,m35,m36,m37,m38,m39,m40,m41,
    m42,m43,m44,m45,m46,m47,m48, mError
  );

  TALLJAMulti = class(TBasicMulti)
    PageControl: TPageControl;
    Tab35: TTabSheet;
    Tab7: TTabSheet;
    Tab14: TTabSheet;
    Tab21: TTabSheet;
    Tab28: TTabSheet;
    Tab50: TTabSheet;
    TabALL: TTabSheet;
    Panel: TPanel;
    RotateLabel2: TRotateLabel;
    RotateLabel3: TRotateLabel;
    RotateLabel4: TRotateLabel;
    RotateLabel5: TRotateLabel;
    RotateLabel6: TRotateLabel;
    RotateLabel7: TRotateLabel;
    Panel1: TPanel;
    Button2: TButton;
    cbStayOnTop: TCheckBox;
    Tab19: TTabSheet;
    RotateLabel1: TRotateLabel;
    Grid: TStringGrid;
    procedure PageControlChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbStayOnTopClick(Sender: TObject);
    procedure GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure FormResize(Sender: TObject);
  protected
    procedure SetFontSize(v: Integer); override;
    procedure OnZLogUpdateAllList( var Message: TMessage ); message WM_ZLOG_UPDATEALLLIST;
  private
    { Private declarations }
    KenLabels: array[b19..b50, m101..m48] of TLabel;
    MultiTable: array[b19..b50, m101..m48] of Boolean;
    function KenToInt(strKenCode: string): TKen;
    procedure DeletePowerCode(var strMulti: string);
    function HasPowerCode(strMulti: string): Boolean;
    procedure InitKenLabels();
    procedure InitAllList();
    procedure UpdateKenLabels();
    procedure UpdateAllList();
    procedure SelectBandTab(band: TBand; fInit: Boolean);
  public
    { Public declarations }
    procedure UpdateBand(B : TBand);
    procedure UpdateData; override;
    procedure AddNoUpdate(var aQSO : TQSO); override;
    procedure Add(var aQSO : TQSO); override;
    procedure Reset; override;
    function ValidMulti(aQSO : TQSO) : Boolean; override;
    procedure CheckMulti(aQSO : TQSO); override;
    function ExtractMulti(aQSO : TQSO) : string; override;
    function IsNewMulti(aQSO : TQSO) : Boolean; override;
    procedure SetNumberEditFocus; override;
  end;

const
  KenNames: array[m101..m48] of string = (
    '101 è@íJ', '102 óØñG', '103 è„êÏ',  '104 µŒ∞¬∏', '105 ãÛím', '106 êŒéÎ', '107 ç™é∫',
    '108 å„éu', '109 è\èü', '110 ã˙òH',  '111 ì˙çÇ',  '112 í_êU', '113 ïOéR', '114 ìnìá',
    '02  ê¬êX', '03  ä‚éË', '04  èHìc',  '05  éRå`',  '06  ã{èÈ', '07  ïüìá', '08  êVäÉ',
    '09  í∑ñÏ', '10  ìåãû', '11  ê_ìﬁêÏ','12  êÁót',  '13  çÈã ', '14  àÔèÈ', '15  ì»ñÿ',
    '16  åQîn', '17  éRóú', '18  ê√â™',  '19  äÚïå',  '20  à§ím', '21  éOèd', '22  ãûìs',
    '23  é†âÍ', '24  ìﬁó«', '25  ëÂç„',  '26  òaâÃéR','27  ï∫å…', '28  ïxéR', '29  ïüà‰',
    '30  êŒêÏ', '31  â™éR', '32  ìáç™',  '33  éRå˚',  '34  íπéÊ', '35  çLìá', '36  çÅêÏ',
    '37  ìøìá', '38  à§ïQ', '39  çÇím',  '40  ïüâ™',  '41  ç≤âÍ', '42  í∑çË', '43  åFñ{',
    '44  ëÂï™', '45  ã{çË', '46  é≠éôìá','47  â´ìÍ',  '48  è¨ä}å¥'
  );

implementation

uses
  Main;

{$R *.DFM}

procedure TALLJAMulti.FormCreate(Sender: TObject);
begin
   InitKenLabels();
   UpdateKenLabels();
   InitAllList();
   UpdateAllList();
end;

procedure TALLJAMulti.FormResize(Sender: TObject);
begin
   inherited;
   AdjustGridSize(Grid);
end;

procedure TALLJAMulti.FormShow(Sender: TObject);
begin
   inherited;
   SelectBandTab(Main.CurrentQSO.band, True);
   AdjustGridSize(Grid);
end;

procedure TALLJAMulti.InitKenLabels();
var
   band: TBand;
   ken: TKen;
begin
   for band := b19 to b50 do begin
      for ken := m101 to m48 do begin
         MultiTable[band, ken] := False;
         KenLabels[band, ken] := TLabel.Create(Self);
      end;
   end;
end;

procedure TALLJAMulti.UpdateKenLabels();
var
   band: TBand;
   ken: TKen;
   x, y: integer;
   w, h: Integer;
begin
   for band := b19 to b50 do begin
      if NotWARC(band) then begin
         for x := 1 to 5 do begin
            for y := 1 to 16 do begin
               ken := TKen(16 * (x - 1) + y - 1);
               if ken <= m48 then begin
                  KenLabels[band, ken].Font.Name := PageControl.Font.Name;
                  KenLabels[band, ken].Font.Size := FFontSize;
                  KenLabels[band, ken].ParentFont := False;
                  KenLabels[band, ken].Parent := PageControl.Pages[OldBandOrd(band) + 1];
                  KenLabels[band, ken].Font.Color := clBlack;
                  KenLabels[band, ken].Caption := KenNames[ken];

                  w := KenLabels[band, ken].Canvas.TextWidth('X') * 12;
                  h := KenLabels[band, ken].Canvas.TextHeight('X') + 4;

                  KenLabels[band, ken].Left := 8 + w * (x - 1);
                  KenLabels[band, ken].Top := 8 + h * (y - 1);
               end;
            end;
         end;
      end;
   end;
end;

procedure TALLJAMulti.InitAllList();
var
   ken: TKen;
begin
   Grid.RowCount := Length(KenNames);
   for ken := m101 to m48 do begin
      Grid.Cells[0, Ord(ken)] := FillRight(KenNames[ken], 14) + '. . . . . . . ';
   end;
end;

procedure TALLJAMulti.UpdateAllList();
var
   w, l: Integer;
begin
   w := Grid.Canvas.TextWidth('X');
   l := (w * 14) - 2;
   RotateLabel1.Left := l;
   RotateLabel2.Left := RotateLabel1.Left + (w * 2);
   RotateLabel3.Left := RotateLabel2.Left + (w * 2);
   RotateLabel4.Left := RotateLabel3.Left + (w * 2);
   RotateLabel5.Left := RotateLabel4.Left + (w * 2);
   RotateLabel6.Left := RotateLabel5.Left + (w * 2);
   RotateLabel7.Left := RotateLabel6.Left + (w * 2);
end;

procedure TALLJAMulti.SelectBandTab(band: TBand; fInit: Boolean);
begin
   if band in [b19, b35, b7, b14, b21, b28, b50] then begin
      if fInit = True then begin
         PageControl.ActivePage := PageControl.Pages[OldBandOrd(band) + 1];
      end
      else begin
         if PageControl.ActivePage <> TabALL then begin
            PageControl.ActivePage := PageControl.Pages[OldBandOrd(band) + 1];
         end;
      end;
   end
   else begin
      PageControl.ActivePage := TabALL;
   end;
end;

procedure TALLJAMulti.UpdateBand(B : TBand);
var
   K : TKen;
begin
   for K := m101 to m48 do begin
      if MultiTable[B, K] then
         KenLabels[B, K].Font.Color := clRed
      else
         KenLabels[B, K].Font.Color := clBlack;
   end;
end;

procedure TALLJAMulti.UpdateData;
var
   band, B: TBand;
   str: string;
   K: TKen;
   fWorked: Boolean;
begin
   // inherited;
   band := Main.CurrentQSO.band;
   SelectBandTab(band, False);

   // BANDÉ^Éu
   if PageControl.ActivePage <> TabALL then begin
      UpdateBand(band);
   end;

   // ALL
   for K := m101 to m48 do begin
      fWorked := False;
      str := FillRight(KenNames[K], 14);
      for B := b19 to b50 do begin
         if NotWARC(B) then begin
            if MultiTable[B, K] then begin
               str := str + '* ';

               if B = band then begin
                  fWorked := True;
               end;
            end
            else begin
               str := str + '. ';
            end;
         end;
      end;

      if fWorked = True then begin
         str := '~' + str;
      end;

      Grid.Cells[0, Ord(K)] := str;
   end;
end;

function TALLJAMulti.ExtractMulti(aQSO: TQSO): string;
var
   str: string;
begin
   Result := '';

   str := aQSO.NrRcvd;
   if str = '' then begin
      Exit;
   end;

   DeletePowerCode(str);

   Result := str;
end;

procedure TALLJAMulti.AddNoUpdate(var aQSO: TQSO);
var
   str: string;
   K: TKen;
begin
   aQSO.NewMulti1 := False;

   str := aQSO.NrRcvd;
   Delete(str, length(str), 1);
   aQSO.Multi1 := str;

   if aQSO.Dupe then begin
      Exit;
   end;

   if not(NotWARC(aQSO.band)) then begin
      Exit;
   end;

   K := KenToInt(str);
   if K = mError then begin
      Exit;
   end;

   if MultiTable[aQSO.band, K] = False then begin
      MultiTable[aQSO.band, K] := True;
      aQSO.NewMulti1 := True;
   end;
end;

procedure TALLJAMulti.Add(var aQSO: TQSO);
begin
   inherited;
end;

procedure TALLJAMulti.PageControlChange(Sender: TObject);
begin
   case PageControl.ActivePage.Tag of
      ord(b19) .. ord(b50):
         UpdateBand(TBand(PageControl.ActivePage.Tag));
      else
         PostMessage(Handle, WM_ZLOG_UPDATEALLLIST, 0, 0);
   end;

   MainForm.SetLastFocus();
end;

procedure TALLJAMulti.Reset;
var
   band: TBand;
   ken: TKen;
begin
   for band := b19 to b50 do begin
      if NotWARC(band) then begin
         for ken := m101 to m48 do begin
            MultiTable[band, ken] := False;
         end;
      end;
   end;
end;

function TALLJAMulti.ValidMulti(aQSO: TQSO): Boolean;
var
   str: string;
   K: TKen;
begin
   Result := False;

   str := aQSO.NrRcvd;
   if not(length(str) in [3 .. 4]) then begin
      Exit;
   end;

   if HasPowerCode(str) = False then begin
      Exit;
   end;

   DeletePowerCode(str);

   K := KenToInt(str);
   if K = mError then begin
      Result := False;
   end
   else begin
      Result := True;
   end;
end;

procedure TALLJAMulti.Button2Click(Sender: TObject);
begin
   Close;
end;

function TALLJAMulti.IsNewMulti(aQSO: TQSO): Boolean;
var
   K: TKen;
   str: string;
begin
   Result := False;

   str := aQSO.NrRcvd;
   if str = '' then begin
      Exit;
   end;

   DeletePowerCode(str);

   K := KenToInt(str);
   if K = mError then begin
      Exit;
   end;

   if MultiTable[aQSO.band, K] = False then begin
      Result := True;
   end;
end;

procedure TALLJAMulti.CheckMulti(aQSO: TQSO);
var
   str: string;
   strKen: string;
   strWorkedOn: string;
   K: TKen;
   B: TBand;
begin
   str := aQSO.NrRcvd;
   if str = '' then begin
      Exit;
   end;

   DeletePowerCode(str);

   K := KenToInt(str);
   if K = mError then begin
      MainForm.WriteStatusLine(TMainForm_Invalid_number, False);
      Exit;
   end;

   // ìsìπï{åßñº
   strKen := KenNames[K];

   // åêMçœÇ›ÉoÉìÉh
   strWorkedOn := '';
   for B := b19 to b50 do begin
      if MultiTable[B, K] then begin
         strWorkedOn := strWorkedOn + ' ' + MHzString[B];
      end;
   end;
   if strWorkedOn <> '' then begin
      strWorkedOn := 'Worked on:' + strWorkedOn;
   end;

   if MultiTable[aQSO.band, K] = True then begin
      str := Format('[%s] Worked on this band. %s', [strKen, strWorkedOn]);
   end
   else begin
      str := Format('[%s] Needed on this band. %s', [strKen, strWorkedOn]);
   end;

   MainForm.WriteStatusLine(str, False);
end;

procedure TALLJAMulti.cbStayOnTopClick(Sender: TObject);
begin
   if cbStayOnTop.Checked then
      Self.FormStyle := fsStayOnTop
   else
      Self.FormStyle := fsNormal;
end;

procedure TALLJAMulti.SetNumberEditFocus;
begin
   SetNumberEditFocusJARL;
end;

function TALLJAMulti.KenToInt(strKenCode: string): TKen;
var
   M: Integer;
begin
   M := StrToIntDef(strKenCode, 0);
   case M of
      101 .. 114: begin
         Result := TKen(M - 101);
      end;

      2 .. 48: begin
         Result := TKen(M - 2 + ord(m02));
      end

      else begin
         Result := mError;
      end;
   end;
end;

procedure TALLJAMulti.DeletePowerCode(var strMulti: string);
begin
   if HasPowerCode(strMulti) = True then begin
      Delete(strMulti, Length(strMulti), 1);
   end;
end;

function TALLJAMulti.HasPowerCode(strMulti: string): Boolean;
var
   ch: Char;
begin
   ch := strMulti[Length(strMulti)];
   if CharInSet(ch, ['P', 'L', 'M', 'H']) then begin
      Result := True;
   end
   else begin
      Result := False;
   end;
end;

procedure TALLJAMulti.SetFontSize(v: Integer);
begin
   Inherited;
   SetGridFontSize(Grid, v);
   UpdateKenLabels();
   UpdateAllList();
   UpdateData();
end;

procedure TALLJAMulti.GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
   Inherited;
   Draw_GridCell(Grid, ACol, ARow, Rect);
end;

procedure TALLJAMulti.OnZLogUpdateAllList( var Message: TMessage );
begin
   Application.ProcessMessages();
   UpdateAllList();
end;

end.

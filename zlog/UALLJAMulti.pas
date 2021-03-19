unit UALLJAMulti;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, ComCtrls,
  UzLogConst, UzLogGlobal, UzLogQSO, UBasicMulti, JLLabel;

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
    ListBox: TListBox;
    Panel1: TPanel;
    Button2: TButton;
    cbStayOnTop: TCheckBox;
    Tab19: TTabSheet;
    RotateLabel1: TRotateLabel;
    procedure PageControlChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbStayOnTopClick(Sender: TObject);
  protected
    procedure SetFontSize(v: Integer); override;
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
    '101 @J', '102 ―G', '103 γμ',  '104 Τ',  '105 σm', '106 Ξλ', '107 ͺΊ',
    '108 γu', '109 \', '110 ϊH',  '111 ϊ',  '112 _U', '113 OR', '114 n',
    '02  ΒX', '03  βθ', '04  Hc',  '05  R`',  '06  {ι', '07  ', '08  V',
    '09  ·μ', '10  ', '11  _ήμ','12  ηt',  '13  ιΚ', '14  οι', '15  ΘΨ',
    '16  Qn', '17  R', '18  Γͺ',  '19  ς',  '20  €m', '21  Od', '22  s',
    '23   κ', '24  ήΗ', '25  εγ',  '26  aΜR','27  ΊΙ', '28  xR', '29  δ',
    '30  Ξμ', '31  ͺR', '32  ͺ',  '33  Rϋ',  '34  Ήζ', '35  L', '36  μ',
    '37  Ώ', '38  €Q', '39  m',  '40  ͺ',  '41  ²κ', '42  ·θ', '43  F{',
    '44  εͺ', '45  {θ', '46  ­','47  «κ',  '48  ¬}΄'
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

procedure TALLJAMulti.FormShow(Sender: TObject);
begin
   inherited;
   SelectBandTab(Main.CurrentQSO.band, True);
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
   ListBox.Font.Size := FFontSize;
   ListBox.Canvas.Font.Name := ListBox.Font.Name;
   ListBox.Canvas.Font.Size := ListBox.Font.Size;

   for ken := m101 to m48 do begin
      ListBox.Items.Add(FillRight(KenNames[ken], 14) + '. . . . . . . ');
   end;
end;

procedure TALLJAMulti.UpdateAllList();
var
   w, l: Integer;
begin
   ListBox.Font.Size := FFontSize;
   ListBox.Canvas.Font.Size := FFontSize;

   w := ListBox.Canvas.TextWidth('X');
   l := w * 14;
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
begin
   // inherited;
   band := Main.CurrentQSO.band;
   SelectBandTab(band, False);

   // BAND^u
   if PageControl.ActivePage <> TabALL then begin
      UpdateBand(band);
   end;

   // ALL
   for K := m101 to m48 do begin
      str := FillRight(KenNames[K], 14);
      for B := b19 to b50 do begin
         if NotWARC(B) then begin
            if MultiTable[B, K] then
               str := str + '* '
            else
               str := str + '. ';
         end;
      end;
      ListBox.Items[ord(K)] := str;
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
         Update;
   end;

   MainForm.LastFocus.SetFocus;
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
      MainForm.WriteStatusLine('Invalid number', False);
      Exit;
   end;

   str := KenNames[K];

   if MultiTable[aQSO.band, K] = True then
      str := str + '   Worked on this band. Worked on : '
   else
      str := str + '   Needed on this band. Worked on : ';

   for B := b19 to b50 do begin
      if MultiTable[B, K] then
         str := str + MHzString[B] + ' '
      else
         str := str + '';
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
   UpdateKenLabels();
   UpdateAllList();
   UpdateData();
end;

end.

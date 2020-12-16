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
  private
    { Private declarations }
    KenLabels: array[b19..b50, m101..m48] of TLabel;
    MultiTable: array[b19..b50, m101..m48] of Boolean;
    function KenToInt(strKenCode: string): TKen;
    procedure DeletePowerCode(var strMulti: string);
    function HasPowerCode(strMulti: string): Boolean;
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
    '101 @’J', '102 —¯–G', '103 ãì',  '104 –Ô‘–',  '105 ‹ó’m', '106 Îë', '107 ªº',
    '108 Œãu', '109 \Ÿ', '110 ‹ú˜H',  '111 “ú‚',  '112 ’_U', '113 •OR', '114 “n“‡',
    '02  ÂX', '03  Šâè', '04  H“c',  '05  RŒ`',  '06  ‹{é', '07  •Ÿ“‡', '08  VŠƒ',
    '09  ’·–ì', '10  “Œ‹', '11  _“Şì','12  ç—t',  '13  é‹Ê', '14  ˆïé', '15  “È–Ø',
    '16  ŒQ”n', '17  R—œ', '18  Ã‰ª',  '19  Šò•Œ',  '20  ˆ¤’m', '21  Od', '22  ‹“s',
    '23   ‰ê', '24  “Ş—Ç', '25  ‘åã',  '26  ˜a‰ÌR','27  •ºŒÉ', '28  •xR', '29  •Ÿˆä',
    '30  Îì', '31  ‰ªR', '32  “‡ª',  '33  RŒû',  '34  ’¹æ', '35  L“‡', '36  ì',
    '37  “¿“‡', '38  ˆ¤•Q', '39  ‚’m',  '40  •Ÿ‰ª',  '41  ²‰ê', '42  ’·è', '43  ŒF–{',
    '44  ‘å•ª', '45  ‹{è', '46  ­™“‡','47  ‰«“ê',  '48  ¬Š}Œ´'
  );

implementation

uses
  Main;

{$R *.DFM}

procedure TALLJAMulti.FormCreate(Sender: TObject);
var
   band: TBand;
   ken: TKen;
   x, y: integer;
begin
   for band := b19 to b50 do begin
      for ken := m101 to m48 do begin
         MultiTable[band, ken] := False;
      end;
      if NotWARC(band) then begin
         for x := 1 to 5 do begin
            for y := 1 to 16 do begin
               ken := TKen(16 * (x - 1) + y - 1);
               if ken <= m48 then begin
                  KenLabels[band, ken] := TLabel.Create(Self);
                  KenLabels[band, ken].Font.Size := 9;
                  KenLabels[band, ken].ParentFont := True;
                  KenLabels[band, ken].Parent := PageControl.Pages[OldBandOrd(band)];
                  KenLabels[band, ken].Font.Color := clBlack;
                  KenLabels[band, ken].Left := 77 * (x - 1) + 8;
                  KenLabels[band, ken].Top := 8 + 16 * (y - 1);
                  KenLabels[band, ken].Caption := KenNames[ken];
               end;
            end;
         end;
      end;
   end;

   for ken := m101 to m48 do begin
      ListBox.Items.Add(FillRight(KenNames[ken], 14) + '. . . . . . . ');
   end;
end;

procedure TALLJAMulti.FormShow(Sender: TObject);
begin
   inherited;

   if Main.CurrentQSO.band in [b19, b35, b7, b14, b21, b28, b50] then begin
      PageControl.ActivePage := PageControl.Pages[OldBandOrd(Main.CurrentQSO.band)];
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
   if not(band in [b19, b35, b7, b14, b21, b28, b50]) then
      band := b35;

   if PageControl.ActivePage <> TabALL then begin
      PageControl.ActivePage := PageControl.Pages[OldBandOrd(band)];
      UpdateBand(band);
   end
   else begin
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

end.

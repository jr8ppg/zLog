unit USummaryInfo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, UzLogConst, UzLogGlobal, UzLogQSO;

type
  TSummaryInfo = class(TForm)
    CategoryEdit: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    NameEdit: TEdit;
    Label4: TLabel;
    ContestNameEdit: TEdit;
    Button1: TButton;
    Button2: TButton;
    Label6: TLabel;
    RemMemo: TMemo;
    Label8: TLabel;
    CountryEdit: TEdit;
    Label5: TLabel;
    DecMemo: TMemo;
    Label9: TLabel;
    Label10: TLabel;
    MiscMemo: TMemo;
    AddrMemo: TMemo;
    CallEdit: TEdit;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure DecEnglish;
    procedure DecJapanese;
  end;

implementation

{$R *.DFM}

procedure TSummaryInfo.DecEnglish;
begin
   DecMemo.Clear;
   DecMemo.Lines.Add('This is to certify that in this contest I have operated my transmitter');
   DecMemo.Lines.Add('within the limitations of my license and have fully observed the');
   DecMemo.Lines.Add('rules and regulations of the contest.');
end;

procedure TSummaryInfo.DecJapanese;
begin
   DecMemo.Clear;
   DecMemo.Lines.Add('私は、コンテスト規約および電波法令にしたがい運用した結果');
   DecMemo.Lines.Add('ここに提出するサマリーシートおよびログシートが事実と相違');
   DecMemo.Lines.Add('ないものであることを、私の名誉において誓います。');
end;

procedure TSummaryInfo.FormShow(Sender: TObject);
var
   str : string;
   Y, M, D : word;
begin
   if TQSO(Log.List[0]).RSTSent = 0 then begin // JST = 0; UTC = $FFFF
      DecJapanese;
   end
   else begin
      DecEnglish;
   end;

   if Log.TotalQSO > 0 then begin
      DecodeDate(TQSO(Log.List[1]).Time, Y, M, D);
   end
   else begin
      DecodeDate(Date, Y, M, D);
   end;

   if ContestNameEdit.Text = '' then begin
      ContestNameEdit.Text := TQSO(Log.List[0]).memo + ' ' + IntToStr(Y);
   end;

   if CallEdit.Text = '' then begin
      CallEdit.Text := dmZlogGlobal.Settings._mycall;
   end;

   if dmZlogGlobal.Settings._multiop > 0 then begin
      str := 'Multi-op ';
   end
   else begin
      str := 'Single-op ';
   end;

   if dmZlogGlobal.Settings._band = 0 then begin
      str := str + 'All band ';
   end
   else begin
      str := str + BandString[TBand(dmZlogGlobal.Settings._band - 1)] + ' ';
   end;

   case dmZlogGlobal.Settings._mode of
      0 : str := str + 'Mixed';
      1 : str := str + 'CW';
      2 : str := str + 'Ph';
   end;

   if CategoryEdit.Text = '' then begin
      CategoryEdit.Text := str;
   end;
end;

end.

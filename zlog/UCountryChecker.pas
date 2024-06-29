unit UCountryChecker;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.ValEdit, Vcl.StdCtrls,
  Vcl.WinXCtrls;

type
  TformCountryChecker = class(TForm)
    Label1: TLabel;
    SearchBox1: TSearchBox;
    vleCountryInfo: TValueListEditor;
    vlePrefixInfo: TValueListEditor;
    Label2: TLabel;
    Label3: TLabel;
    procedure SearchBox1InvokeSearch(Sender: TObject);
    procedure SearchBox1Change(Sender: TObject);
  private
    { Private êÈåæ }
  public
    { Public êÈåæ }
  end;

implementation

uses
  UzLogGlobal, UMultipliers;

{$R *.dfm}

procedure TformCountryChecker.SearchBox1Change(Sender: TObject);
begin
   if SearchBox1.Text = '' then begin
      vleCountryInfo.Strings.Clear();
      vlePrefixInfo.Strings.Clear();
   end;
end;

procedure TformCountryChecker.SearchBox1InvokeSearch(Sender: TObject);
var
   P: TPrefix;
   C: TCountry;
begin
   vleCountryInfo.Strings.Clear();
   vlePrefixInfo.Strings.Clear();

   P := dmZLogGlobal.GetPrefix(SearchBox1.Text);
   if P = nil then begin
      Exit;
   end;

   C := P.Country;
   vleCountryInfo.Strings.AddPair('CountryName', C.CountryName);
   vleCountryInfo.Strings.AddPair('CQZone', C.CQZone);
   vleCountryInfo.Strings.AddPair('ITUZone', C.ITUZone);
   vleCountryInfo.Strings.AddPair('Continent', C.Continent);
   vleCountryInfo.Strings.AddPair('Latitude', C.Latitude);
   vleCountryInfo.Strings.AddPair('Longitude', C.Longitude);
   vleCountryInfo.Strings.AddPair('UTCOffset', IntToStr(C.UTCOffset));
   vleCountryInfo.Strings.AddPair('Country', C.Country);

   vlePrefixInfo.Strings.AddPair('Prefix', P.Prefix);
   vlePrefixInfo.Strings.AddPair('OvrCQZone', P.OvrCQZone);
   vlePrefixInfo.Strings.AddPair('OvrITUZone', P.OvrITUZone);
   vlePrefixInfo.Strings.AddPair('OvrContinent', P.OvrContinent);
   vlePrefixInfo.Strings.AddPair('FullMatch', BoolToStr(P.FullMatch, True));

   SearchBox1.SelectAll();
   SearchBox1.SetFocus();
end;

end.

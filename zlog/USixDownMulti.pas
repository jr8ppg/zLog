unit USixDownMulti;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UFDMulti, StdCtrls, checklst, JLLabel, ExtCtrls, Grids, Cologrid,
  UzLogConst, UzLogGlobal, UzLogQSO, UMultipliers;

type
  TSixDownMulti = class(TFDMulti)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}


procedure TSixDownMulti.FormCreate(Sender: TObject);
begin
  sband := b50;
  CityList := TCityList.Create;
  CityList.LoadFromFile('XPO.DAT');
  CityList.LoadFromFile('ACAG.DAT');
  if CityList.List.Count = 0 then exit;
  Reset;
  {
  for i := 0 to CityList.List.Count-1 do
    begin
      ListBox.Items.Add(TCity(CityList.List[i]).FDSummary(sband));
    end;}
end;

end.

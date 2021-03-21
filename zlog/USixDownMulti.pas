unit USixDownMulti;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UFDMulti, StdCtrls, JLLabel, ExtCtrls, Grids,
  UzLogConst, UzLogGlobal, UzLogQSO, UMultipliers;

type
  TSixDownMulti = class(TFDMulti)
    procedure FormCreate(Sender: TObject);
  protected
    procedure UpdateLabelPos(); override;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

procedure TSixDownMulti.FormCreate(Sender: TObject);
begin
   LatestMultiAddition := 0;
   sband := b50;
   CityList := TCityList.Create;
   CityList.LoadFromFile('XPO.DAT');
   CityList.LoadFromFile('ACAG.DAT');

   if CityList.List.Count = 0 then
      exit;

   Reset;
end;

procedure TSixDownMulti.UpdateLabelPos();
var
   w, l: Integer;
begin
   w := Grid.Canvas.TextWidth('X');
   l := (w * 29) - 2;
   Label50.Left   := l;
   Label144.Left  := Label50.Left + (w * 2);
   Label430.Left  := Label144.Left + (w * 2);
   Label1200.Left := Label430.Left + (w * 2);
   Label2400.Left := Label1200.Left + (w * 2);
   Label5600.Left := Label2400.Left + (w * 2);
   Label10g.Left  := Label5600.Left + (w * 2);
end;

end.

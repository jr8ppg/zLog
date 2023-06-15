unit UOperatorPowerDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, System.StrUtils;

type
  TOperatorPowerDialog = class(TForm)
    Panel1: TPanel;
    buttonOK: TButton;
    buttonCancel: TButton;
    comboPower19: TComboBox;
    Label1: TLabel;
    comboPower35: TComboBox;
    Label2: TLabel;
    comboPower7: TComboBox;
    Label3: TLabel;
    comboPower14: TComboBox;
    Label4: TLabel;
    comboPower21: TComboBox;
    Label5: TLabel;
    comboPower28: TComboBox;
    Label6: TLabel;
    comboPower50: TComboBox;
    Label7: TLabel;
    comboPower144: TComboBox;
    Label8: TLabel;
    comboPower430: TComboBox;
    Label9: TLabel;
    comboPower1200: TComboBox;
    Label10: TLabel;
    comboPower2400: TComboBox;
    Label11: TLabel;
    comboPower5600: TComboBox;
    Label12: TLabel;
    comboPower10g: TComboBox;
    Label13: TLabel;
    GroupBox1: TGroupBox;
    procedure FormCreate(Sender: TObject);
    procedure comboPowerChange(Sender: TObject);
  private
    { Private 宣言 }
    FComboArray: array[1..13] of TComboBox;
    function GetPower(): string;
    procedure SetPower(v: string);
  public
    { Public 宣言 }
    property Power: string read GetPower write SetPower;
  end;

resourcestring
  // 以降のバンドも同じ設定に変更しますか？
  DoYouWantTheUpperBandsToHaveTheSameSettins = 'Do you want the higher bands to have the same settings?';

implementation

{$R *.dfm}

procedure TOperatorPowerDialog.FormCreate(Sender: TObject);
begin
   FComboArray[1] := comboPower19;
   FComboArray[2] := comboPower35;
   FComboArray[3] := comboPower7;
   FComboArray[4] := comboPower14;
   FComboArray[5] := comboPower21;
   FComboArray[6] := comboPower28;
   FComboArray[7] := comboPower50;
   FComboArray[8] := comboPower144;
   FComboArray[9] := comboPower430;
   FComboArray[10] := comboPower1200;
   FComboArray[11] := comboPower2400;
   FComboArray[12] := comboPower5600;
   FComboArray[13] := comboPower10g;
end;

procedure TOperatorPowerDialog.comboPowerChange(Sender: TObject);
var
   Index: Integer;
   i: Integer;
begin
   if MessageBox(Handle, PChar(DoYouWantTheUpperBandsToHaveTheSameSettins), PChar(Application.Title), MB_YESNO or MB_DEFBUTTON2 or MB_ICONEXCLAMATION) = IDNO then begin
      Exit;
   end;

   Index := TComboBox(Sender).Tag;
   for i := Index + 1 to High(FComboArray) do begin
      FComboArray[i].ItemIndex := TComboBox(Sender).ItemIndex;
   end;
end;

function TOperatorPowerDialog.GetPower(): string;
var
   i: Integer;
   S: string;
begin
   S := '';
   for i := Low(FComboArray) to High(FComboArray) do begin
      S := S + FComboArray[i].Text;
   end;

   Result := S;
end;

procedure TOperatorPowerDialog.SetPower(v: string);
var
   i: Integer;
   S: string;
   Index: Integer;
begin
   S := v + DupeString('-', 13);
   for i := Low(FComboArray) to High(FComboArray) do begin
      Index := FComboArray[i].Items.IndexOf(S[i]);
      if Index = -1 then begin
         FComboArray[i].ItemIndex := 0;   // -
      end
      else begin
         FComboArray[i].ItemIndex := Index;
      end;
   end;
end;

end.

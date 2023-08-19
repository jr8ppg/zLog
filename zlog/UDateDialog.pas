unit UDateDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls;

type
  TDateDialog = class(TForm)
    datetimeChange: TDateTimePicker;
    panelFooter: TPanel;
    buttonOK: TButton;
    buttonCancel: TButton;
    datetimeCurrent: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private êÈåæ }
    procedure SetCurrentDate(d: TDateTime);
    function GetCurrentDate(): TDateTime;
    procedure SetNewDate(d: TDateTime);
    function GetNewDate(): TDateTime;
  public
    { Public êÈåæ }
    property CurrentDate: TDateTime read GetCurrentDate write SetCurrentDate;
    property NewDate: TDateTime read GetNewDate write SetNewDate;
  end;

implementation

{$R *.dfm}

procedure TDateDialog.FormCreate(Sender: TObject);
begin
   datetimeChange.Date := Date();
end;

procedure TDateDialog.FormDestroy(Sender: TObject);
begin
//
end;

procedure TDateDialog.SetCurrentDate(d: TDateTime);
begin
   datetimeCurrent.Date := d;
end;

function TDateDialog.GetCurrentDate(): TDateTime;
begin
   Result := datetimeCurrent.Date;
end;

procedure TDateDialog.SetNewDate(d: TDateTime);
begin
   datetimeChange.Date := d;
end;

function TDateDialog.GetNewDate(): TDateTime;
begin
   Result := datetimeChange.Date;
end;

end.

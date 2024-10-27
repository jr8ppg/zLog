unit USpotterListDlg;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TformSpotterListDlg = class(TForm)
    Panel1: TPanel;
    buttonOK: TButton;
    buttonCancel: TButton;
    Panel2: TPanel;
    listAllow1: TListBox;
    listDeny: TListBox;
    buttonAddToAllowList: TButton;
    buttonRemoveFromAllowList: TButton;
    comboSpotter: TComboBox;
    buttonAddToDenyList: TButton;
    buttonRemoveFromDenyList: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    listAllow2: TListBox;
    Label4: TLabel;
    buttonAddToAllowList2: TButton;
    buttonRemoveFromAllowList2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure comboSpotterChange(Sender: TObject);
    procedure listAllow1Click(Sender: TObject);
    procedure buttonAddToAllowListClick(Sender: TObject);
    procedure buttonAddToDenyListClick(Sender: TObject);
    procedure buttonRemoveFromAllowListClick(Sender: TObject);
    procedure buttonRemoveFromDenyListClick(Sender: TObject);
    procedure buttonOKClick(Sender: TObject);
    procedure comboSpotterDblClick(Sender: TObject);
    procedure listAllow1DblClick(Sender: TObject);
    procedure listDenyClick(Sender: TObject);
    procedure listDenyDblClick(Sender: TObject);
    procedure buttonAddToAllowList2Click(Sender: TObject);
    procedure buttonRemoveFromAllowList2Click(Sender: TObject);
    procedure listAllow2Click(Sender: TObject);
    procedure listAllow2DblClick(Sender: TObject);
  private
    { Private êÈåæ }
  public
    { Public êÈåæ }
  end;


implementation

{$R *.dfm}

procedure TformSpotterListDlg.FormCreate(Sender: TObject);
begin
//
end;

procedure TformSpotterListDlg.FormDestroy(Sender: TObject);
begin
//
end;

procedure TformSpotterListDlg.FormShow(Sender: TObject);
var
   fname: string;
begin
   comboSpotter.Clear();
   listAllow1.Clear();
   listAllow2.Clear();
   listDeny.Clear();

   fname := ExtractFilePath(Application.ExeName) + 'spotter_list.txt';
   if FileExists(fname) then begin
      comboSpotter.Items.LoadFromFile(fname);
   end;

   fname := ExtractFilePath(Application.ExeName) + 'spotter_allow.txt';
   if FileExists(fname) then begin
      listAllow1.Items.LoadFromFile(fname);
   end;

   fname := ExtractFilePath(Application.ExeName) + 'spotter_allow2.txt';
   if FileExists(fname) then begin
      listAllow2.Items.LoadFromFile(fname);
   end;

   fname := ExtractFilePath(Application.ExeName) + 'spotter_deny.txt';
   if FileExists(fname) then begin
      listDeny.Items.LoadFromFile(fname);
   end;

   comboSpotter.OnChange(comboSpotter);
   listAllow1.OnClick(listAllow1);
   listAllow2.OnClick(listAllow2);
   listDeny.OnClick(listDeny);
end;

procedure TformSpotterListDlg.buttonOKClick(Sender: TObject);
var
   fname: string;
begin
   fname := ExtractFilePath(Application.ExeName) + 'spotter_allow.txt';
   listAllow1.Items.SaveToFile(fname);

   fname := ExtractFilePath(Application.ExeName) + 'spotter_allow2.txt';
   listAllow2.Items.SaveToFile(fname);

   fname := ExtractFilePath(Application.ExeName) + 'spotter_deny.txt';
   listDeny.Items.SaveToFile(fname);
end;

procedure TformSpotterListDlg.listAllow1Click(Sender: TObject);
begin
   if listAllow1.ItemIndex = -1 then begin
      buttonRemoveFromAllowList.Enabled := False;
   end
   else begin
      buttonRemoveFromAllowList.Enabled := True;
   end;
end;

procedure TformSpotterListDlg.listAllow1DblClick(Sender: TObject);
begin
   buttonRemoveFromAllowList.Click();
end;

procedure TformSpotterListDlg.listAllow2Click(Sender: TObject);
begin
   if listAllow2.ItemIndex = -1 then begin
      buttonRemoveFromAllowList2.Enabled := False;
   end
   else begin
      buttonRemoveFromAllowList2.Enabled := True;
   end;
end;

procedure TformSpotterListDlg.listAllow2DblClick(Sender: TObject);
begin
   buttonRemoveFromAllowList2.Click();
end;

procedure TformSpotterListDlg.listDenyClick(Sender: TObject);
begin
   if listDeny.ItemIndex = -1 then begin
      buttonRemoveFromDenyList.Enabled := False;
   end
   else begin
      buttonRemoveFromDenyList.Enabled := True;
   end;
end;

procedure TformSpotterListDlg.listDenyDblClick(Sender: TObject);
begin
   buttonRemoveFromDenyList.Click();
end;

procedure TformSpotterListDlg.comboSpotterChange(Sender: TObject);
begin
   if comboSpotter.Text = '' then begin
      buttonAddToAllowList.Enabled := False;
      buttonAddToAllowList2.Enabled := False;
      buttonAddToDenyList.Enabled := False;
   end
   else begin
      buttonAddToAllowList.Enabled := True;
      buttonAddToAllowList2.Enabled := True;
      buttonAddToDenyList.Enabled := True;
   end;
end;

procedure TformSpotterListDlg.comboSpotterDblClick(Sender: TObject);
begin
   buttonAddToAllowList.Click();
end;

procedure TformSpotterListDlg.buttonAddToAllowListClick(Sender: TObject);
var
   S: string;
   Index: Integer;
begin
   S := comboSpotter.Text;

   Index := listAllow2.Items.IndexOf(S);
   if Index <> -1 then begin
      listAllow2.Items.Delete(Index);
   end;

   Index := listDeny.Items.IndexOf(S);
   if Index <> -1 then begin
      listDeny.Items.Delete(Index);
   end;

   Index := listAllow1.Items.IndexOf(S);
   if Index = -1 then begin
      listAllow1.Items.Add(S);
   end
   else begin
      listAllow1.ItemIndex := Index;
   end;
end;

procedure TformSpotterListDlg.buttonAddToAllowList2Click(Sender: TObject);
var
   S: string;
   Index: Integer;
begin
   S := comboSpotter.Text;

   Index := listAllow1.Items.IndexOf(S);
   if Index <> -1 then begin
      listAllow1.Items.Delete(Index);
   end;

   Index := listDeny.Items.IndexOf(S);
   if Index <> -1 then begin
      listDeny.Items.Delete(Index);
   end;

   Index := listAllow2.Items.IndexOf(S);
   if Index = -1 then begin
      listAllow2.Items.Add(S);
   end
   else begin
      listAllow2.ItemIndex := Index;
   end;
end;

procedure TformSpotterListDlg.buttonAddToDenyListClick(Sender: TObject);
var
   S: string;
   Index: Integer;
begin
   S := comboSpotter.Text;

   Index := listAllow1.Items.IndexOf(S);
   if Index <> -1 then begin
      listAllow1.Items.Delete(Index);
   end;

   Index := listAllow2.Items.IndexOf(S);
   if Index <> -1 then begin
      listAllow2.Items.Delete(Index);
   end;

   Index := listDeny.Items.IndexOf(S);
   if Index = -1 then begin
      listDeny.Items.Add(S);
   end
   else begin
      listDeny.ItemIndex := Index;
   end;
end;

procedure TformSpotterListDlg.buttonRemoveFromAllowListClick(Sender: TObject);
var
   Index: Integer;
begin
   Index := listAllow1.ItemIndex;
   if Index <> -1 then begin
      listAllow1.Items.Delete(Index);
      listAllow1.OnClick(listAllow1);
   end;
end;

procedure TformSpotterListDlg.buttonRemoveFromAllowList2Click(Sender: TObject);
var
   Index: Integer;
begin
   Index := listAllow2.ItemIndex;
   if Index <> -1 then begin
      listAllow2.Items.Delete(Index);
      listAllow2.OnClick(listAllow2);
   end;
end;

procedure TformSpotterListDlg.buttonRemoveFromDenyListClick(Sender: TObject);
var
   Index: Integer;
begin
   Index := listDeny.ItemIndex;
   if Index <> -1 then begin
      listDeny.Items.Delete(Index);
      listDeny.OnClick(listDeny);
   end;
end;

end.

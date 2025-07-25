unit UGrayline;

//
// Grayline
//

// The world map was taken from the following website:
// https://www.freeworldmaps.net/physical.html

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  System.Math, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.DateUtils, System.StrUtils, Vcl.Imaging.pngimage, Vcl.Menus,
  SunTime, UzLogForm, UzLogGlobal, UzGraylineMap, Vcl.WinXCtrls;

const
  WM_GRAYLINE_COMPLETE = (WM_USER + 100);

type
  TGraylineCalcThread = class(TThread)
    FOwnerWnd: HWND;
    FGrayline: TGrayLineMap;
    FUtc: TDateTime;
  protected
    constructor Create(AOwnerWnd: HWND; AGrayline: TGrayLineMap; AUtc: TDateTime);
    procedure Execute; override;
  end;

type
  TformGrayline = class(TZLogForm)
    Image1: TImage;
    Timer1: TTimer;
    PopupMenu1: TPopupMenu;
    menuShowGrayline: TMenuItem;
    menuShowMeridians: TMenuItem;
    menuShowEquator: TMenuItem;
    menuShowMyLocation: TMenuItem;
    N1: TMenuItem;
    menuStayOnTop: TMenuItem;
    ActivityIndicator1: TActivityIndicator;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure menuShowGraylineClick(Sender: TObject);
    procedure menuShowMeridiansClick(Sender: TObject);
    procedure menuShowEquatorClick(Sender: TObject);
    procedure menuShowMyLocationClick(Sender: TObject);
    procedure menuStayOnTopClick(Sender: TObject);
    procedure WMGraylineComplete(var msg: TMessage); message WM_GRAYLINE_COMPLETE;
  private
    { Private 宣言 }
    FGrayline: TGrayLineMap;
    FWorldmap: TBitmap;
    procedure IndicatorCenter();
    procedure GraylineProc();
    procedure SetStayOnTop();
  public
    { Public 宣言 }
  end;

implementation

{$R *.dfm}

procedure TformGrayline.FormCreate(Sender: TObject);
var
   png: TPngImage;
begin
   Inherited;
   FGrayline := TGraylineMap.Create();

   png := TPngImage.Create();
   png.LoadFromResourceName(SysInit.HInstance, 'IDB_WORLDMAP');

   FWorldmap := TBitmap.Create(png.Width, png.Height);
   FWorldmap.PixelFormat := pf24bit;
   FWorldmap.Dormant();
   FWorldmap.Canvas.Draw(0, 0, png);

   Image1.Picture.Bitmap.Assign(FWorldmap);

   png.Free();

   menuShowGrayline.Checked := dmZLogGlobal.Settings.FShowGrayline;
   menuShowMeridians.Checked := dmZLogGlobal.Settings.FShowMeridians;
   menuShowEquator.Checked := dmZLogGlobal.Settings.FShowEquator;
   menuShowMyLocation.Checked := dmZLogGlobal.Settings.FShowMyLocation;
   menuStayOnTop.Checked := dmZLogGlobal.Settings.FGrayLineStayOnTop;
   SetStayOnTop();

   FGrayline.ShowGrayline := menuShowGrayline.Checked;
end;

procedure TformGrayline.FormDestroy(Sender: TObject);
begin
   Timer1.Enabled := False;
   FGrayline.Free();
   FWorldmap.Free();
end;

procedure TformGrayline.FormHide(Sender: TObject);
begin
   Timer1.Enabled := False;
end;

procedure TformGrayline.FormResize(Sender: TObject);
begin
   IndicatorCenter();
   GraylineProc();
end;

procedure TformGrayline.FormShow(Sender: TObject);
var
   utc: TDateTime;
   calc: TGraylineCalcThread;
begin
   Inherited;

   // インジケーターをセンタリング
   IndicatorCenter();
   Application.ProcessMessages();

   // 右クリックメニュー無効
   Self.PopupMenu := nil;

   // 現在時刻
   utc := Now;
   utc := IncHour(utc, -9);

   // インジケーター開始
   ActivityIndicator1.Visible := True;
   ActivityIndicator1.Animate := True;

   // 初期計算スレッド開始
   calc := TGraylineCalcThread.Create(Handle, FGrayline, utc);

   // タイマー間隔セット
   Timer1.Interval := 60 * 1000 * 5;   // 5min.
end;

procedure TformGrayline.IndicatorCenter();
begin
   ActivityIndicator1.Left := ((ClientWidth - ActivityIndicator1.Width) div 2);
   ActivityIndicator1.Top := ((ClientHeight - ActivityIndicator1.Height) div 2);
end;

procedure TformGrayline.GraylineProc();
var
   bmp: TBitmap;
   mylongitude: Extended;
begin
   bmp := TBitmap.Create();
   bmp.Assign(FWorldmap);

   // grayline
   FGrayline.Draw(bmp, dmZLogGlobal.Settings.FGrayLineYcutsize);

   // 赤道
   if menuShowEquator.Checked = True then begin
      FGrayline.DrawLatitude(bmp, 0, psDash);
   end;

   // 子午線
   if menuShowMeridians.Checked = True then begin
      FGrayline.DrawLongitude(bmp, 0, psDash);
   end;

   // 自分の位置
   if menuShowMyLocation.Checked = True then begin
      if dmZLogGlobal.Settings._mylongitude <> '' then begin
         mylongitude := StrToFloatDef(dmZLogGlobal.Settings._mylongitude, 0) * -1;
         FGrayline.DrawLongitude(bmp, mylongitude);
      end;
   end;

   Image1.Picture.Bitmap.Assign(bmp);
   bmp.Free();
end;

// graylineを表示
procedure TformGrayline.menuShowGraylineClick(Sender: TObject);
begin
   inherited;
   dmZLogGlobal.Settings.FShowGrayline := menuShowGrayline.Checked;
   FGrayline.ShowGrayline := menuShowGrayline.Checked;
   Timer1Timer(nil);
end;

// 子午線を表示
procedure TformGrayline.menuShowMeridiansClick(Sender: TObject);
begin
   inherited;
   dmZLogGlobal.Settings.FShowMeridians := menuShowMeridians.Checked;
   GraylineProc();
end;

// 赤道を表示
procedure TformGrayline.menuShowEquatorClick(Sender: TObject);
begin
   inherited;
   dmZLogGlobal.Settings.FShowEquator := menuShowEquator.Checked;
   GraylineProc();
end;

// 自局位置を表示
procedure TformGrayline.menuShowMyLocationClick(Sender: TObject);
begin
   inherited;
   dmZLogGlobal.Settings.FShowMyLocation := menuShowMyLocation.Checked;
   GraylineProc();
end;

// 最前面に表示
procedure TformGrayline.menuStayOnTopClick(Sender: TObject);
begin
   inherited;
   dmZLogGlobal.Settings.FGrayLineStayOnTop := menuStayOnTop.Checked;
   SetStayOnTop();
end;

procedure TformGrayline.Timer1Timer(Sender: TObject);
var
   utc: TDateTime;
begin
   utc := Now;
   utc := IncHour(utc, -9);

   // grayline判定
   FGrayline.Judge(utc);

   // 描画メイン
   GraylineProc();
end;

procedure TformGrayline.SetStayOnTop();
begin
   if menuStayOnTop.Checked = True then begin
      FormStyle := fsStayOnTop;
   end
   else begin
      FormStyle := fsNormal;
   end;
end;

procedure TformGrayline.WMGraylineComplete(var msg: TMessage);
begin
   // インジケーター終わり
   ActivityIndicator1.Visible := False;
   ActivityIndicator1.Animate := False;
   Application.ProcessMessages();

   {$IFDEF DEBUG}
   OutputDebugString(PChar('FGrayline.Calc=' + IntToStr(msg.LParam) + 'ms'));
   {$ENDIF}

   // 描画
   GraylineProc();

   // 右クリックメニュー有効
   Self.PopupMenu := PopupMenu1;

   // タイマー開始
//   Timer1Timer(nil);
   Timer1.Enabled := True;
end;

{ TGraylineCalcThread }

constructor TGraylineCalcThread.Create(AOwnerWnd: HWND; AGrayline: TGrayLineMap; AUtc: TDateTime);
begin
   FOwnerWnd := AOwnerWnd;
   FUtc := AUtc;
   FGrayline := AGrayline;
   FreeOnTerminate := True;
   Inherited Create(False);
end;

procedure TGraylineCalcThread.Execute();
var
   dwTick: DWORD;
begin
   dwTick := GetTickCount();
   FGrayline.Calc(FUtc);
   dwTick := GetTickCount() - dwTick;
   PostMessage(FOwnerWnd, WM_GRAYLINE_COMPLETE, 0, dwTick);
end;

end.

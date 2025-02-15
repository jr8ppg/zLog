unit Console;
{$A+,B-,F-,Q-,R-,S-,W-,X+}

{  Text Console component
   Version 2.0  for 16 bit and 32 bit Delphi.

   Copyright (c) 1995,96 by Danny Thorpe (dthorpe@subliminal.com)

   You are hereby granted a royalty-free unlimited distribution
   license to compile the components in this source file into
   your applications.

   This source file may be freely distributed through online networks
   so long as no modifications are made to this file and no fee is
   charged to obtain this file, other than normal online connection
   charges.

   These components may NOT be distributed as source code or
   compiled DCU on diskette, CDRom, or as part of a
   product without prior written consent of the author.

   All rights not explicitly granted here are reserved by the author.
}

interface

uses WinTypes, WinProcs, Messages, Classes, Controls,
     Forms, Graphics, SysUtils, AnsiStrings;


{ TConsole

  TConsole implements a WinCRT-like control for routing text
  file I/O (readlns and writelns) to a scrollable window.  A
  text cursor can be positioned using X,Y text coordinates.
  TConsole is not intended to be a text editor, merely a TTY
  text output device.  TConsole does not store its text
  buffers when it is streamed.  Max display text in 16 bit
  applications is 64k (rows * columns <= 64k); in 32 bit
  applications, the only capacity limit is system memory.
  You can set the TConsole font name, style or other
  properties, but only fixed-pitch fonts should be used.

  TConsole can be extended to support text color attributes
  and multiple fonts, and can support multiple terminal
  emulation command decoders (like ANSI-BBS or DEC VT-100).

  TConsole supports keyboard input via the Pascal standard
  input functions ReadKey, Keypressed, and Readln.  Note that
  the modal nature of Readln (execution doesn't return until
  EOL is received) is problematic.  Only one outstanding
  Console Readln operation is supported for the entire
  application. Calling readln while another readln is
  pending (eg Readln on a button click) will raise an
  exception.

  TConsole provides a performance option called toLazyWrite.
  With this option turned off, each write operation to the
  Console is immediately displayed on the screen.  With
  toLazyWrite turned on, screen updating is delayed slightly
  so that multiple text changes can be displayed in one Paint
  operation. Despite the 'lazy' name, this consolidation
  results in dramatically better display performance - a
  factor of 10 to 100 times faster than writing each little
  piece of text immediately. toLazyWrite is enabled by default.

  The public ScrollTo and TrackCursor methods don't use
  toLazyWrite, nor do the ReadKey or ReadBuf routines.  When
  these routines modify the display or text buffer, the
  Console is updated immediately.

  The coFixedPitchOnly option, True by default, determines whether
  the console component raises an exception when a font which is not
  marked as fixed pitch is assigned to the component.  Many off-brand
  truetype fonts which have a uniform character width are
  incorrectly marked as proportional fonts.  By setting
  coFixedPitchOnly to false, you can now use those fonts in the
  console components.  Using proportional fonts in a console
  component is not advised; it's very ugly.

TColorConsole

  TColorConsole implements support for multiple text color
  attributes.  The Console's font properties determine the
  text color, background color, font, style, etc of the
  display text.  Text foreground color is Console.Font.Color;
  text background is Console.Font.BkColor.  Set the Console's
  font properties, then writeln to the Console's text file
  and that text will be displayed with those attributes.

  In 16 bit applications, TColorConsole has the following
  capacity limits: Max display text is 32k. (rows * cols <= 32k).
  Max unique text attribute sets: 16k. (unique = font+color+bkcolor)

  In 32 bit applications, the only limit is system memory.
  Memory consumption is roughly 5 bytes per display text character
  cell:  an 80 x 25 color console will use 80 x 25 = 2000 bytes
  for the text buffer plus 80 x 25 x 4 = 8000 bytes for the
  cell attribute buffer.  Each unique text attribute set uses
  36 bytes of memory.

  Text attribute sets are maintained in a pool.  Each attr set
  is released when the last char in the display buffer using
  that set is overwritten with different attributes.

  Multiple fonts are supported, but the cell height and width
  of the fonts must be the same.  That is, you can output text
  in Courier New 10pt, Courier New 10pt Bold, and Lucida Sans
  Monospace 10pt Italic all on the same screen.  If the
  Console's font size is changed, that size change is applied
  to all fonts used by the Console control and the control is
  repainted.

  Fonts of the same height often have different widths.  When
  a wider font is selected into the Console control, the
  character cell dimensions for all the text is enlarged to
  accommodate the wider font.  Characters of narrower fonts
  will be spaced further apart to maintain column alignment.
  This rarely looks appealing, so take it easy on the fonts.
  TrueType fonts (like Courier New) tend to work better
  than bitmap fonts (like Courier).


TConsole's output routines

  Most of the time, you'll use a text file to write data to
  the Console window.  To make the component intercept all output
  written to stdout (ie anything that calls write or writeln
  without a file handle), include the coStdOutput flag in the
  component's Options property.  Only one component in the
  application can intercept stdout.  coStdOutput is disabled by default.

  For more specialized work, such as extending these objects or
  adding terminal emulation processor methods, you can use some
  of TConsole's specialized output routines.

WriteChar
  Calls WriteCodedBuf to output one character using the
  current font/color attributes.

WriteString
  Calls WriteCodedBuf to output the characters in the string
  using the current font/color attributes.

WriteCodedBuf
  Passes control to the ProcessControlCodes method pointer if
  it is assigned.  If the pointer is not assigned, WriteBuf is
  called instead. WriteCodedBuf is called by the internal text
  file device driver (Write and Writeln), WriteChar, and
  WriteString.

  Your ProcessControlCodes routine should parse the buffer to
  find and execute complex display formatting control codes
  and command sequences embedded in the data stream (such
  as ANSI terminal codes).

  ProcessControlCodes is an event so that it can be reassigned
  dynamically at runtime - for example, to switch from ANSI
  emulation to Wyse terminal emulation.  Control code
  processing methods have full responsibility for displaying
  the actual text - they should parse their control codes,
  set the cursor position or font/color attributes as
  needed, and then call WriteChar, WriteString, or WriteFill
  as necessary to display the actual text (without codes).

  If you determine that a text buffer contains no special
  codes for your ProcessControlCodes event to handle, you
  can pass the text buffer to DefaultProcessControlCodes
  to perform the normal WriteBuf text processing on the buffer.
  This will save you some work in your event handler.

WriteFill
  Replicates a single character (or space) N times starting
  from text coordinate X,Y and flowing down the page.
  All the replicated chars are displayed with the currently
  selected font and color attributes.  The copy count can be
  any length up to (rows * cols).  TColorConsole overrides
  this method to add additional color support.

WriteBuf
  This is an internal (protected) mid-level method to process
  simple text file formatting codes.  It scans the data stream
  for special characters (Carriage return, Linefeed,
  Backspace, Bell), wraps text at the right margin, and calls
  WriteBlock or WriteFill for actual output.

WriteBlock
  This is an internal (protected) low-level method to output
  a string of characters.  WriteBlock assumes the string
  parameter has been stripped of all special characters and
  is guaranteed to contain no more than one line of text
  (length <= Cols - Cursor.X).  All the characters in the
  string are displayed with the currently selected font
  and color attributes.  TColorConsole overrides this method
  to add additional color support.
}

const
  CM_TrackCursor = wm_User + 100;
  CM_ScrollBy    = wm_User + 101;

type
  EInvalidFont = class(Exception);

  TCMScrollBy = record
    Msg: Cardinal;
    dx : Integer;
    dy : Longint;
  end;

  TConsole = class;  { forward declaration }

  TFixedFont = class(TFont)
  private
    FBkColor: TColor;
    procedure SetBkColor(NewColor: TColor);
  public
    constructor Create;
    procedure Assign(Source: TPersistent); override;
  published
    property BkColor: TColor read FBkColor write SetBkColor default clWindow;
  end;

  TConsoleOption = (coAutoTracking, coCheckEOF, coCheckBreak,
    coFulltimeCursor, coLazyWrite, coStdInput, coStdOutput, coFixedPitchOnly);
  TConsoleOptions = set of TConsoleOption;

  { CR/LF translation.
        CRLF = no translation
        CR   = on CR add LF
        LF   = on LF add CR   }
  TConsoleLineBreak = (CRLF, CR, LF);

  TProcessControlCodes = procedure (Sender: TConsole;
				    Buffer: PAnsiChar; Count: Cardinal) of object;

  TConsole = class(TCustomControl)
  private
    FOptions: TConsoleOptions;
    FFocused: Boolean;
    FFont: TFixedFont;
    FCols: Integer;                        { Screen buffer dimensions }
    FRows: Integer;
    FProcessControlCodes: TProcessControlCodes;
    FLineBreak: TConsoleLineBreak;        { CR/LF/CRLF translation }
    procedure InternalClrScr;
    procedure SetOptions(NewOptions: TConsoleOptions);
    procedure SetCols(N: Integer);
    procedure SetRows(N: Integer);
    procedure SetFont(F: TFixedFont);
    procedure DoScroll(Which, Action, Thumb: Integer);
    procedure CMTrackCursor(var M); message CM_TrackCursor;
    procedure CMScrollBy(var M: TCMScrollBy); message CM_ScrollBy;
    procedure WMCreate(var M); message wm_Create;
    procedure WMSize(var M: TWMSize); message wm_Size;
    procedure WMHScroll(var M: TWMHScroll); message wm_HScroll;
    procedure WMVScroll(var M: TWMVScroll); message wm_VScroll;
    procedure WMSetFocus(var M: TWMSetFocus); message wm_SetFocus;
    procedure WMKillFocus(var M: TWMKillFocus); message wm_KillFocus;
    procedure WMGetDlgCode(var M: TWMGetDlgCode); message wm_GetDlgCode;
    procedure WMEraseBkgnd(var M: TWMEraseBkgnd); message wm_EraseBkgnd;
  protected
    FReading: Boolean;                     { Reading from CRT window? }
    FOldFont: TFixedFont;
    FFirstLine: Integer;           { First visible line in circular buffer }
    FKeyCount: Integer;                    { Count of keys in KeyBuffer }
    FBuffer: PAnsiChar;                        { Screen buffer pointer }
    FRange: TPoint;                        { Scroll bar ranges }
    FOrigin: TPoint;                       { Client/scroll origin }
    FClientSize: TPoint;                   { Number of visible whole cells }
    FCharSize: TPoint;                     { Character cell size }
    FCharAscent: Integer;                  { Baseline location (for caret) }
    FOverhang: Integer;                    { Extra space needed for chars }
    FKeyBuffer: array[0..63] of AnsiChar;      { Keyboard type-ahead buffer }
    Cursor: TPoint;                        { Cursor location }
    procedure CreateParams(var P: TCreateParams); override;
    procedure FontChanged(Sender: TObject);
    procedure ResizeBuffer; dynamic;
    procedure SetName(const NewName: TComponentName); override;
    procedure SetMetrics(const Metrics: TTextMetric); virtual;
    procedure RecalibrateFont;
    procedure RecalcSizeAndRange;
    function  ScreenPtr(X, Y: Integer): PAnsiChar;
    procedure ShowText(L, R: Integer);
    procedure WriteFill(X,Y: Integer; Ch: AnsiChar; Count: Cardinal); virtual;
    procedure WriteBlock(X,Y: Integer; Buffer: PAnsiChar; Count: Cardinal); virtual;
    procedure WriteBuf(Buffer: PAnsiChar; Count: Cardinal);
    procedure SetScrollbars;
    procedure Paint; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure DoCtrlBreak; dynamic;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
		 X, Y: Integer); override;
    procedure LazyTrackCursor;
    procedure LazyScrollBy(dx, dy: Integer);
    procedure Loaded; override;
  public
    constructor Create(AnOwner: TComponent); override;
    destructor Destroy; override;
    procedure DefaultProcessControlCodes(Buffer: PAnsiChar; Count: Cardinal);
    procedure WriteCodedBuf(Buffer: PAnsiChar; Count: Cardinal);
    procedure WriteChar(Ch: AnsiChar);
    procedure WriteString(const S: String);
    function  KeyPressed: Boolean;
    function  ReadKey: AnsiChar;
    function  ReadBuf(Buffer: PAnsiChar; Count: Cardinal): Cardinal;
    procedure ClrScr;
    procedure ClrEol;
    procedure CursorTo(X, Y: Integer);
    procedure ScrollTo(X, Y: Integer);
    procedure TrackCursor;
    procedure AssignCrt(var F: Text); dynamic;
    procedure ShowCursor; virtual;
    procedure HideCursor;
  published
    property Align;
    property ParentColor;
    property Color;
    property Font: TFixedFont read FFont write SetFont;
    property Options: TConsoleOptions read FOptions write SetOptions
      default [coAutoTracking, coCheckBreak, coLazyWrite{, coFixedPitchOnly}];
    property Cols: Integer read FCols write SetCols default 80;
    property Rows: Integer read FRows write SetRows default 25;
    property LineBreak: TConsoleLineBreak read FLineBreak write FLineBreak;
    property ProcessControlCodes: TProcessControlCodes
	       read FProcessControlCodes write FProcessControlCodes;
  end;


type
  PIntArray = ^TIntArray;
  TIntArray = array [0..0] of Integer;

type
  TAttr = class(TFixedFont)
  protected
    RefCount: Cardinal;
    Overhang: ShortInt;
    Underhang: ShortInt;
  public
    constructor Create(F: TFixedFont);
  end;

  TAttrManager = class(TPersistent)
  private
    FList: TList;
    FCache: TAttr;
    FCacheIndex: Integer;
    function GetCount: Integer;
  protected
    function  GetAttr(Index: Integer): TAttr;
    procedure SetAttr(Index: Integer; NewAttr: TAttr);
    procedure SetFree(Index: Integer);
    function  AllocIndex: Integer;
  public
    constructor Create;
    destructor Destroy; override;
    function  Allocate(F: TFixedFont): Integer;
    procedure Clear;
    procedure Reference(Index: Integer; Delta: Integer);
    property  Attr[Index: Integer]: TAttr read GetAttr write SetAttr; default;
    property  Count: Integer read GetCount;
  end;

  TColorConsole = class(TConsole)
  private
    FIndexes: PIntArray;
    FAttrList: TAttrManager;
    FCellWidths: PIntArray;
    procedure FillAttr(X,Y: Integer; Count: Cardinal);
  protected
    function  IndexPtr(X,Y: Integer): PInteger;
    procedure ResizeBuffer; override;
    procedure SetMetrics(const Metrics: TTextMetric); override;
    procedure WriteFill(X,Y: Integer; Ch: AnsiChar; Count: Cardinal); override;
    procedure WriteBlock(X,Y: Integer; Buffer: PAnsiChar; Count: Cardinal); override;
    procedure Paint; override;
  public
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;
  end;

procedure Register;

procedure Exchange(var X,Y: Pointer);
procedure FillInt(var Buf; Count: Cardinal; Value: Integer);

implementation

{ Scroll key definition record }

type
  TScrollKey = record
    sKey: Byte;
    Ctrl: Boolean;
    SBar: Byte;
    Action: Byte;
  end;

var
  ReadActive: Boolean = False;  { Anybody in a Readln? }

{ Scroll keys table }

const
  ScrollKeyCount = 12;
  ScrollKeys: array[1..ScrollKeyCount] of TScrollKey = (
    (sKey: vk_Left;  Ctrl: False; SBar: sb_Horz; Action: sb_LineUp),
    (sKey: vk_Right; Ctrl: False; SBar: sb_Horz; Action: sb_LineDown),
    (sKey: vk_Left;  Ctrl: True;  SBar: sb_Horz; Action: sb_PageUp),
    (sKey: vk_Right; Ctrl: True;  SBar: sb_Horz; Action: sb_PageDown),
    (sKey: vk_Home;  Ctrl: False; SBar: sb_Horz; Action: sb_Top),
    (sKey: vk_End;   Ctrl: False; SBar: sb_Horz; Action: sb_Bottom),
    (sKey: vk_Up;    Ctrl: False; SBar: sb_Vert; Action: sb_LineUp),
    (sKey: vk_Down;  Ctrl: False; SBar: sb_Vert; Action: sb_LineDown),
    (sKey: vk_Prior; Ctrl: False; SBar: sb_Vert; Action: sb_PageUp),
    (sKey: vk_Next;  Ctrl: False; SBar: sb_Vert; Action: sb_PageDown),
    (sKey: vk_Home;  Ctrl: True;  SBar: sb_Vert; Action: sb_Top),
    (sKey: vk_End;   Ctrl: True;  SBar: sb_Vert; Action: sb_Bottom));

{ Return the smaller of two integer values }

function Min(X, Y: Integer): Integer;
begin
  if X < Y then Min := X else Min := Y;
end;

{ Return the larger of two integer values }

function Max(X, Y: Integer): Integer;
begin
  if X > Y then Max := X else Max := Y;
end;

procedure Exchange(var X,Y: Pointer);
var
  Temp: Pointer;
begin
  Temp := X;
  X := Y;
  Y := Temp;
end;

procedure FillInt(var Buf; Count: Cardinal; Value: Integer);
var
  X: Cardinal;
begin
  for X := 0 to Count-1 do
    TIntArray(Buf)[X] := Value;
end;

constructor TFixedFont.Create;
begin
  inherited Create;
  Name := 'Courier New';
  FBkColor := clWindow;
end;

procedure TFixedFont.Assign(Source: TPersistent);
var
  Temp: TColor;
begin
  Temp := FBkColor;
  if Source is TFixedFont then
    FBkColor := TFixedFont(Source).BkColor;
  try
    inherited Assign(Source);        { inherited will call Changed }
  except
    FBkColor := Temp;   { Restore original if inherited fails }
    raise;
  end;
end;

procedure TFixedFont.SetBkColor(NewColor: TColor);
begin
  FBkColor := NewColor;
  Changed;
end;


constructor TConsole.Create(AnOwner: TComponent);
begin
  inherited Create(AnOwner);
  Width := 160;
  Height := 88;
  Options := [coAutoTracking, coCheckBreak, coLazyWrite{, coFixedPitchOnly}];
  ControlStyle := ControlStyle + [csOpaque];
  FRows := 25;
  FCols := 80;
  ParentColor := False;
  Color := clWindow;
  FOldFont := TFixedFont.Create;
  FOldFont.Handle := GetStockObject(Ansi_Fixed_Font);
  FFont := TFixedFont.Create;
  FFont.Name := 'Courier';
  FFont.OnChange := FontChanged;
  ResizeBuffer;
  TabStop := True;
  Enabled := True;
end;

destructor TConsole.Destroy;
begin
  Options := Options - [coStdInput, coStdOutput];  { close files }
  AnsiStrings.StrDispose(FBuffer);
  FOldFont.Free;
  FFont.Free;
  inherited Destroy;
end;

procedure TConsole.Loaded;
begin
  inherited Loaded;
  ClrScr;
end;

procedure TConsole.CreateParams(var P: TCreateParams);
begin
  inherited CreateParams(P);
  P.WindowClass.Style := P.WindowClass.Style and not (cs_HRedraw or cs_VRedraw);
end;

procedure TConsole.DefaultProcessControlCodes(Buffer: PAnsiChar; Count: Cardinal);
begin
  WriteBuf(Buffer, Count);
end;

procedure TConsole.WMCreate(var M);
begin
  inherited;
  RecalibrateFont;    { don't ClrScr, because text may already be in buffer }
end;

procedure TConsole.ResizeBuffer;
var Temp: PAnsiChar;
begin
  Temp := AnsiStrings.AnsiStrAlloc(Cols * Rows);
  AnsiStrings.StrDispose(FBuffer);
  FBuffer := Temp;
  FillChar(FBuffer^,Cols * Rows,' ');
end;

procedure TConsole.SetCols(N: Integer);
begin
  if FCols <> N then
  begin
    FCols := N;
    ResizeBuffer;
  end;
end;

procedure TConsole.SetRows(N: Integer);
begin
  if FRows <> N then
  begin
    FRows := N;
    ResizeBuffer;
  end;
end;

procedure TConsole.SetFont(F: TFixedFont);
begin
  FFont.Assign(F);
end;

procedure TConsole.FontChanged(Sender: TObject);
var
  DC: HDC;
  Save: THandle;
  Metrics: TTextMetric;
  Temp: String;
begin
  if Font.Handle <> FOldFont.Handle then
  begin
    DC := GetDC(0);
    Save := SelectObject(DC, Font.Handle);
    GetTextMetrics(DC, Metrics);
    SelectObject(DC, Save);
    ReleaseDC(0, DC);
    if (coFixedPitchOnly in Options) and
      not (((Metrics.tmPitchAndFamily and ff_Modern) <> 0) and
          ((Metrics.tmPitchAndFamily and $01) = 0)) then
    begin
      Temp := 'TConsole: ' + Font.Name + ' is not fixed-pitch';
      Font.Name := FOldFont.Name;  { Keep other attributes of font }
      raise EInvalidFont.Create(Temp);
    end;
    SetMetrics(Metrics);
  end;
  FOldFont.Assign(Font);
  if csDesigning in ComponentState then
    InternalClrScr;
end;

{ If the character cell is different, accept changes and redraw }
procedure TConsole.SetMetrics(const Metrics: TTextMetric);
begin
  with Metrics do
  begin
    FCharSize.X := tmAveCharWidth;
    FCharSize.Y := tmHeight + tmExternalLeading;
    FCharAscent := tmAscent;
    FOverhang   := Max(tmOverhang, tmMaxCharWidth - tmAveCharWidth);
    Invalidate;
    RecalcSizeAndRange;
  end;
end;

procedure TConsole.RecalcSizeAndRange;
begin
  if HandleAllocated then
  begin
    FClientSize.X := ClientWidth div FCharSize.X;
    FClientSize.Y := ClientHeight div FCharSize.Y;
    FRange.X := Max(0, Cols - FClientSize.X);
    FRange.Y := Max(0, Rows - FClientSize.Y);
    ScrollTo(Min(FOrigin.X, FRange.X), Min(FOrigin.Y, FRange.Y));
    SetScrollBars;
  end;
end;

procedure TConsole.SetName(const NewName: TComponentName);
begin
  inherited SetName(NewName);
  if csDesigning in ComponentState then
    ClrScr;
end;


{ Return pointer to text location in screen buffer }
{ Always call ScreenPtr to get the next line you want, since the
  circular text buffer may wrap around between lines N and N+1.
  For the same reason, do not do pointer arithmetic between rows. }

function TConsole.ScreenPtr(X, Y: Integer): PAnsiChar;
begin
  Inc(Y, FFirstLine);
  if Y >= Rows then Dec(Y, Rows);
  Result := @FBuffer[Y * Cols + X];
end;

{ Update text on cursor line }

procedure TConsole.ShowText(L, R: Integer);
var
  B: TRect;
begin
  if HandleAllocated and (L < R) then
  begin
    B.Left := (L - FOrigin.X) * FCharSize.X;
    B.Top  := (Cursor.Y - FOrigin.Y) * FCharSize.Y;
    B.Right:= (R - FOrigin.X) * FCharSize.X + FOverhang;
    B.Bottom := B.Top + FCharSize.Y;
    InvalidateRect(Handle, @B, False);
    if not (coLazyWrite in Options) then
      Update;
  end;
end;

{ Show caret }

procedure TConsole.ShowCursor;
begin
  if not HandleAllocated then Exit;
  CreateCaret(Handle, 0, FCharSize.X, 2);
  SetCaretPos((Cursor.X - FOrigin.X) * FCharSize.X,
    (Cursor.Y - FOrigin.Y) * FCharSize.Y + FCharAscent);
  ShowCaret(Handle);
end;

{ Hide caret }

procedure TConsole.HideCursor;
begin
  DestroyCaret;
end;

{ Set cursor position }

procedure TConsole.CursorTo(X, Y: Integer);
begin
  Cursor.X := Max(0, Min(X, Cols - 1));
  Cursor.Y := Max(0, Min(Y, Rows - 1));
  if FFocused and (FReading or (coFullTimeCursor in Options)) then
    ShowCursor;
end;

{ Request asynchronous (lazy) ScrollBy, or update pending request }

procedure TConsole.LazyScrollBy(dx, dy: Integer);
var
  Msg: TMsg;
begin
  if (coLazyWrite in Options) and HandleAllocated then
  begin
    if PeekMessage(Msg, Handle, cm_ScrollBy,
         cm_ScrollBy, PM_NoYield or PM_Remove) then
    begin
      Inc(dx, Msg.WParam);
      Inc(dy, Msg.LParam);
    end;          { Flush accumulated scroll when delta >= half a screen }
    if (Abs(dx) >= Min(FClientSize.X, Cols) div 2) or
       (Abs(dy) >= Min(FClientSize.Y, Rows) div 2) then
      Perform(CM_ScrollBy, dx, dy)
    else
      if (dx or dy) <> 0 then
        PostMessage(Handle, cm_ScrollBy, dx, dy);
  end
  else
    Perform(CM_ScrollBy, dx, dy);
end;

{ Respond to asynchronous (lazy) ScrollBy request }

procedure TConsole.CMScrollBy(var M: TCMScrollBy);
begin
  ScrollTo(FOrigin.X + M.dx, FOrigin.Y + M.dy);
end;


{ Scroll window to given origin }
{ If font has overlapping cells (ie, italic), additional work is done to
  remove the residual overlapped pixels from the leftmost column.
  Using the clip rect with ScrollWindowEx helps eliminate pixel flicker in
  the left column.  }
procedure TConsole.ScrollTo(X, Y: Integer);
var
  R: TRect;
  OldOrigin: TPoint;
begin
  X := Max(0, Min(X, FRange.X));
  Y := Max(0, Min(Y, FRange.Y));
  if (X <> FOrigin.X) or (Y <> FOrigin.Y) then
  begin
    OldOrigin := FOrigin;
    FOrigin.X := X;
    FOrigin.Y := Y;
    if HandleAllocated then
    begin
      R := ClientRect;
      if X > OldOrigin.X then Inc(R.Left, FOverhang);
      if Y > OldOrigin.Y then R.Bottom := FClientSize.Y * FCharSize.Y;
      ScrollWindowEx(Handle,
       (OldOrigin.X - X) * FCharSize.X,
       (OldOrigin.Y - Y) * FCharSize.Y, nil, @R, 0, @R, 0);
      if Y <> OldOrigin.Y then
      begin
        SetScrollPos(Handle, sb_Vert, Y, True);
        if Y > OldOrigin.Y then
        begin
          InvalidateRect(Handle, @R, False);
          Update;
          R.Top := R.Bottom;
          R.Bottom := ClientRect.Bottom;
        end;
      end;
      if X <> OldOrigin.X then
      begin
        SetScrollPos(Handle, sb_Horz, X, True);
        if (FOverhang > 0) then
        begin
          if (X < OldOrigin.X) then { Scroll right - left edge repaint }
          begin
          { Add overhang to invalidation rect to redraw leftmost char pair }
            R.Left := 0;
            R.Right := Max(R.Right, (OldOrigin.X - X) * FCharSize.X + FOverhang);
          end
          else    { Scroll left - right edge repaint }
          begin
            { Redraw leftmost chars to remove prev chars' overhang }
            InvalidateRect(Handle, @R, False);
            Update;   { Update right side, before invalidating left side }
            R.Left := 0;
            R.Top  := 0;
            R.Right := FOverhang;
            R.Bottom := ClientHeight;
          end;
        end;
      end;
      InvalidateRect(Handle, @R, False);
      Update;
    end;
  end;
end;

{ Request asynchronous (lazy) TrackCursor, if not already pending }

procedure TConsole.LazyTrackCursor;
var
  Msg: TMsg;
begin
  if (coLazyWrite in Options) and HandleAllocated then
  begin   { Only post msg if there is not one already in the queue }
    if not PeekMessage(Msg, Handle, cm_TrackCursor,
             cm_TrackCursor, PM_NoYield or PM_NoRemove) then
      PostMessage(Handle, cm_TrackCursor, 0, 0);
  end
  else
    TrackCursor;
end;

{ Respond to asynchronous (lazy) TrackCursor request }

procedure TConsole.CMTrackCursor(var M);
begin
  TrackCursor;
end;

{ Scroll to make cursor visible (synchronous - immediate update)}

procedure TConsole.TrackCursor;
begin
  ScrollTo(Max(Cursor.X - FClientSize.X + 1, Min(FOrigin.X, Cursor.X)),
    Max(Cursor.Y - FClientSize.Y + 1, Min(FOrigin.Y, Cursor.Y)));
end;

{ Update scroll bars }

procedure TConsole.SetScrollBars;
begin
  if not HandleAllocated then Exit;
  SetScrollRange(Handle, sb_Horz, 0, Max(1, FRange.X), False);
  SetScrollPos(Handle, sb_Horz, FOrigin.X, True);
  SetScrollRange(Handle, sb_Vert, 0, Max(1, FRange.Y), False);
  SetScrollPos(Handle, sb_Vert, FOrigin.Y, True);
end;

{ Clear screen }

procedure TConsole.InternalClrScr;
begin
  WriteFill(0,0,' ',Cols * Rows);
  FOrigin.X := 0;
  FOrigin.Y := 0;
  Cursor.X := 0;
  Cursor.Y := 0;
  if (csDesigning in ComponentState) then
    WriteString(Name);
  Invalidate;
end;

procedure TConsole.ClrScr;
begin
  InternalClrScr;
  RecalibrateFont;
end;

procedure TConsole.RecalibrateFont;
begin
  FCharSize.X := 0;
  FCharSize.Y := 0;
  FCharAscent := 0;
  FOverhang := 0;
  FOldFont.Handle := 0;
  FOldFont.Size := 0;
  FontChanged(FFont);   { This will force a repaint and recalibrate }
end;

{ Clear to end of line }

procedure TConsole.ClrEol;
begin
  WriteFill(Cursor.X, Cursor.Y, ' ', Cols - Cursor.X);
  ShowText(Cursor.X, Cols);
end;


procedure TConsole.WriteBlock(X,Y: Integer; Buffer: PAnsiChar; Count: Cardinal);
begin
  Move(Buffer^, ScreenPtr(X,Y)^, Count);
end;


{ Write text buffer to CRT window
   - Process any special characters in buffer
   - Insert line breaks
}
procedure TConsole.WriteBuf(Buffer: PAnsiChar; Count: Cardinal);
var
  L, R: Integer;

  procedure Return;
  begin
    L := 0;
    R := 0;
    Cursor.X := 0;
  end;

  procedure LineFeed;
//  var
//    Rect: TRect;
  begin
    Inc(Cursor.Y);
    if Cursor.Y = Rows then
    begin
      Dec(Cursor.Y);
      Inc(FFirstLine);
      if FFirstLine = Rows then FFirstline := 0;
      WriteFill(0, Cursor.Y, ' ', Cols);
      Dec(FOrigin.Y, 1);
      LazyScrollBy(0, 1);
    end;
  end;

var
  BlockEnd, BlockLen, BlockStart: Integer;
  P: PAnsiChar;

begin
  L := Cursor.X;
  R := Cursor.X;
  while Count > 0 do
  begin
    BlockEnd := Min(Cols - Cursor.X, Count);
    P := Buffer;
    BlockStart := BlockEnd;
    while (BlockEnd > 0) and (Buffer^ in [#32..#255]) do
    begin
      Inc(Buffer);
      Dec(BlockEnd);
    end;
    BlockLen := BlockStart - BlockEnd;
    if BlockLen > 0 then
    begin
      Dec(Count, BlockLen);
      WriteBlock(Cursor.X, Cursor.Y, P, BlockLen);
      Inc(Cursor.X, BlockLen);
      if Cursor.X > R then R := Cursor.X;

      if (BlockEnd = 0) and (Cursor.X >= Cols) then
      begin
        ShowText(L,R);
        Return;
        LineFeed;
        Continue;
      end;
    end;

    if Count > 0 then
    begin
      case Buffer^ of
        #13: begin
              ShowText(L,R);
              Return;
              if LineBreak = CR then LineFeed;
            end;
        #10: begin
              ShowText(L,R);
              if LineBreak = LF then Return;
              LineFeed;
            end;
	      #8: if Cursor.X > 0 then
            begin
              Dec(Cursor.X);
              WriteFill(Cursor.X, Cursor.Y, ' ', 1);
              if Cursor.X < L then L := Cursor.X;
            end;
        #7: MessageBeep(0);
      end;
      Inc(Buffer);
      Dec(Count);
    end;
  end;
  ShowText(L, R);
  if coAutoTracking in Options then
    LazyTrackCursor;
  if FFocused and (coFullTimeCursor in Options) then
    ShowCursor;
end;

procedure TConsole.WriteCodedBuf(Buffer: PAnsiChar; Count: Cardinal);
begin
  if Assigned(FProcessControlCodes) then
    FProcessControlCodes(Self, Buffer, Count)
  else
    WriteBuf(Buffer, Count);
end;

{ Write character to CRT window }

procedure TConsole.WriteChar(Ch: AnsiChar);
begin
  WriteCodedBuf(@Ch, 1);
end;

procedure TConsole.WriteString(const S: String);
var
   S2: AnsiString;
begin
   S2 := AnsiString(S);
   WriteCodedBuf(@S2[1], Length(S2));
end;

procedure TConsole.WriteFill(X,Y: Integer; Ch: AnsiChar; Count: Cardinal);
var
  I: Integer;
begin
  if Count = 0 then Exit;
  if (Int64(X) + Int64(Count)) > Cols then
  begin
    FillChar(ScreenPtr(X,Y)^, Cols - X, Ch);
    Dec(Count, Cols - X);
    I := Cols;
    while Count > 0 do
    begin
      Inc(Y);
      FillChar(ScreenPtr(X,Y)^, I, Ch);
      Dec(Count, I);
    end;
  end
  else
    FillChar(ScreenPtr(X,Y)^, Count, Ch);
end;

{ Return keyboard status }

function TConsole.KeyPressed: Boolean;
begin
  Result := FKeyCount > 0;
  if (not Result) then
  begin
    Application.ProcessMessages;
    Result := FKeyCount > 0;
  end;
end;

{ Read key from CRT window }

function TConsole.ReadKey: AnsiChar;
begin
  TrackCursor;
  if not KeyPressed then
  begin
    SetFocus;
    if FReading or ReadActive then
      raise EInvalidOperation.Create('Read already active');
    try
      FReading := True;
      ReadActive := True;
      if FFocused then ShowCursor;
      repeat
        Application.HandleMessage
      until Application.Terminated or (FKeyCount > 0);
      if Application.Terminated then
        raise Exception.Create('WM_Quit received during ReadKey');
    finally
      if FFocused and not (coFullTimeCursor in Options) then
        HideCursor;
      FReading := False;
      ReadActive := False;
    end;
  end;
  ReadKey := FKeyBuffer[0];
  Dec(FKeyCount);
  Move(FKeyBuffer[1], FKeyBuffer[0], FKeyCount);
end;

{ Read text buffer from CRT window }

function TConsole.ReadBuf(Buffer: PAnsiChar; Count: Cardinal): Cardinal;
var
  Ch: AnsiChar;
  I: Cardinal;
begin
  I := 0;
  repeat
    Ch := ReadKey;
    case Ch of
      #8:
        if I > 0 then
        begin
          Dec(I);
          WriteChar(#8);
        end;
      #32..#255:
        if I < Count - 2 then
        begin
          Buffer[I] := Ch;
          Inc(I);
          WriteChar(Ch);
        end;
    end;
  until (Ch in [#0,#13]) or ((coCheckEOF in Options) and (Ch = #26));
  Buffer[I] := Ch;
  Inc(I);
  if Ch = #13 then
  begin
    Buffer[I] := #10;
    Inc(I);
    WriteBuf(#13#10,2);
  end;
  TrackCursor;
  ReadBuf := I;
  if FFocused and (coFullTimeCursor in Options) then ShowCursor;
end;


{ Text file device driver output function }

function CrtOutput(var F: TTextRec): Integer; far;
begin
  if F.BufPos <> 0 then
  with TObject((@F.UserData)^) as TConsole do
  begin
    WriteCodedBuf(PAnsiChar(F.BufPtr), F.BufPos);
    F.BufPos := 0;
  end;
  CrtOutput := 0;
end;

{ Text file device driver input function }

function CrtInput(var F: TTextRec): Integer; far;
begin
  with TObject((@F.UserData)^) as TConsole do
    F.BufEnd := ReadBuf(PAnsiChar(F.BufPtr), F.BufSize);
  F.BufPos := 0;
  CrtInput := 0;
end;

{ Text file device driver close function }

function CrtClose(var F: TTextRec): Integer; far;
begin
  CrtClose := 0;
end;

{ Text file device driver open function }

function CrtOpen(var F: TTextRec): Integer; far;
begin
  if F.Mode = fmInput then
  begin
    F.InOutFunc := @CrtInput;
    F.FlushFunc := nil;
  end else
  begin
    F.Mode := fmOutput;
    F.InOutFunc := @CrtOutput;
    F.FlushFunc := @CrtOutput;
  end;
  F.CloseFunc := @CrtClose;
  CrtOpen := 0;
end;

{ Assign text file to CRT device }

procedure TConsole.AssignCrt(var F: Text);
begin
  with TTextRec(F) do
  begin
    Handle := 0;
    Mode := fmClosed;
    BufSize := SizeOf(Buffer);
    BufPtr := @Buffer;
    OpenFunc := @CrtOpen;
    Move(Self, UserData[1],Sizeof(Pointer));
    Name[0] := #0;
  end;
end;

procedure TConsole.SetOptions(NewOptions: TConsoleOptions);
begin
  if not (csDesigning in ComponentState) then { don't open files at design time }
  begin
    if (coStdInput in (NewOptions - Options)) then
      with TTextRec(Input) do
      begin
        if (Mode <> fmClosed) and (Mode <> 0) then
          raise Exception.Create('TConsole.SetOptions: Standard Input is already open');
        AssignCrt(Input);
        Reset(Input);
        Include(FOptions, coStdInput);  { in case opening output fails }
      end
    else
      if (coStdInput in (Options - NewOptions)) then
        System.Close(Input);

    if (coStdOutput in (NewOptions - Options)) then
      with TTextRec(Output) do
      begin
        if (Mode <> fmClosed) and (Mode <> 0) then
          raise Exception.Create('TConsole.SetOptions: Standard Output is already open');
        AssignCrt(Output);
        Rewrite(Output);
      end
    else
      if (coStdOutput in (Options - NewOptions)) then
        System.Close(Output);
  end;
  FOptions := NewOptions;
end;


{ wm_Paint message handler }

procedure TConsole.Paint;
var
  X1, X2, Y1, Y2, PX, PY: Integer;
  R: TRect;
begin
  Canvas.Font := Font;
  Canvas.Brush.Color := Font.BkColor;
  SetViewportOrgEx(Canvas.Handle, -FOrigin.X * FCharSize.X, -FOrigin.Y * FCharSize.Y, nil);
  GetClipBox(Canvas.Handle, R);
  X1 := Max(FOrigin.X, (R.left - FOverhang) div FCharSize.X);
  X2 := Min(Cols, (R.right + FCharSize.X) div FCharSize.X);
  Y1 := Max(0, R.top div FCharSize.Y);
  Y2 := Min(Rows, (R.bottom + FCharSize.Y - 1) div FCharSize.Y);
  PX := X1 * FCharSize.X;
  PY := Y1 * FCharSize.Y;
  { Draw first line using ETO_Opaque and the entire clipping region. }
  ExtTextOutA(Canvas.Handle, PX, PY, ETO_Opaque, @R, ScreenPtr(X1, Y1), X2 - X1, nil);
  Inc(Y1);
  Inc(PY, FCharSize.Y);
  while Y1 < Y2 do
  begin
    { Draw subsequent lines without any background fill or clipping rect }
    ExtTextOutA(Canvas.Handle, PX, PY, 0, nil, ScreenPtr(X1, Y1), X2 - X1, nil);
    Inc(Y1);
    Inc(PY, FCharSize.Y);
  end;
end;

procedure TConsole.WMSize(var M: TWMSize);
//var
//  W,H: Integer;
begin
  if FFocused and (FReading or (coFullTimeCursor in Options)) then
    HideCursor;
  inherited;
  RecalcSizeAndRange;
  if FFocused and (FReading or (coFullTimeCursor in Options)) then
    ShowCursor;
end;


procedure TConsole.DoScroll(Which, Action, Thumb: Integer);
var
  X, Y: Integer;

  function GetNewPos(Pos, Page, Range: Integer): Integer;
  begin
    case Action of
      sb_LineUp: GetNewPos := Pos - 1;
      sb_LineDown: GetNewPos := Pos + 1;
      sb_PageUp: GetNewPos := Pos - Page;
      sb_PageDown: GetNewPos := Pos + Page;
      sb_Top: GetNewPos := 0;
      sb_Bottom: GetNewPos := Range;
      sb_ThumbPosition,
      sb_ThumbTrack    : GetNewPos := Thumb;
    else
      GetNewPos := Pos;
    end;
  end;

begin
  X := FOrigin.X;
  Y := FOrigin.Y;
  case Which of
    sb_Horz: X := GetNewPos(X, FClientSize.X div 2, FRange.X);
    sb_Vert: Y := GetNewPos(Y, FClientSize.Y, FRange.Y);
  end;
  ScrollTo(X, Y);
end;

procedure TConsole.WMHScroll(var M: TWMHScroll);
begin
  DoScroll(sb_Horz, M.ScrollCode, M.Pos);
end;

procedure TConsole.WMVScroll(var M: TWMVScroll);
begin
  DoScroll(sb_Vert, M.ScrollCode, M.Pos);
end;

procedure TConsole.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  if Key <> #0 then
  begin
    if (coCheckBreak in Options) and (Key = #3) then
      DoCtrlBreak;
    if FKeyCount < SizeOf(FKeyBuffer) then
    begin
      FKeyBuffer[FKeyCount] := AnsiChar(Key);
      Inc(FKeyCount);
    end;
  end;
end;

procedure TConsole.KeyDown(var Key: Word; Shift: TShiftState);
var
  I: Integer;
begin
  inherited KeyDown(Key, Shift);
  if Key = 0 then Exit;
  if (coCheckBreak in Options) and (Key = vk_Cancel) then
    DoCtrlBreak;
  for I := 1 to ScrollKeyCount do
    with ScrollKeys[I] do
      if (sKey = Key) and (Ctrl = (Shift = [ssCtrl])) then
      begin
        DoScroll(SBar, Action, 0);
        Exit;
      end;
end;

procedure TConsole.WMSetFocus(var M: TWMSetFocus);
begin
  FFocused := True;
  if FReading or (coFullTimeCursor in Options) then
    ShowCursor;
  inherited;
end;

procedure TConsole.WMKillFocus(var M: TWMKillFocus);
begin
  inherited;
  if FReading or (coFullTimeCursor in Options) then
    HideCursor;
  FFocused := False;
end;

procedure TConsole.WMGetDlgCode(var M: TWMGetDlgCode);
begin
  M.Result := dlgc_WantArrows or dlgc_WantChars;
end;

procedure TConsole.WMEraseBkgnd(var M: TWMEraseBkgnd);
begin
  M.Result := 1;
end;

procedure TConsole.DoCtrlBreak;
begin
end;

procedure TConsole.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  SetFocus;
  inherited MouseDown(Button, Shift, X, Y);
end;



{****************  TAttrManager  ****************}

constructor TAttr.Create(F: TFixedFont);
var
  DC: HDC;
  Save: THandle;
  TM: TTextMetric;
begin
  inherited Create;
  Assign(F);
  BkColor := F.BkColor;
  DC := GetDC(0);
  Save := SelectObject(DC, F.Handle);
  GetTextMetrics(DC, TM);
  SelectObject(DC, Save);
  ReleaseDC(0,DC);
  Overhang := TM.tmOverhang;
  Underhang := MulDiv(TM.tmDescent, TM.tmOverhang, TM.tmAscent);
end;


{****************  TAttrManager  ****************}

{ The list of free slots in the TAttrManager's FList is
  maintained in the unused pointer slots inside the FList.
  FFreeList is the index of the first free slot, or -1 if
  there are no free slots.  The pointer FList[FFreeList]
  contains the negative of the integer index of the next
  free slot, and so on. In 16 bit, this code assumes $FFFF
  will never appear as a selector.  In 32 bit, this code
  would assume FList indexes and pointers stored in the
  FList are positive (>=0) when evaluated as signed integers.
}

const
  EndOfList = -MaxInt;

constructor TAttrManager.Create;
begin
  inherited Create;
  FList := TList.Create;
end;

destructor TAttrManager.Destroy;
begin
  Clear;
  FList.Free;
  inherited Destroy;
end;

function TAttrManager.GetCount;
begin
  Result := FList.Count;
end;

procedure TAttrManager.SetFree(Index: Integer);
begin
  FList[Index] := nil;
end;

function TAttrManager.AllocIndex: Integer;
begin
  FList.Add(nil);
  Result := FList.Count - 1;
end;

function  TAttrManager.Allocate(F: TFixedFont): Integer;
var
  P: ^Pointer;
  H: THandle;
  C,B: TColor;
//  N: Integer;
begin
  Result := FCacheIndex;
  with F do
  begin
    C := Color;
    B := BkColor;
    H := Handle;
  end;
  if FCache <> nil then
  with FCache do
    if (Color = C) and (BkColor = B) and (Handle = H) then
      Exit;

  { Search for a match }
  Result := FList.Count;
  P := Pointer(FList.List);  { Use pointer iterator instead of For loop }
  while (Result > 0) do
  begin
    with TAttr(P^) do
      if (Color = C) and (BkColor = B) and (Handle = H) then
      begin
        FCache := TAttr(P^);
        Result := FList.Count - Result;
        FCacheIndex := Result;
        Exit;
      end;
    Inc(P);
    Dec(Result);
  end;

  { No match found, so create a new TAttr in an empty slot }
  Result := AllocIndex;
  Attr[Result] := TAttr.Create(F);
end;

procedure TAttrManager.Clear;
var
  I: Integer;
begin
  for I := 0 to FList.Count - 1 do begin
    TObject(FList[I]).Free;
  end;

  FList.Clear;
  FCacheIndex := 0;
  FCache := nil;
end;

procedure TAttrManager.Reference(Index: Integer; Delta: Integer);
begin
  with Attr[Index] do
  begin
    Inc(RefCount, Delta);
    if RefCount <= 0 then
      Attr[Index] := nil;
  end;
end;

function  TAttrManager.GetAttr(Index: Integer): TAttr;
begin
  Result := TAttr(FList[Index]);
end;

procedure TAttrManager.SetAttr(Index: Integer; NewAttr: TAttr);
begin
  if NewAttr = nil then
  begin
    TObject(FList[Index]).Free;
    SetFree(Index);
  end
  else
    if Index = FList.Count then
      FList.Expand.Add(NewAttr)
    else
      FList[Index] := NewAttr;
  FCacheIndex := Index;
  FCache := NewAttr;
end;


{ *************  TColorConsole *************** }

constructor TColorConsole.Create(Owner: TComponent);
begin
  FAttrList := TAttrManager.Create;
  inherited Create(Owner);
end;

destructor TColorConsole.Destroy;
begin
  inherited Destroy;
  AnsiStrings.StrDispose(PAnsiChar(FIndexes));
  FAttrList.Free;
  AnsiStrings.StrDispose(PAnsiChar(FCellWidths));
end;

function TColorConsole.IndexPtr(X,Y: Integer): PInteger;
begin
  Result := @FIndexes^[Longint(ScreenPtr(X,Y)) - Longint(FBuffer)];
end;

{ ResizeBuffer
   - Called by constructor to init buffers, and called by SetCols/SetRows
     when Cols or Rows change.  Cols and Rows will be set to their new
     values before ResizeBuffer is called.
   - StrAlloc will fail (raise xptn) if Cols * Rows is greater than 32k - 2
   - No attempt is made to preserve the contents of the buffers.  Resizing
   the buffers is equivallent to a ClrScr.
}

procedure TColorConsole.ResizeBuffer;
var
//  I: Integer;
  A: Integer;
  P: PInteger;
  P2: Pointer;
begin
  inherited ResizeBuffer;
  Pointer(P) := nil;
  P2 := nil;
  try
    Pointer(P) := StrAlloc(Longint(Cols) * Rows * Sizeof(Integer));
    P2 := StrAlloc(Cols * SizeOf(Integer));
    Exchange(Pointer(FIndexes), Pointer(P));
    Exchange(Pointer(FCellWidths), P2);
  finally
    AnsiStrings.StrDispose(PAnsiChar(P));
    AnsiStrings.StrDispose(PAnsiChar(P2));
  end;
  FAttrList.Clear;
  A := FAttrList.Allocate(Font);
  FillInt(FIndexes^, Cols * Rows, A);
  FAttrList.Reference(A, Cols * Rows );
  FillInt(FCellWidths^, Cols, FCharSize.X);
end;

{ If the character cell is larger, expand settings and redraw }
procedure TColorConsole.SetMetrics(const Metrics: TTextMetric);
var
  Changed: Boolean;
  I: Integer;
  A: TAttr;

  function Check(A, B: Longint): Longint;
  begin
    Result := A;
    if A < B then
    begin
      Result := B;
      Changed := True;
    end;
  end;

begin
    { Different fonts of the same point size have slightly different char
      cells.  Keep the global char cell large enough for all. }
  if FOldFont.Size = Font.Size then
  with Metrics do
  begin
    Changed := False;              { TT fonts don't report overhang }
    FOverhang := Check(FOverhang, Max(tmOverhang, tmMaxCharWidth - tmAveCharWidth));
    FCharSize.X := Check(FCharSize.X, tmAveCharWidth);
    FCharSize.Y := Check(FCharSize.Y, tmHeight + tmExternalLeading);
    FCharAscent := Check(FCharAscent, tmAscent);
    if Changed then
    begin
      if FCellWidths <> nil then
        FillInt(FCellWidths^, Cols, FCharSize.X);
      RecalcSizeAndRange;
      Invalidate;
    end;
  end
  else
  begin { If font size changed, accept new cell verbatim. }
	{ Update all cached fonts to new size }
    for I := 0 to FAttrList.Count - 1 do
    begin
      A:= FAttrList[I];
      if A <> nil then
        A.Size := Font.Size;
    end;
    if FCellWidths <> nil then
      FillInt(FCellWidths^, Cols, Metrics.tmAveCharWidth);
    inherited SetMetrics(Metrics);
  end;
end;


procedure TColorConsole.WriteFill(X,Y: Integer; Ch: AnsiChar; Count: Cardinal);
begin
  if Count = 0 then Exit;
  FillAttr(X,Y,Count);
  inherited WriteFill(X,Y,Ch,Count);  { write ch to the char buffer }
end;

procedure TColorConsole.FillAttr(X,Y: Integer; Count: Cardinal);

  procedure ReplaceAttr(A: Integer; P: PInteger; Count: Cardinal);
  var
    RunCount: Integer;
    RunValue: Integer;
  begin
    while Count > 0 do
    begin
      RunValue := P^;
      RunCount := 0;
      repeat
        P^ := A;
        Inc(P);
        Inc(RunCount);
      until (Int64(RunCount) >= Int64(Count)) or (P^ <> RunValue);
      FAttrList.Reference(RunValue, -RunCount);
      Dec(Count, RunCount);
    end;
  end;

var
  A: Integer;
  I: Integer;
begin
  A := FAttrList.Allocate(Font);
  FAttrList.Reference(A, Count);
  if (Int64(X) + Int64(Count)) > Cols then
  begin
    ReplaceAttr(A, IndexPtr(X,Y), Cols - X);
    Dec(Count, Cols - X);
    I := Cols;
    while Count > 0 do
    begin
      Inc(Y);
      ReplaceAttr(A, IndexPtr(X,Y), I);
      Dec(Count, I);
    end;
  end
  else
    ReplaceAttr(A, IndexPtr(X,Y), Count);
end;

procedure TColorConsole.WriteBlock(X,Y: Integer; Buffer: PAnsiChar; Count: Cardinal);
begin
  if Count = 0 then Exit;
  FillAttr(X,Y,Count);                     { fill range with current attr }
  inherited WriteBlock(X,Y,Buffer,Count);  { copy chars to char buf }
end;

procedure TColorConsole.Paint;
var
  X1, X2, Y1, Y2, RunValue, RunStart, RunEnd, Len, Count, Prev: Integer;
  R: TRect;
  P: PInteger;
  Buf: PAnsiChar;
  A: TAttr;
  C: TPoint;
  DC: HDC;
  L: Integer;
begin
  C := FCharSize;
  SetViewportOrgEx(Canvas.Handle, -FOrigin.X * FCharSize.X, -FOrigin.Y * C.Y, nil);
  GetClipBox(Canvas.Handle, R);
  X1 := Max(FOrigin.X, (R.left - FOverhang) div C.X);
  X2 := Min(Cols, (R.right + C.X) div C.X);
  Y1 := Max(0, R.top div C.Y);
  Y2 := Min(Rows, (R.bottom + C.Y - 1) div C.Y);
  if ((Cols * C.X) < R.Right) then
  begin
    Canvas.Brush := Brush;
    Count := R.Left;
    R.Left := Cols * C.X;
    Canvas.FillRect(R);
    R.Right := R.Left;
    R.Left := Count;
  end;
  if (Rows * C.Y) < R.Bottom then
  begin
    Canvas.Brush := Brush;
    R.Top := Rows * C.Y;
    Canvas.FillRect(R);
  end;
    { In this tight display loop, we don't need all the automatic services
      provided by TCanvas.  To optimize performance, we'll select the text
      font and colors into the DC 'manually'. }
  DC := Canvas.Handle;
  SetBkMode(DC, OPAQUE);
  SetTextAlign(DC, TA_BaseLine);
  R.Top := Y1 * C.Y;
  R.Bottom := R.Top + C.Y;
  Prev := -1;
  while Y1 < Y2 do
  begin
    Buf := ScreenPtr(X1,Y1);
    P := Pointer(IndexPtr(X1,Y1));
    Count := X2 - X1;
    R.Left := X1 * C.X;
    RunEnd := Integer(P) + Count * sizeof(Integer);
    while Count > 0 do
    begin
      RunStart := Integer(P);
      RunValue := P^;
      while (Integer(P) < RunEnd) and (P^ = RunValue) do
        Inc(P);
      Len := (Integer(P) - RunStart) div sizeof(Integer);
      Dec(Count, Len);
      if RunValue <> Prev then   { Only select objects when we have to }
      begin                      { (this helps at line breaks )        }
        A := FAttrList[RunValue];
        SelectObject(DC, A.Handle);
        SetTextColor(DC, ColorToRGB(A.Color));
        SetBkColor(DC, ColorToRGB(A.BkColor));
        Prev := RunValue;
      end
      else begin
        A := nil;
      end;
      R.Right := R.Left + Len * C.X;
      if Assigned(A) then begin
        L := R.Left - A.Underhang;
      end
      else begin
        L := R.Left;
      end;

      ExtTextOutA(DC, L, R.Top + FCharAscent,
        ETO_Opaque or ETO_Clipped, @R, Buf, Len, Pointer(FCellWidths));
      R.Left := R.Right;
      Inc(Buf, Len);
    end;
    Inc(Y1);
    Inc(R.Top, C.Y);
    Inc(R.Bottom, C.Y);
  end;
   { Since we've manipulated the DC directly, and the canvas may think its
     current objects are still selected, we should force the canvas to
     deselect all GDI objects }
  Canvas.Handle := 0;
end;


procedure Register;
begin
  RegisterComponents('Additional', [TConsole, TColorConsole]);
  RegisterClasses([TFixedFont]);
end;

end.


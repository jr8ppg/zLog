object formMain: TformMain
  Left = 0
  Top = 0
  Caption = 'zLog '#12461#12540#12456#12487#12451#12479
  ClientHeight = 465
  ClientWidth = 575
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 575
    Height = 419
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #12525#12462#12531#12464
      object vleLogging: TValueListEditor
        Left = 0
        Top = 0
        Width = 567
        Height = 391
        Align = alClient
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goRowSelect, goThumbTracking]
        Strings.Strings = (
          '#00 Quick QSY 1=Ctrl+F1'
          '#01 Quick QSY 2=Ctrl+F2'
          '#02 Quick QSY 3=Ctrl+F3'
          '#03 Quick QSY 4=Ctrl+F4'
          '#04 Quick QSY 5=Ctrl+F5'
          '#05 Quick QSY 6=Ctrl+F6'
          '#06 Quick QSY 7=Ctrl+F7'
          '#07 Quick QSY 8=Ctrl+F8'
          '#63 '#12458#12506#12524#12540#12479#22793#26356'=Alt+O'
          '#82 '#20132#20449#38283#22987'=TAB,;'
          '#83 '#20132#20449#32066#20102'=Down')
        TabOrder = 0
        TitleCaptions.Strings = (
          #27231#33021
          #12471#12519#12540#12488#12459#12483#12488#12461#12540)
        OnDblClick = vleDblClick
        ColWidths = (
          448
          113)
      end
    end
    object TabSheet2: TTabSheet
      Caption = #24773#22577#34920#31034
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object vleInformation: TValueListEditor
        Left = 0
        Top = 0
        Width = 567
        Height = 391
        Align = alClient
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goRowSelect, goThumbTracking]
        Strings.Strings = (
          '#08 '#12473#12540#12497#12540#12481#12455#12483#12463#12454#12452#12531#12489#12454#12398#34920#31034'=Ctrl+F10'
          '#09 Z-Link'#30011#38754#12398#34920#31034'=Ctrl+F12'
          '#18 '#12510#12523#12481#12481#12455#12483#12463#12434#12473#12486#12540#12479#12473#12496#12540#12395#34920#31034'=F9'
          '#19 '#12497#12540#12471#12515#12523#12481#12455#12483#12463#12454#12452#12531#12489#12454#12398#34920#31034'=F10'
          '#35 '#20132#20449#12522#12473#12488#12398#12501#12457#12531#12488#12469#12452#12474#12434#22823#12365#12367#12377#12427'=Ctrl+S'
          '#36 '#20132#20449#12522#12473#12488#12398#12501#12457#12531#12488#12469#12452#12474#12434#23567#12373#12367#12377#12427'=Shift+Ctrl+S'
          '#37 '#20132#20449#12522#12473#12488#12434#12506#12540#12472#12450#12483#12503'=PgUp'
          '#38 '#20132#20449#12522#12473#12488#12434#12506#12540#12472#12480#12454#12531'=PgDn'
          '#46 '#12497#12540#12471#12515#12523#12481#12455#12483#12463#12414#12383#12399#12473#12540#12497#12540#12481#12455#12483#12463#12398#26908#32034#32080#26524#21462#12426#36796#12415'=Ctrl+I'
          '#64 '#12497#12465#12483#12488#12463#12521#12473#12479#12454#12452#12531#12489#12454#12398#34920#31034'=Alt+P'
          '#65 '#12467#12510#12531#12489#20837#21147#12454#12452#12531#12489#12454#12398#34920#31034'=Alt+Q'
          '#67 '#12473#12463#12521#12483#12481#12471#12540#12488#12398#34920#31034'=Alt+S'
          '#70 Z-Server'#32076#30001#12398#12481#12515#12483#12488#12454#12452#12531#12489#12454#12398#34920#31034'=Alt+Z'
          '#72 '#12496#12531#12489#12473#12467#12540#12503#12398#34920#31034'='
          '#73 '#21608#27874#25968#12522#12473#12488#12398#34920#31034'='
          '#74 '#65332#65332#65337#12467#12531#12477#12540#12523#12398#34920#31034'='
          '#75 '#35299#26512#12454#12452#12531#12489#12454#12398#34920#31034'='
          '#76 '#12473#12467#12450#12454#12452#12531#12489#12454#12398#34920#31034'='
          '#77 '#12510#12523#12481#12454#12452#12531#12489#12454#12398#34920#31034'='
          '#78 QSO'#12524#12540#12488#12454#12452#12531#12489#12454#12398#34920#31034'='
          '#79 '#12467#12540#12523#12481#12455#12483#12463#12454#12452#12531#12489#12454#12398#34920#31034'='
          '#80 '#12510#12523#12481#12481#12455#12483#12463#12454#12452#12531#12489#12454#12398#34920#31034'='
          '#81 '#12459#12531#12488#12522#12540#12481#12455#12483#12463#12454#12452#12531#12489#12454#12398#34920#31034'=')
        TabOrder = 0
        TitleCaptions.Strings = (
          #27231#33021
          #12471#12519#12540#12488#12459#12483#12488#12461#12540)
        OnDblClick = vleDblClick
        ColWidths = (
          448
          96)
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'CW'#12461#12540#12452#12531#12464
      ImageIndex = 2
      object vleCWKeying: TValueListEditor
        Left = 0
        Top = 0
        Width = 567
        Height = 391
        Align = alClient
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goRowSelect, goThumbTracking]
        Strings.Strings = (
          '#10 '#12496#12531#12463'A'#12398#12513#12514#12522#20869#23481#12398#36865#20449'01=F1'
          '#11 '#12496#12531#12463'A'#12398#12513#12514#12522#20869#23481#12398#36865#20449'02=F2'
          '#12 '#12496#12531#12463'A'#12398#12513#12514#12522#20869#23481#12398#36865#20449'03=F3'
          '#13 '#12496#12531#12463'A'#12398#12513#12514#12522#20869#23481#12398#36865#20449'04=F4'
          '#14 '#12496#12531#12463'A'#12398#12513#12514#12522#20869#23481#12398#36865#20449'05=F5'
          '#15 '#12496#12531#12463'A'#12398#12513#12514#12522#20869#23481#12398#36865#20449'06=F6'
          '#16 '#12496#12531#12463'A'#12398#12513#12514#12522#20869#23481#12398#36865#20449'07=F7'
          '#17 '#12496#12531#12463'A'#12398#12513#12514#12522#20869#23481#12398#36865#20449'08=F8'
          '#20 '#12496#12531#12463'A'#12398'CQ2'#12398#36865#20449'=F11'
          '#21 '#12496#12531#12463'A'#12398'CQ3'#12398#36865#20449'=F12'
          '#22 '#12496#12531#12463'B'#12398#12513#12514#12522#20869#23481#12398#36865#20449'01=Shift+F1'
          '#23 '#12496#12531#12463'B'#12398#12513#12514#12522#20869#23481#12398#36865#20449'02=Shift+F2'
          '#24 '#12496#12531#12463'B'#12398#12513#12514#12522#20869#23481#12398#36865#20449'03=Shift+F3'
          '#25 '#12496#12531#12463'B'#12398#12513#12514#12522#20869#23481#12398#36865#20449'04=Shift+F4'
          '#26 '#12496#12531#12463'B'#12398#12513#12514#12522#20869#23481#12398#36865#20449'05=Shift+F5'
          '#27 '#12496#12531#12463'B'#12398#12513#12514#12522#20869#23481#12398#36865#20449'06=Shift+F6'
          '#28 '#12496#12531#12463'B'#12398#12513#12514#12522#20869#23481#12398#36865#20449'07=Shift+F7'
          '#29 '#12496#12531#12463'B'#12398#12513#12514#12522#20869#23481#12398#36865#20449'08=Shift+F8'
          '#30 '#12496#12531#12463'B'#12398'CQ2'#12398#36865#20449'=Shift+F11'
          '#31 '#12496#12531#12463'B'#12398'CQ3'#12398#36865#20449'=Shift+F12'
          '#53 '#12497#12489#12523#20837#21147#12398#38263#28857#12392#30701#28857#12398#21453#36578'=Ctrl+R'
          '#54 '#36899#32154#12461#12515#12522#12450#36865#20449'=Ctrl+T'
          '#57 '#36899#32154'CQ'#65288'F1'#12398#20869#23481#12398#36899#32154#36865#20449#65289#12289#20309#12363#20837#21147#12377#12427#12392#36865#20449#35299#38500'=Ctrl+Z'
          '#60 '#12461#12540#12508#12540#12489#12514#12540#12489'=Alt+K'
          '#86 '#65328#65332#65332#20986#21147#12398#65327#65326#65295#65327#65318#65318'=,\'
          '')
        TabOrder = 0
        TitleCaptions.Strings = (
          #27231#33021
          #12471#12519#12540#12488#12459#12483#12488#12461#12540)
        OnDblClick = vleDblClick
        ColWidths = (
          448
          96)
      end
    end
    object TabSheet4: TTabSheet
      Caption = #12522#12464#12467#12531#12488#12525#12540#12523
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object vleRigControl: TValueListEditor
        Left = 0
        Top = 0
        Width = 567
        Height = 391
        Align = alClient
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goRowSelect, goThumbTracking]
        Strings.Strings = (
          '#32 '#12496#12531#12489#12473#12467#12540#12503#12408#12398#25163#21205#30331#37682'=Ctrl+Enter'
          '#33 '#12496#12531#12489#12473#12467#12540#12503#12408#12398#25163#21205#30331#37682'=Ctrl+N'
          '#34 '#12496#12531#12489#12473#12467#12540#12503#12408#12398#25163#21205#30331#37682#24460#12289#12467#12540#12523#12469#12452#12531#27396#12392#12490#12531#12496#12540#27396#12434#12463#12522#12450#12375#12390#12467#12540#12523#12469#12452#12531#27396#12408#31227#21205'=Shift+Ctrl+N'
          '#68 '#12522#12464#12467#12531#12488#12525#12540#12523#12454#12452#12531#12489#12454#12398#34920#31034'=Alt+T'
          '#71 '#12522#12464#12398#20999#12426#26367#12360'=Alt+.')
        TabOrder = 0
        TitleCaptions.Strings = (
          #27231#33021
          #12471#12519#12540#12488#12459#12483#12488#12461#12540)
        OnDblClick = vleDblClick
        ColWidths = (
          448
          113)
      end
    end
    object TabSheet5: TTabSheet
      Caption = #20837#21147#12392#32232#38598
      ImageIndex = 4
      object vleEdit: TValueListEditor
        Left = 0
        Top = 0
        Width = 567
        Height = 391
        Align = alClient
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goRowSelect, goThumbTracking]
        Strings.Strings = (
          '#39 '#12501#12451#12540#12523#12489#12398#20808#38957#12395#31227#21205'=Ctrl+A'
          '#40 '#12459#12540#12477#12523#12434'1'#25991#23383#24038#12395#31227#21205'=Ctrl+B'
          '#41 '#12459#12540#12477#12523#20301#32622#12398'1'#25991#23383#12434#21066#38500'=Ctrl+D'
          '#42 '#12501#12451#12540#12523#12489#12398#26368#24460#12395#31227#21205'=Ctrl+E'
          '#43 '#12459#12540#12477#12523#12434'1'#25991#23383#21491#12395#31227#21205'=Ctrl+F'
          '#44 '#19968#26178#12513#12514#12522#12398#20869#23481#12434#20837#21147#12501#12451#12540#12523#12489#12395#21628#12403#20986#12375'=Ctrl+G'
          '#45 '#12459#12540#12477#12523#12398#24038#12398'1'#25991#23383#12434#21066#38500'=Ctrl+H'
          '#47 '#12459#12540#12477#12523#12424#12426#21491#12398#25991#23383#21015#12434#21066#38500'=Ctrl+J'
          '#48 '#12467#12540#12523#12469#12452#12531#12501#12451#12540#12523#12489#12392#12490#12531#12496#12540#12501#12451#12540#12523#12489#12398#20869#23481#12434#12377#12409#12390#21066#38500'=Ctrl+K'
          '#49 '#29694#22312#12496#12531#12489#12398#12415#34920#31034'=Ctrl+L'
          '#55 '#20840#12390#12398#20837#21147#12501#12451#12540#12523#12489#12398#20869#23481#12434#19968#26178#12513#12514#12522#12395#20445#23384#65288#26368#22823'5'#12388#65289'=Ctrl+U'
          '#56 '#12459#12540#12477#12523#20301#32622#12398#12501#12451#12540#12523#12489#12398#20869#23481#12434#12377#12409#12390#21066#38500'=Ctrl+W'
          '#59 '#12467#12540#12523#12469#12452#12531#12501#12451#12540#12523#12489#12395#31227#21205'=Alt+C'
          '#61 '#12513#12514#12501#12451#12540#12523#12489#12395#31227#21205'=Alt+M'
          '#62 '#12490#12531#12496#12540#12501#12451#12540#12523#12489#12395#31227#21205'=Alt+N'
          '#66 RST'#12501#12451#12540#12523#12489#12395#31227#21205'=Alt+R'
          '#69 '#12467#12540#12523#12469#12452#12531#12392#12490#12531#12496#12540#12434#12463#12522#12450#12375#12390#12467#12540#12523#12469#12452#12531#12501#12451#12540#12523#12489#12408#31227#21205'=Alt+W'
          '#85 '#26032#12375#12356#12503#12522#12501#12451#12483#12463#12473#12398#30331#37682'=,@')
        TabOrder = 0
        TitleCaptions.Strings = (
          #27231#33021
          #12471#12519#12540#12488#12459#12483#12488#12461#12540)
        OnDblClick = vleDblClick
        ColWidths = (
          448
          113)
      end
    end
    object TabSheet6: TTabSheet
      Caption = #20107#24460#20837#21147
      ImageIndex = 5
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object vlePostContest: TValueListEditor
        Left = 0
        Top = 0
        Width = 567
        Height = 391
        Align = alClient
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goRowSelect, goThumbTracking]
        Strings.Strings = (
          '#50 '#26178#21051#12501#12451#12540#12523#12489#12434'1'#20998#25147#12377'=Ctrl+O'
          '#51 '#26178#21051#12501#12451#12540#12523#12489#12434'1'#20998#36914#12417#12427'=Ctrl+P')
        TabOrder = 0
        TitleCaptions.Strings = (
          #27231#33021
          #12471#12519#12540#12488#12459#12483#12488#12461#12540)
        OnDblClick = vleDblClick
        ColWidths = (
          448
          113)
      end
    end
    object TabSheet7: TTabSheet
      Caption = #12381#12398#20182
      ImageIndex = 6
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object vleOther: TValueListEditor
        Left = 0
        Top = 0
        Width = 567
        Height = 391
        Align = alClient
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goRowSelect, goThumbTracking]
        Strings.Strings = (
          '#52 QTC'#36865#20449#65288'WAEDC'#12514#12540#12489#65289'=Ctrl+Q'
          '#58 '#35373#23450#12375#12383#12497#12473#12395#22806#37096#12496#12483#12463#12450#12483#12503'=Alt+B'
          '#84 '#65326#65327#65328'=Ctrl+M')
        TabOrder = 0
        TitleCaptions.Strings = (
          #27231#33021
          #12471#12519#12540#12488#12459#12483#12488#12461#12540)
        OnDblClick = vleDblClick
        ExplicitTop = -2
        ColWidths = (
          448
          113)
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 419
    Width = 575
    Height = 46
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      575
      46)
    object buttonOK: TButton
      Left = 348
      Top = 5
      Width = 106
      Height = 33
      Anchors = [akTop, akRight]
      Caption = 'OK'
      TabOrder = 0
      OnClick = buttonOKClick
    end
    object buttonCancel: TButton
      Left = 460
      Top = 5
      Width = 106
      Height = 33
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = #12461#12515#12531#12475#12523
      ModalResult = 2
      TabOrder = 1
      OnClick = buttonCancelClick
    end
  end
end

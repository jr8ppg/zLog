![image](https://img.shields.io/badge/Delphi-10.4-brightgreen)
![image](https://img.shields.io/github/v/release/jr8ppg/zLog?include_prereleases)
![image](https://img.shields.io/github/license/jr8ppg/zLog)
# zLog 令和 Edition

Amateur Radio Contest Logging Program

# Dependency
Delphi 10.4

# Requirement
Windows 10(64bit)

# Licence
This software is released under the MIT License.

# Authors
Yokobayashi Yohei, JARL Contest Committee, JR8PPG

# Document
There is no documentation for the developer.
開発のためのドキュメントはありません

zLog for Windowsは元東京大学アマチュア無線部JA1ZLOの横林洋平さんが開発した，
アマチュア無線コンテストロギングソフトです．
最後にアップデートされたのは2004年11月20日に公開されたzLog for Windows 2.2です．
それから15年が経過し、JARLコンテスト委員会の手によりMITライセンスによるオープンソースとして
公開されたものを令和Editionとして改良し公開したものです。

https://zlog.org/

------
# Delphi 10.4.2 Community Editionでのビルド方法

1. TeeChart Standard（Delphi付属）のインストール
   - Delphiインストール時に指定するか、インストール後にウェルカムページ内の「機能拡張」－「プラットフォーム＆拡張マネージャ」よりインストール。（「RAD Studio 追加オプション」ウインドウの「追加オプション」タブ内にある「TeeChart Standard」をチェックON）

2. ICS for VCL 8.65 のインストール
   - ウェルカムページの「GetItからアドオンを取得する」をクリック。
   - 「GetItパッケージマネージャ」ウインドウで「ICS for VCL 8.65」を選択し、「インストール」ボタンをクリック。
   - 後は画面の指示に従ってインストールする。

3. JEDI Code Library 3.4 のインストール

   - 既にDelphi 10.3がインストールされている場合は、先に10.3側でJEDI Code Libraryをアンインストールして下さい。
   - ウェルカムページの「GetItからアドオンを取得する」をクリック。
   - 「GetItパッケージマネージャ」ウインドウで「JEDI Code Library 3.4」を選択し、「インストール」ボタンをクリック。
   - 後は画面の指示に従ってインストールする。
   - RAD Studioを再起動するようにとのメッセージが出るので、Delphiを終了する。
   - 終了させるとJEDIインストーラがいるので、指示に従ってインストールを完了させる。
   - インストール後、Delphiを起動する。

4. JEDI Visual Component Library 3.9 のインストール

   - 既にDelphi 10.3がインストールされている場合は、先に10.3側でVisual Component Libraryをアンインストールして下さい。
   - ウェルカムページの「GetItからアドオンを取得する」をクリック。
   - 「GetItパッケージマネージャ」ウインドウで「JEDI Visual Component Library 3.9」を選択し、「インストール」ボタンをクリック。
   - 後は画面の指示に従ってインストールする。
   - RAD Studioを再起動するようにとのメッセージが出るので、Delphiを終了する。
   - 終了させるとJVCLインストーラがいるので、指示に従ってインストールを完了させる。
   - インストール後、Delphiを起動する。
   - 時間かかります。

5. JCL/JVCLがインストールできない場合
   - Delphi/C++Builder Community Edition 10.4.2を利用時、GetItパッケージマネージャ経由でJEDI/JVCLパッケージがインストールできない問題があることが判明しています。
   - その場合、Andreas Hausladen氏が用意しているコンパイル済みファイルをインストールすることで利用可能になります。  
 https://www.idefixpack.de/blog/bugfix-units/jedi-binary-installer/
   - 詳しい情報はこちらです。  https://docwiki.embarcadero.com/Support/ja/Delphi/C%2B%2BBuilder_Community_Edition_10.4.2%E3%82%92%E5%88%A9%E7%94%A8%E6%99%82%E3%80%81GetIt%E3%83%91%E3%83%83%E3%82%B1%E3%83%BC%E3%82%B8%E3%83%9E%E3%83%8D%E3%83%BC%E3%82%B8%E3%83%A3%E7%B5%8C%E7%94%B1%E3%81%A7JEDI/JVCL%E3%83%91%E3%83%83%E3%82%B1%E3%83%BC%E3%82%B8%E3%81%8C%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E3%81%A7%E3%81%8D%E3%81%AA%E3%81%84
   
6. zlog_requires のインストール

   - VCLフォルダのzlog_requires.dpkを開き、32ビットを選択しビルド→インストール。
   - 次に64ビットを選択しビルド。
   - ツール－オプション－言語－Delphiでライブラリのライブラリパスに VCLフォルダ\\$(Platform)\\Release を追加。32ビットと64ビットの両方に設定する。
      - ライブラリパス 例「C:\\github\\zLog\VCL\\$(Platform)\\Release」
      - デバッグ用DCUパス 例「C:\\github\\zLog\VCL\\$(Platform)\\Debug」
7. zlogフォルダのzlog_project.groupprojを開く
8. プロジェクトウインドウ一番上のzlog_projectを右クリックし「すべてビルド」をクリック
9. 完成

## オリジナルからの変更点

1. JARL ELOG 2.0に対応
2. LPTポート対応廃止
3. Windows7/10で目立つ不具合修正
4. FT-2000,ICOMのカタログ機種を追加
5. RIGコントロールのCOMポートをCOM1～COM20まで拡張
6. RIGコントロールの通信速度を設定可能に
7. パドル処理廃止
8. など

## 動作確認済みWindows

* Windows XP SP3 (32bit)
* Windows 7 Home (64bit)
* Windows 10 Home (64bit)
* Windows 10 Pro (64bit)

## 動作確認済みコンテスト

* ALL JAコンテスト
* 6m&DOWNコンテスト
* フィールドデイコンテスト
* 全市全郡コンテスト
* ALL JA8コンテスト(allja8.cfg)
* 東京UHFコンテスト(tokyo_uhf.cfg)
* ALL JA0コンテスト
* CQWW,CQWPX,AP Sprint,IARU HF
* など

## 動作確認済み機能

* Packet Cluster
* BandScope
* Z-Link
* COMポートによるCWキーイング
* USBIF4CWによるCWキーイング
* U5-Link(ICOM)によるRIGコントロールとCWキーイング
* WinKeyer USB V2.3/V3.1によるCWキーイング

## 動作確認済み無線機

### ICOM
* IC-706mkII,IC-756PRO,IC-756PRO2,IC-7100,IC-7200,IC-7300他
### KENWOOD
* TS-570,TS-590,TS-2000,TS-590G
### YAESU
* FT-2000/FT-950/FT-450/FTDX-5000
* FT-920
* FT-1000MP
* FT-991
* FT-847,FT-817

最新情報はこちら
https://github.com/jr8ppg/zLog/wiki/%E3%83%AA%E3%82%B0%E3%82%B3%E3%83%B3%E3%83%88%E3%83%AD%E3%83%BC%E3%83%AB

## 第三者著作権情報

* ICS - Internet Component Suite - V8 - Delphi 7 to RAD Studio 10.4 Sydney
```
This product includes software developed by François PIETTE
Copyright (C) 1997-2020 by François PIETTE
Rue de Grady 24, 4053 Embourg, Belgium
<francois.piette@overbyte.be>
http://www.overbyte.eu/frame_index.html?redirTo=/products/ics.html
```

* HemisphereButton
```
This product includes software developed by Christian Schnell
Copyright (c) 1997 Christian Schnell
```

* Text Console component
```
This product includes software developed by Danny Thorpe
Copyright (c) 1995,96 by Danny Thorpe
```

* JL's RotateLabel with 3D-effects
```
This product includes software developed by Joerg Lingner
Copyright (c) 1996 by Joerg Lingner, Munich, Germany
https://torry.net/files/vcl/labels/rotatedlabels/jllabel.zip
```

* TOvrEdit
```
This product includes software developed by Wolfgang Chien
Copyright (c) Wolfgang Chien
```

* TMgrid
```
This product includes software developed by Michael Tran
Copyright (c) 1998 by Michael Tran
```

* TCommPortDriver component
```
This product includes software developed by Marco Cocco
Copyright (c) Marco Cocco
```

* JEDI Visual Component Library/JEDI Code Library
```
This product includes software developed by Project JEDI
https://www.delphi-jedi.org/
```

![Image](https://img.shields.io/badge/Delphi-12.1-brightgreen)
![image](https://img.shields.io/github/v/release/jr8ppg/zLog?include_prereleases)
![image](https://img.shields.io/github/license/jr8ppg/zLog)
# zLog 令和 Edition

Amateur Radio Contest Logging Program

# Dependency
Delphi 12.1

# Requirement
Windows 11(64bit)

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
# Delphi 12.1 Community Editionでのビルド方法

1. TeeChart Standard（Delphi付属）のインストール
   - Delphiインストール時に指定するか、インストール後にウェルカムページ内の「機能拡張」－「プラットフォーム＆拡張マネージャ」よりインストール。（「RAD Studio 追加オプション」ウインドウの「追加オプション」タブ内にある「TeeChart Standard」をチェックON）

2. Delphi CE 12.1 Patch 1 1.0 のインストール
   - ウェルカムページの「GetItからアドオンを取得する」をクリック。
   - 「GetItパッケージマネージャ」ウインドウで「Delphi CE 12.1 Patch 1 1.0」を選択し、「インストール」ボタンをクリック。
   - 後は画面の指示に従ってインストールする。
     
3. ICS for VCL for Delphi 9.3 のインストール
   - ウェルカムページの「GetItからアドオンを取得する」をクリック。
   - 「GetItパッケージマネージャ」ウインドウで「ICS for VCL for Delphi 9.3」を選択し、「インストール」ボタンをクリック。
   - 後は画面の指示に従ってインストールする。

4. VCL Translation Support のインストール
   - ウェルカムページの「GetItからアドオンを取得する」をクリック。
   - 「GetItパッケージマネージャ」ウインドウで「VCL Translation Support 23.0.51961.7529」を選択し、「インストール」ボタンをクリック。
   - 後は画面の指示に従ってインストールする。

5. JEDI Code Library とJEDI Visual Component Library のインストール

   - Community Editionからdcc32.exeが除かれたためGetItからはインストールできません。
   - 次のページの手順で手作業でインストールする必要があります。かなり面倒です。  
   https://github.com/jr8ppg/zLog/wiki/Delphi12-Community-Ed.%E3%81%A7%E3%81%AEJEDI-JCL-JVCL%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E6%96%B9%E6%B3%95
   
6. zlog_requires のインストール

   - 今回Delphi12向けに変更があります。また、新たにTSunTimeコンポーネントを追加しました。
   - VCLフォルダのzlog_requires.dpkを開き、32ビットを選択しビルド→インストール。
   - 次に64ビットを選択しビルド。
   - ツール－オプション－言語－Delphiでライブラリのライブラリパスに VCLフォルダ\\$(Platform)\\Release を追加。32ビットと64ビットの両方に設定する。
      - ライブラリパス 例「C:\\github\\zLog\VCL\\$(Platform)\\Release」
      - デバッグ用DCUパス 例「C:\\github\\zLog\VCL\\$(Platform)\\Debug」
7. zlogフォルダのzlog_project.groupprojを開く
8. 「プロジェクト」－「Languages」－「Update Localized Projects」をクリック
9. プロジェクトウインドウのzlog.exeを右クリックし「ビルド」をクリック
10. プロジェクトウインドウのzlog.JPNを右クリックし「ビルド」をクリック
11. 完成
12. Release/Debug又はWin64/Win32を切り替えた際は、8.から順に再度行う。

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

* Windows 10 (64bit)
* Windows 11 (64bit)

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
* IC-706mkII,IC-756PRO,IC-756PRO2,IC-7100,IC-7200,IC-7300,IC-705,IC-905,IC-7851他
### KENWOOD
* TS-690/TS-570
* TS-2000,TS-590,TS-890,TS-990
### YAESU
* FT-2000/FT-950/FT-450/FTDX-3000,FTDX-5000,FTDX-9000,FTDX-101,FTDX-10
* FT-920
* FT-1000MP
* FT-991,FT-710
* FT-847,FT-817

など

最新情報はこちら
https://use.zlog.org/manual/%E3%83%AA%E3%82%B0%E3%82%B3%E3%83%B3%E3%83%88%E3%83%AD%E3%83%BC%E3%83%AB

## 第三者著作権情報

* ICS - Internet Component Suite - V9.3 - Delphi 7 to RAD Studio 12
```
This product includes software developed by François PIETTE
Copyright (C) 1997-2024 by François PIETTE
Rue de Grady 24, 4053 Embourg, Belgium
<francois.piette@overbyte.be>
http://www.overbyte.be/

SSL implementation includes code written by Arno Garrels,
Berlin, Germany, contact: <arno.garrels@gmx.de>
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

* TSunTime v1.11 -- Calculates times of sunrise, sunset, and solar noon.
```
This product includes software developed by Kambiz R. Khojasteh
http://www.delphiarea.com
```

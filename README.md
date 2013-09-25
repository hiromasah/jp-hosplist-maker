#保険医療機関一覧作成ツールとは
保険医療機関一覧作成ツールとは地方厚生局が公表している各都道府県の医療機関名簿のPDFから１医療機関１行でタブ区切りのフォーマットのテキストデータに変換するツールです。
なお、PDFファイルのテキスト変換部分については市販のソフトウェアを使用することを前提としております。

(追記 2011/05/02) 本ツールが処理の前提としておりましたジャストシステム社のJUSTPDFの販売が終了し、JUSTPDF2となりました。現状本ツールはJUSTPDF2では動作いたしません。
そこで、処理自体を行っているPerlのスクリプトを公開するのと同時に、自分の環境で処理をしたファイルを公開することといたしました。なお、変換作業は作者本人の必要に応じて実施しておりますので、ファイルの公開は不定期かつ作者が作成したタイミングのものに限られますのでご了承ください。

#作者
堀口　裕正 (hiromasa-tky@umin.ac.jp)

##利用方法
###準備するもの
*保険医療機関一覧作成用perlスクリプト （このページでダウンロードしてください）
*windowsでPerlのスクリプトが実行可能な環境
*JustSystem社製「JUSTPDF[データ変換]」　http://www.justsystems.com/jp/products/justpdf/feature4.html
**(注)ジャストシステム社には個人向けの「JUSTPDF」というソフトと法人向けの「JUSTPDF2」という２つのソフトがあります。今回のシステムでは「JUSTPDF」でしかうまく機能しません。調達の際、お気を付けください。
1.データPDFファイルの入手
地方厚生局のホームページ（下記リンク参照）の「主な業務」内「保険医療機関・保険薬局」のページにいき、各都道府県別に存在している「届出受理医療機関名簿」のPDFファイルを入手。
2.PDFをテキストファイルに変換
JUSTPDFにてPDFファイルをTXTファイルにデータ変換
3,変換したファイルをタブ区切りデータに変換
変換したTXTファイルと本ツールを同じフォルダーの中におき、perlのスクリプトを実行しますと、以下の４ファイルが作成されます。
*filename.data  変換したTXTファイル一覧
*data1.tsv 医療機関名簿
*data2.tsv 病床数情報
*data3.tsv 届出受理番号一覧
（注）同じフォルダー内に変換したTXTファイル以外のTXTファイルを置いたまま実行をするとおかしな処理を行います。

#保健医療機関処理済みデータ

作者が処理を行ったデータは東京大学医療経営政策学講座のホームページにおいてあります。

#ライセンス
本スクリプトについては、自由に使用・改造等を行うことができます。ただし、本スクリプトで発生するいかなる問題についても作者は関知しないこととします。

#現存する既知の問題
*PDF→Txtの変換がうまくいかないページがある（２０１０年８月１日分の静岡県で１ページ）
**これはJustPDFの問題であるため当方では解決・回避不能です。
*静岡県のデータの電話番号・Fax番号の処理がおかしい。
**これは静岡県のデータの一部が0XXX(XX)XXXX型の電話番号記載であることが問題をひきおこしています。ほかの都道府県および静岡県の一部は0XXX-XX-XXXX型で記載されています。現在処理方法の見直しを行い、静岡県の電話番号データも正常に取り込めるよう検討中です。
*さまざまなエラー処理、データ確認のプロセスを処理に入れてありません。

##FAQ
###なぜ、地方厚生局で公表されているPDFの中で「届出受理医療機関名簿」を使ったのですか？
全国の地方厚生局のうち、東海北陸厚生局 を除くすべての厚生局では「全医療機関一覧表」と「届出受理医療機関名簿」の２つを公表していますが、東海北陸厚生局は「届出受理医療機関名簿」のみが公開されています。そのため、このツールでは「届出受理医療機関名簿」を対象にファイルを作ることとしております。
###JUST PDFで処理をする際、いくつかの文字が読み込めない等の問題が発生していますがどうしたらよいですか?
JUST　PDFでのOCR処理の部分につきましては内部でどのような処理を行っているのかが不明ですので、この部分で起こったトラブルについては対応ができません。申し訳ありません。
###JUST PDFで作成したTXTファイルを読み込んだら、めちゃくちゃなファイルになってしまったがどうしたらよいですか。
地方厚生局がHPに公開しているPDFの仕様が変わる場合があり、その変更を事前に察知することはできません。また、各地方厚生局での出力の差がなぜ起こっているのかもわかりません。現時点では２０１０年８月３１日時点で各地方厚生局が公開していたPDFファイルが読み込め、処理ができることは確認していますが、今後については保証は出来かねます。

なお、このツールは作者本人の必要に迫られて作成されたものですので、作者本人がこのツールを研究活動で必要とする（データのアップデートを必要とする）限り、フォーマット変更には対応していく予定です。


##厚生局ホームページリンク
,url,厚生局名
,http://kouseikyoku.mhlw.go.jp/hokkaido/index.html,北海道厚生局
,http://kouseikyoku.mhlw.go.jp/tohoku/index.html, 東北厚生局 
,http://kouseikyoku.mhlw.go.jp/kantoshinetsu/index.html, 関東信越厚生局 
,http://kouseikyoku.mhlw.go.jp/tokaihokuriku/index.html, 東海北陸厚生局 
,http://kouseikyoku.mhlw.go.jp/kinki/index.html, 近畿厚生局
,http://kouseikyoku.mhlw.go.jp/chugokushikoku/index.html, 中国四国厚生局 
,http://kouseikyoku.mhlw.go.jp/shikoku/index.html,四国厚生支局
,http://kouseikyoku.mhlw.go.jp/kyushu/index.html, 九州厚生局 

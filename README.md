Livehubはライブのファン向けの記録WEBアプリです。

https://livehub-44b32f9de40f.herokuapp.com

ポートフォリオのアイデアに悩んでいたところ、元々ライブに行くことが趣味で、ライブ関係の情報を簡単に記録できるようなアプリがあれば良いと思い制作を始めました。

元々はライブ記録するだけの案だったのがアーティストや会場を登録、グッズなどの情報も紐付け統計を表示するという機能を持つように成りました。

実際に作っていると驚くほどたくさんのアイデア出てきて、時間に限りがなければすべて実装したいと思っているくらいです。

HTML
CSS
JavaScript
JQuery
Bootstrap

Ruby
Rails

Heoku
JawsDB MySQL

Git/GitHub

[ER図を見る](./erd.pdf)

![ライブ予定](./app/assets/images/shedules.png)

日付と会場が必須で他は任意。
会場の入力にはGoogle PLACE APIのオートコンプリート機能を実装しています。
チケットの購入状況によって入力フィールドの表示を切り替えます。

一覧表示ではチケットの購入状態やライブまでの日数を確認できます。

ライブ予定詳細ではGoogle mapへのリンクを用意しておりユーザーがクリックすることで位置が表示可能。

ライブ予定は予定日の当日にライブ記録にコピーされ、その後に自動的に削除されます。(深夜のイベントにも対応するために翌日のAM.3時頃に削除)
(Heroku schedualerによる定期処理）

![ライブ記録](./app/assets/images/records.png)
ライブ予定は基本的にはライブ予定と同じですが、チケットの購入状況など予定と記録で少し異なります。

![グッズ記録](./app/assets/images/goods.png)
カテゴリーと数が必須で他は任意。
カテゴリーはその他を選択すれば任意のカテゴリーを保存可能で、またカテゴリーは最後に使われた順になっています。(その他を選択することも可能) 
他にもグッズ記録は様々情報を紐づけることが可能です。
アーティストを選択することでそのアーティストに紐付いたメンバーを選択することが可能になります。
またライブ記録にアーティストが選択されていればそのアーティストが自動的に選択されます。

![統計](./app/assets/images/sti.png)
統計ではライブ記録とグッズ記録を元にライブや支出、アーティストなどの項目が表示可能です。
グラフにはchart.jsを使用しており、棒グラフと円グラフを表示しています。

またアーティスト登録では、ニックネームとニックネーム表示モードがあり切り替えることが可能です。
ジャンルやメンバーなどは統計でも使用されます。

今後実装したいもの
天気予報APIでライブ当日の天気予報を表示
ライブ記録で演奏曲などを簡単に追加できるように
食べたご飯や泊まった場所なども記録機能
場所へのチェックイン
アーティスト別やメンバー別の統計

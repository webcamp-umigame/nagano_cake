#ながのCAKE<br>
長野県にある小さな洋菓子店「ながのCAKE」の商品を通販するためのECサイト開発。
元々近隣住民が顧客だったが、昨年始めたInstagramから人気となり、全国から注文が来るようになった。
InstagramのDMやメールで通販の注文を受けていたが、情報管理が煩雑になってきたため、管理機能を含んだ通販サイトを開設しようと思い至った。

##通販について
* 通販では注文に応じて製作する受注生産型としている。
* 現在通販での注文量は十分に対応可能な量のため、1日の受注量に制限は設けない。
* 送料は1配送につき全国一律800円。
* 友人や家族へのプレゼントなど、注文者の住所以外にも商品を発送できる。
* 支払方法はクレジットカード、銀行振込から選択できる。

#開発環境
##使用言語
* Ruby on Rails (5.2.5)

##Gem
* 'devise'
* "refile", require: "refile/rails", github: 'manfe/refile'
* "refile-mini_magick"
* 'bootstrap', '~> 4.5'
* 'jquery-rails'
* 'font-awesome-sass', '~> 5.13'
* 'pry-byebug'
* 'jp_prefecture'
* 'kaminari','~> 1.2.1'
* 'rails-i18n'

#実装機能
##顧客側
| 機能 | 説明 | 非ログイン時<br>利用可否 |
| ---- | ----- | ----- | ---- |
| ログイン機能 | ・メールアドレス、パスワードでログインできる。<br>・ログイン時のみ利用できる機能が利用できるようになる。  | ○ |
| ログアウト機能 | ・ログインしている状態からログアウト状態にする。<br>・ログイン時のみ利用できる機能が利用できなくなる。 | × |
| 商品一覧表示機能 | ・商品を一覧表示する。<br>・検索結果を表示する場合は、検索条件に当てはまる商品のみ一覧表示する。 | ○ |
| 商品詳細情報表示機能 | ・商品一覧画面で選択した商品の詳細情報を表示する。<br>・カート追加機能が表示されている。  | ○ |
| カート追加機能 | ・カートに商品を追加することができる。  | × |
| カート一覧機能 | ・カートの中身を一覧表示することができる。  | × |
| カート編集機能 | ・カートの中身の個数を編集したり、削除したりすることができる。 | × |
| 注文機能 | ・カートの中身の購入をすることができる。<br>・支払方法や発送先を設定することができる。  | × |
| 会員情報編集機能 | ・登録している情報を編集することができる。  | × |
| 退会機能 | ・退会手続きをすることができる。  | × |
| 配送先追加・編集機能 | ・登録している配送先を一覧で確認することができる。<br>・配送先の新規追加・修正・削除をすることができる。 | × |
| 注文履歴一覧表示機能 | ・過去の注文概要を一覧で確認することができる。 | × |
| 注文履歴詳細表示機能 | ・注文の詳細（注文商品や個数など）を確認することができる。  | × |

##管理者側
| 機能 | 説明 | 非ログイン時<br>利用可否 |
| ---- | ----- | ----- | ---- |
| ログイン機能 | ・メールアドレス、パスワードでログインできる。<br>・ログイン時のみ利用できる機能が利用できるようになる。  | ○ |
| ログアウト機能 | ・ログインしている状態からログアウト状態にする。<br>・ログイン時のみ利用できる機能が利用できなくなる。 | × |
| 注文履歴一覧表示機能 | ・過去の注文概要を一覧で確認することができる。  | × |
| 注文履歴詳細表示機能 | ・注文の詳細（注文商品や個数など）を確認することができる。<br>・注文ステータス、製作ステータスを変更することができる。  | × |
| 顧客一覧表示機能 | ・顧客情報を一覧で確認することができる。  | × |
| 顧客詳細情報表示機能 | ・顧客の詳細情報を確認することができる。<br>・顧客のステータス（有効/退会）を切り替えることができる。 | × |
| 商品一覧表示機能 | ・登録商品を一覧で確認することができる。  | × |
| 商品詳細情報表示機能 | ・商品の詳細情報を確認することができる。 | × |
| 商品情報変更機能 | ・商品の登録情報を変更することができる。<br>・販売ステータスを変更することができる。  | × |
| ジャンル設定機能 | ・ジャンルの追加・変更を行うことができる。  | × |

#使用方法<br>
$ git clone git@github.com:webcamp-umigame/nagano_cake.git(SSH)<br>
$ git clone https://github.com/webcamp-umigame/nagano_cake.git(HTTP)<br>
$ cd NaganoCake<br>
$ bundle install<br>
$ rails db:migrate<br>
$ rails db:see

【管理者用アカウント】
メールアドレス：admin@admin
パスワード：111111

【顧客用アカウン】
新規登録からお進みください。

#開発者
チーム名
【ウミガメ】
メンバー
* ゆき
* ゆか
* あそ
* かや
